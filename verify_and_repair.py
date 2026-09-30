"""
Unified verify-and-repair pipeline for testbenches.

For each circuit, runs S1 → S2 → S3 with Gemini repair retries at each step:
  S1 (syntax):      run NgSPICE, check for parse errors
  S2 (convergence): check simulation converges and produces values
  S3 (sanity):      Gemini reviews measured values for correctness

If any step fails, Gemini repairs the SPICE and retries (up to --max-retries).

Usage:
    python verify_and_repair.py                        # all baker circuits
    python verify_and_repair.py --source rocktnet
    python verify_and_repair.py --circuit Chap11_LTspice_Fig11_10
    python verify_and_repair.py --max-retries 3
    python verify_and_repair.py --limit 10
    python verify_and_repair.py --resume               # skip already-done circuits
"""

import argparse
import json
import os
import re
import subprocess
import sys
import time
from collections import Counter

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))

from verify_testbenches import (
    run_ngspice,
    check_syntax,
    check_convergence,
    resolve_spice,
    parse_values,
    collect_circuits,
    PDK_LIB_PATH,
    NGSPICE_BIN,
    SPICE_DIR,
)

# Gemini subprocess setup
GEMINI_SCRIPT = os.path.join(SCRIPT_DIR, "test", "gemini_call_v2.py")
SAM3_PYTHON = "/home/idies/workspace/Storage/xyu1/persistent/pytorch_env/sam3_gcloud/bin/python3"
GEMINI_MODEL = "gemini-3.1-pro-preview"

FIXED_SPICE_DIR = os.path.join(SCRIPT_DIR, "verification_spice_fixed")
OUTPUT_DIR = os.path.join(SCRIPT_DIR, "verification_results")
OUTPUT_PATH = None  # set per source in main()


# ── Gemini call ──

def call_gemini(prompt, model=None):
    """Call gemini_call_v2.py via subprocess."""
    model = model or GEMINI_MODEL
    proc = subprocess.run(
        [SAM3_PYTHON, GEMINI_SCRIPT, "--model", model],
        input=prompt,
        capture_output=True,
        text=True,
        timeout=660,
    )
    if proc.returncode != 0:
        err_msg = proc.stderr.strip() or proc.stdout.strip() or "(no output)"
        raise RuntimeError(f"exit code {proc.returncode}: {err_msg[:500]}")
    try:
        result = json.loads(proc.stdout)
    except json.JSONDecodeError:
        raise RuntimeError(f"Bad JSON: {proc.stdout[:300]}")
    if not result.get("ok"):
        raise RuntimeError(f"Gemini API: {result.get('error', 'unknown')}")
    return result["text"]


def extract_spice_from_response(response_text):
    """Extract SPICE netlist from Gemini response."""
    text = response_text.strip()
    m = re.search(r"```(?:spice|ngspice|sp)?\s*\n(.*?)```", text, re.DOTALL)
    if m:
        text = m.group(1).strip()
    lines = text.split("\n")
    start = 0
    for i, line in enumerate(lines):
        if line.strip().startswith("*") or line.strip().lower().startswith("."):
            start = i
            break
    text = "\n".join(lines[start:])
    stripped = [l.strip().lower() for l in text.strip().split("\n")]
    if ".end" not in stripped:
        text = text.rstrip() + "\n.end\n"
    return text


# ── Prompts ──

REPAIR_SYSTEM_PROMPT = f"""\
You are an expert analog IC designer fixing NgSPICE testbenches for SKY130 PDK circuits.

## CRITICAL RULE — DO NOT MODIFY THE CIRCUIT:
The circuit netlist (transistor connections, device instances, .subckt definitions) is the GROUND TRUTH.
You must NEVER change:
  - Transistor/device instance lines (XM*, M*, R*, C*, L*, D*)
  - Node connections or pin assignments of any device
  - .subckt definitions or pin orders
  - Device model names or types (nfet ↔ pfet)
  - W/L sizing parameters (unless fixing unit format only, e.g. w=5u → w=5.0)
You may ONLY modify:
  - Voltage/current source stimuli (Vin, VDD, Vpulse, etc.)
  - .control / .endc block (meas, let, print, run, ac, dc, tran commands)
  - Analysis commands (.ac, .dc, .tran, .op)
  - .param lines for simulation parameters (NOT device sizing)
If the circuit itself produces bad values (e.g., very low gain), that is the circuit's true behavior — do NOT "fix" it by redesigning the circuit.

## Key SKY130 / NgSPICE rules:
1. PDK .lib line MUST be: .lib "{PDK_LIB_PATH}" tt
2. W/L values are in MICRONS (e.g., w=5.0 l=0.15), NOT SI (w=5u is WRONG)
3. Device models: sky130_fd_pr__nfet_01v8, sky130_fd_pr__pfet_01v8
4. NgSPICE .control block syntax:
   - `let` can only do math on existing vectors/scalars from simulation results
   - Use `meas` for measurements, not manual `let` expressions on undefined variables
   - `meas dc vsp when v(vout)=v(vin)` is valid
   - After `meas dc varname ...`, use `print varname` to access it
   - `db()` and `ph()` work on AC vectors: `let gain_db = db(v(vout))`
   - `-i(VDD)` is valid for current through voltage source VDD
5. The testbench MUST include: title line (starting with *), .lib, circuit netlist, stimuli, .control block, .endc, .end
6. Every subcircuit instance must match the .subckt pin count exactly
7. VDD is typically 1.8V for SKY130

## Your task:
Fix the SPICE testbench so it runs without errors in NgSPICE and correctly measures the target metrics.
Only modify stimulus, analysis commands, and the .control block — keep the circuit netlist exactly as-is.
Output ONLY the complete fixed SPICE netlist — no explanation, no markdown fences, just the raw SPICE text.
"""

SANITY_SYSTEM_PROMPT = """\
You are an expert analog IC designer reviewing NgSPICE simulation results for SKY130 PDK circuits.

Your task: check whether the measured values are correct and reasonable for the given circuit type.

Consider:
1. Are the measured metrics appropriate for this circuit type?
2. Are the values in a physically reasonable range?
   - Be aware of unit variations: testbenches may output power in µW, frequency in Hz or MHz, slew rate in V/µs or V/s
3. Does the testbench correctly measure what it claims to measure?
   - Check if stimulus (bias, AC source, transient input) is appropriate
   - Check if measurements target the correct nodes
4. Are there any red flags (e.g., gain of 0 for an amplifier, negative power)?

Respond in this exact JSON format:
{
  "verdict": "PASS" or "FAIL" or "WARN",
  "confidence": "high" or "medium" or "low",
  "issues": ["list of specific issues found, empty if PASS"],
  "notes": "one-line summary"
}

PASS = measurements look correct and reasonable
WARN = measurements might be OK but something is suspicious
FAIL = measurements are clearly wrong or testbench has errors
"""


def build_repair_prompt(circuit_name, circuit_type, description,
                        target_metrics, spice_text, errors, failed_step):
    """Build prompt for Gemini to repair a failing testbench."""
    parts = []
    parts.append(f"## Circuit: {circuit_name}")
    parts.append(f"Type: {circuit_type}")
    if description:
        parts.append(f"Description: {description}")

    if target_metrics:
        metric_list = []
        for m, info in target_metrics.items():
            unit = info.get("unit", "")
            desc = info.get("description", m)
            analysis = info.get("analysis_type", "")
            metric_list.append(f"  - {m}: {desc} [{unit}] ({analysis})")
        parts.append(f"\n## Target metrics to measure:\n" + "\n".join(metric_list))

    if spice_text:
        parts.append(f"\n## Current SPICE testbench (FAILING at {failed_step}):\n```\n{spice_text}\n```")

    if errors:
        parts.append(f"\n## Errors/issues:\n" + "\n".join(f"  - {e}" for e in errors))

    parts.append(f"\n## Instructions:")
    parts.append(f"Fix this testbench to run cleanly in NgSPICE and produce correct measurements.")
    parts.append(f"The .lib line must be exactly: .lib \"{PDK_LIB_PATH}\" tt")
    parts.append(f"W/L in microns (w=5.0 not w=5u). Default: w=5.0 l=0.15 for unknown sizes.")
    parts.append(f"All target metrics listed above should be measured and printed.")
    parts.append(f"Output ONLY the raw SPICE — no markdown, no explanation.")

    return "\n".join(parts)


def build_sanity_prompt(circuit_name, circuit_type, description,
                        target_metrics, measured_values, spice_text):
    """Build prompt for Gemini sanity check."""
    parts = []
    parts.append(f"## Circuit: {circuit_name}")
    parts.append(f"Type: {circuit_type}")
    if description:
        parts.append(f"Description: {description}")

    if target_metrics:
        parts.append("\n## Target metrics (what the testbench should measure):")
        for m, info in target_metrics.items():
            unit = info.get("unit", "")
            desc = info.get("description", m)
            parts.append(f"  - {m}: {desc} [{unit}]")

    if measured_values:
        parts.append("\n## Measured values from NgSPICE:")
        for k, v in measured_values.items():
            parts.append(f"  - {k} = {v:.6g}")
    else:
        parts.append("\n## No values measured (simulation produced no output)")

    if spice_text:
        parts.append(f"\n## SPICE testbench:\n```\n{spice_text}\n```")

    parts.append("\nAre these measurements correct and reasonable for this circuit type?")
    parts.append("Respond in the JSON format specified.")

    return "\n".join(parts)


def parse_gemini_verdict(response_text):
    """Extract verdict JSON from Gemini response."""
    text = response_text.strip()
    m = re.search(r"```(?:json)?\s*\n(.*?)```", text, re.DOTALL)
    if m:
        text = m.group(1).strip()
    m = re.search(r"\{.*\}", text, re.DOTALL)
    if m:
        try:
            return json.loads(m.group(0))
        except json.JSONDecodeError:
            pass
    return {"verdict": "UNKNOWN", "confidence": "low",
            "issues": ["Could not parse Gemini response"], "notes": response_text[:200]}


# ── Core: verify and repair one circuit ──

def run_and_check(sp_path):
    """Run NgSPICE on a .sp file, return (s1, s2, values, errors, elapsed)."""
    returncode, stdout, stderr, elapsed = run_ngspice(sp_path)

    if returncode == -1:
        return "FAIL", "unknown", {}, ["TIMEOUT"], elapsed

    syntax_errors = check_syntax(stdout, stderr)
    if syntax_errors:
        return "FAIL", "unknown", {}, syntax_errors[:5], elapsed

    conv_issues, values = check_convergence(stdout, stderr)

    if "no_convergence" in conv_issues or "singular_matrix" in conv_issues:
        return "PASS", "FAIL", values, conv_issues, elapsed

    if "no_values_produced" in conv_issues:
        return "PASS", "WARN", values, ["no values produced"], elapsed

    return "PASS", "PASS", values, [], elapsed


def _save_attempt_spice(source, name, step, status, spice_text, reasons=None, attempt=None):
    """Save SPICE file at each stage with status and reasons.

    Files are named like:
      s1_initial_FAIL.sp, s1_repair1_PASS.sp
      s2_initial_PASS.sp
      s3_initial_FAIL.sp, s3_repair1_PASS.sp

    A companion .txt file stores the reasons (errors/issues).
    """
    attempt_dir = os.path.join(FIXED_SPICE_DIR, source, "attempts", name)
    os.makedirs(attempt_dir, exist_ok=True)

    if attempt is not None:
        tag = f"{step}_repair{attempt}_{status}"
    else:
        tag = f"{step}_initial_{status}"

    sp_path = os.path.join(attempt_dir, f"{tag}.sp")
    with open(sp_path, "w") as f:
        f.write(spice_text)

    if reasons is not None:
        reason_path = os.path.join(attempt_dir, f"{tag}_reasons.txt")
        with open(reason_path, "w") as f:
            for r in reasons:
                f.write(f"- {r}\n")

    return os.path.relpath(sp_path, SCRIPT_DIR)


def verify_and_repair_one(source, name, json_path, max_retries=2):
    """Full pipeline for one circuit: S1 → S2 → S3, with repair at each step."""

    result = {
        "name": name,
        "source": source,
        "circuit_type": "",
        "s1_status": "unknown",  # S1: syntax check — NgSPICE parses without errors
        "s2_status": "unknown",  # S2: convergence — simulation runs and produces values
        "s3_status": "unknown",  # S3: sanity — Gemini confirms measurements are correct
        "attempts": [],
        "values": {},
        "final_spice": "",
        "total_gemini_calls": 0,
        "total_time": 0,
        "issues": [],
    }

    # Load JSON
    try:
        with open(json_path) as f:
            json_data = json.load(f)
    except Exception as e:
        result["s1_status"] = "FAIL"
        result["issues"] = [f"JSON load error: {e}"]
        return result

    if "_error" in json_data:
        result["s1_status"] = "SKIP"
        result["issues"] = ["extraction had error"]
        return result

    tb = json_data.get("step3_testbench", {})
    raw_spice = tb.get("spice", "")
    if not raw_spice:
        result["s1_status"] = "SKIP"
        result["issues"] = ["no SPICE testbench"]
        return result

    # Circuit metadata
    circuit_type = ""
    description = ""
    for key in ("step1_figure", "step1_analysis"):
        if key in json_data:
            circuit_type = json_data[key].get("circuit_type", "")
            description = json_data[key].get("description", "")
            break
    result["circuit_type"] = circuit_type
    target_metrics = json_data.get("step2_metrics", {})

    # Resolve SPICE
    try:
        current_spice = resolve_spice(raw_spice, json_data)
    except Exception as e:
        result["s1_status"] = "FAIL"
        result["issues"] = [f"resolve error: {e}"]
        return result

    t_start = time.time()

    # Write initial SPICE
    sp_dir = os.path.join(SPICE_DIR, source)
    os.makedirs(sp_dir, exist_ok=True)
    sp_path = os.path.join(sp_dir, f"{name}.sp")
    with open(sp_path, "w") as f:
        f.write(current_spice)

    repaired = False

    # ── S1: Syntax (NgSPICE parses without errors) ──
    print(f"  S1 (syntax)... ", end="", flush=True)
    s1, s2, values, errors, elapsed = run_and_check(sp_path)

    # Save initial SPICE with S1 result
    s1_reasons = errors if s1 != "PASS" else [f"S1 PASS: NgSPICE parsed without syntax errors ({elapsed:.1f}s, {len(values)} values)"]
    init_sp = _save_attempt_spice(source, name, "s1", s1, current_spice, reasons=s1_reasons)
    result["attempts"].append({
        "step": "S1_initial",
        "description": "S1 syntax check — does NgSPICE parse without errors",
        "status": s1,
        "errors": errors if s1 != "PASS" else [],
        "values_count": len(values),
        "elapsed_sec": round(elapsed, 2),
        "spice_file": init_sp,
    })

    if s1 == "PASS":
        print(f"PASS ({elapsed:.1f}s)", flush=True)
    else:
        print(f"FAIL", flush=True)
        for e in errors[:3]:
            print(f"    - {e}", flush=True)

        for attempt in range(1, max_retries + 1):
            print(f"  S1 repair [{attempt}/{max_retries}]... ", end="", flush=True)

            try:
                prompt = REPAIR_SYSTEM_PROMPT + "\n\n" + build_repair_prompt(
                    name, circuit_type, description, target_metrics,
                    current_spice, errors, "S1 syntax"
                )
                t0 = time.time()
                response = call_gemini(prompt)
                gt = round(time.time() - t0, 1)
                result["total_gemini_calls"] += 1
                print(f"Gemini done ({gt}s)... ", end="", flush=True)
            except Exception as e:
                print(f"Gemini ERROR: {e}", flush=True)
                result["total_gemini_calls"] += 1
                result["attempts"].append({
                    "step": f"S1_repair_{attempt}",
                    "description": "S1 repair — Gemini fixes syntax errors",
                    "status": "gemini_error",
                    "error": str(e),
                    "errors_sent_to_gemini": errors[:5],
                })
                result["issues"].append(f"S1 repair Gemini error: {e}")
                break

            current_spice = extract_spice_from_response(response)
            with open(sp_path, "w") as f:
                f.write(current_spice)

            s1, s2, values, errors, elapsed = run_and_check(sp_path)

            # Save repaired SPICE with result
            s1_rep_reasons = errors if s1 != "PASS" else [f"S1 PASS: syntax fixed by Gemini ({gt}s repair, {elapsed:.1f}s verify, {len(values)} values)"]
            rep_sp = _save_attempt_spice(source, name, "s1", s1, current_spice,
                                         reasons=s1_rep_reasons, attempt=attempt)
            result["attempts"].append({
                "step": f"S1_repair_{attempt}",
                "description": "S1 repair — Gemini fixes syntax errors",
                "status": s1,
                "gemini_time": gt,
                "errors": errors if s1 != "PASS" else [],
                "values_count": len(values),
                "elapsed_sec": round(elapsed, 2),
                "spice_file": rep_sp,
            })

            if s1 == "PASS":
                print(f"PASS ({elapsed:.1f}s)", flush=True)
                repaired = True
                break
            else:
                print(f"still FAIL", flush=True)
                for e in errors[:2]:
                    print(f"    - {e}", flush=True)

    result["s1_status"] = s1
    if s1 != "PASS":
        result["issues"] = errors
        result["total_time"] = round(time.time() - t_start, 1)
        return result

    # ── S2: Convergence (simulation runs and produces values) ──
    print(f"  S2 (convergence)... ", end="", flush=True)

    s2_reasons = errors if s2 not in ("PASS", "WARN") else [f"S2 {s2}: simulation converged and produced {len(values)} measurable values"]
    s2_init_sp = _save_attempt_spice(source, name, "s2", s2, current_spice, reasons=s2_reasons)
    result["attempts"].append({
        "step": "S2_initial",
        "description": "S2 convergence check — simulation runs and produces measurable values",
        "status": s2,
        "errors": errors if s2 not in ("PASS", "WARN") else [],
        "values_count": len(values),
        "values": {k: round(v, 6) for k, v in list(values.items())[:10]} if values else {},
        "spice_file": s2_init_sp,
    })

    if s2 == "PASS":
        print(f"PASS ({len(values)} values)", flush=True)
    elif s2 == "WARN":
        print(f"WARN (no values)", flush=True)
    else:
        print(f"FAIL", flush=True)
        for e in errors[:3]:
            print(f"    - {e}", flush=True)

        for attempt in range(1, max_retries + 1):
            print(f"  S2 repair [{attempt}/{max_retries}]... ", end="", flush=True)

            try:
                prompt = REPAIR_SYSTEM_PROMPT + "\n\n" + build_repair_prompt(
                    name, circuit_type, description, target_metrics,
                    current_spice, errors, "S2 convergence"
                )
                t0 = time.time()
                response = call_gemini(prompt)
                gt = round(time.time() - t0, 1)
                result["total_gemini_calls"] += 1
                print(f"Gemini done ({gt}s)... ", end="", flush=True)
            except Exception as e:
                print(f"Gemini ERROR: {e}", flush=True)
                result["total_gemini_calls"] += 1
                result["attempts"].append({
                    "step": f"S2_repair_{attempt}",
                    "description": "S2 repair — Gemini fixes convergence issues",
                    "status": "gemini_error",
                    "error": str(e),
                    "errors_sent_to_gemini": errors[:5],
                })
                result["issues"].append(f"S2 repair Gemini error: {e}")
                break

            current_spice = extract_spice_from_response(response)
            with open(sp_path, "w") as f:
                f.write(current_spice)

            s1, s2, values, errors, elapsed = run_and_check(sp_path)

            if s1 != "PASS":
                rep_sp = _save_attempt_spice(source, name, "s2", "broke_S1", current_spice,
                                             reasons=errors[:5], attempt=attempt)
                result["attempts"].append({
                    "step": f"S2_repair_{attempt}",
                    "description": "S2 repair — Gemini fixes convergence issues",
                    "status": "broke_S1",
                    "gemini_time": gt,
                    "elapsed_sec": round(elapsed, 2),
                    "errors": errors[:5],
                    "values_count": len(values),
                    "spice_file": rep_sp,
                })
                print(f"broke S1!", flush=True)
                errors = ["Repair broke syntax"] + errors
                continue

            s2_rep_reasons = errors if s2 not in ("PASS", "WARN") else [f"S2 {s2}: convergence fixed by Gemini ({gt}s repair, {len(values)} values)"]
            rep_sp = _save_attempt_spice(source, name, "s2", s2, current_spice,
                                         reasons=s2_rep_reasons, attempt=attempt)
            result["attempts"].append({
                "step": f"S2_repair_{attempt}",
                "description": "S2 repair — Gemini fixes convergence issues",
                "status": s2,
                "gemini_time": gt,
                "elapsed_sec": round(elapsed, 2),
                "errors": errors if s2 not in ("PASS", "WARN") else [],
                "values_count": len(values),
                "spice_file": rep_sp,
            })

            if s2 == "PASS":
                print(f"PASS ({len(values)} values)", flush=True)
                repaired = True
                break
            else:
                print(f"still FAIL", flush=True)
                for e in errors[:2]:
                    print(f"    - {e}", flush=True)

    result["s2_status"] = s2
    result["values"] = values
    if s2 not in ("PASS", "WARN"):
        result["issues"] = errors
        result["total_time"] = round(time.time() - t_start, 1)
        return result

    # ── S3: Sanity (Gemini confirms measurements are correct and reasonable) ──
    if not values:
        print(f"  S3 (sanity)... SKIP (no values)", flush=True)
        result["s3_status"] = "SKIP"
        skip_sp = _save_attempt_spice(source, name, "s3", "SKIP", current_spice,
                                      reasons=["no values to check"])
        result["attempts"].append({
            "step": "S3_initial",
            "description": "S3 sanity check — Gemini reviews if measurements are correct",
            "status": "SKIP",
            "reason": "no values to check",
            "spice_file": skip_sp,
        })
        result["total_time"] = round(time.time() - t_start, 1)
        if repaired:
            _save_fixed_spice(source, name, current_spice)
            result["final_spice"] = f"verification_spice_fixed/{source}/{name}.sp"
        return result

    print(f"  S3 (sanity)... ", end="", flush=True)
    try:
        t0 = time.time()
        sanity_prompt = SANITY_SYSTEM_PROMPT + "\n\n" + build_sanity_prompt(
            name, circuit_type, description, target_metrics, values, current_spice
        )
        response = call_gemini(sanity_prompt)
        gt = round(time.time() - t0, 1)
        result["total_gemini_calls"] += 1
        verdict = parse_gemini_verdict(response)
    except Exception as e:
        print(f"Gemini ERROR: {e}", flush=True)
        result["total_gemini_calls"] += 1
        result["s3_status"] = "ERROR"
        result["issues"].append(f"S3 Gemini error: {e}")
        result["attempts"].append({
            "step": "S3_initial",
            "description": "S3 sanity check — Gemini reviews if measurements are correct",
            "status": "gemini_error",
            "error": str(e),
            "spice_file": _save_attempt_spice(source, name, "s3", "ERROR", current_spice,
                                              reasons=[f"Gemini error: {e}"]),
        })
        result["total_time"] = round(time.time() - t_start, 1)
        if repaired:
            _save_fixed_spice(source, name, current_spice)
            result["final_spice"] = f"verification_spice_fixed/{source}/{name}.sp"
        return result

    s3 = verdict.get("verdict", "UNKNOWN")
    s3_conf = verdict.get("confidence", "low")
    s3_issues = verdict.get("issues", [])
    s3_notes = verdict.get("notes", "")

    s3_init_reasons = s3_issues if s3 not in ("PASS", "WARN") else [f"S3 {s3} ({s3_conf} confidence, {gt}s): {s3_notes}"]
    s3_init_sp = _save_attempt_spice(source, name, "s3", s3, current_spice, reasons=s3_init_reasons)
    result["attempts"].append({
        "step": "S3_initial",
        "description": "S3 sanity check — Gemini reviews if measurements are correct",
        "status": s3,
        "confidence": s3_conf,
        "issues": s3_issues,
        "notes": s3_notes,
        "gemini_time": gt,
        "values": {k: round(v, 6) for k, v in list(values.items())[:10]},
        "spice_file": s3_init_sp,
    })

    if s3 in ("PASS", "WARN"):
        print(f"{s3} ({s3_conf}, {gt}s)", flush=True)
        if s3_notes:
            print(f"    {s3_notes[:80]}", flush=True)
    else:
        print(f"FAIL ({s3_conf}, {gt}s)", flush=True)
        for iss in s3_issues[:3]:
            print(f"    - {iss}", flush=True)

        for attempt in range(1, max_retries + 1):
            print(f"  S3 repair [{attempt}/{max_retries}]... ", end="", flush=True)

            try:
                repair_errors = s3_issues + ([s3_notes] if s3_notes else [])
                prompt = REPAIR_SYSTEM_PROMPT + "\n\n" + build_repair_prompt(
                    name, circuit_type, description, target_metrics,
                    current_spice, repair_errors, "S3 sanity (measurements incorrect)"
                )
                t0 = time.time()
                response = call_gemini(prompt)
                gt = round(time.time() - t0, 1)
                result["total_gemini_calls"] += 1
                print(f"Gemini repair done ({gt}s)... ", end="", flush=True)
            except Exception as e:
                print(f"Gemini ERROR: {e}", flush=True)
                result["total_gemini_calls"] += 1
                result["attempts"].append({
                    "step": f"S3_repair_{attempt}",
                    "description": "S3 repair — Gemini fixes incorrect measurements",
                    "status": "gemini_error",
                    "error": str(e),
                    "issues_sent_to_gemini": s3_issues[:5],
                })
                result["issues"].append(f"S3 repair Gemini error: {e}")
                break

            current_spice = extract_spice_from_response(response)
            with open(sp_path, "w") as f:
                f.write(current_spice)

            # Re-verify S1+S2
            s1, s2, values, errors, elapsed = run_and_check(sp_path)

            if s1 != "PASS" or s2 not in ("PASS", "WARN"):
                broke = "syntax" if s1 != "PASS" else "convergence"
                rep_sp = _save_attempt_spice(source, name, "s3", f"broke_{broke}", current_spice,
                                             reasons=errors[:5], attempt=attempt)
                result["attempts"].append({
                    "step": f"S3_repair_{attempt}",
                    "description": "S3 repair — Gemini fixes incorrect measurements",
                    "status": f"broke_{broke}",
                    "gemini_time": gt,
                    "errors": errors[:5],
                    "spice_file": rep_sp,
                })
                print(f"broke S1/S2!", flush=True)
                s3_issues = [f"Previous repair broke {broke}"] + s3_issues
                continue

            if not values:
                rep_sp = _save_attempt_spice(source, name, "s3", "no_values", current_spice,
                                             reasons=["No values produced"], attempt=attempt)
                result["attempts"].append({
                    "step": f"S3_repair_{attempt}",
                    "description": "S3 repair — Gemini fixes incorrect measurements",
                    "status": "no_values",
                    "gemini_time": gt,
                    "spice_file": rep_sp,
                })
                print(f"no values!", flush=True)
                s3_issues = ["No values produced after repair"] + s3_issues
                continue

            # Re-check sanity
            print(f"re-checking sanity... ", end="", flush=True)
            try:
                t0 = time.time()
                sanity_prompt = SANITY_SYSTEM_PROMPT + "\n\n" + build_sanity_prompt(
                    name, circuit_type, description, target_metrics, values, current_spice
                )
                response = call_gemini(sanity_prompt)
                sgt = round(time.time() - t0, 1)
                result["total_gemini_calls"] += 1
                verdict = parse_gemini_verdict(response)
            except Exception as e:
                print(f"Gemini ERROR: {e}", flush=True)
                result["total_gemini_calls"] += 1
                rep_sp = _save_attempt_spice(source, name, "s3", "recheck_error", current_spice,
                                             reasons=[f"Sanity recheck error: {e}"], attempt=attempt)
                result["attempts"].append({
                    "step": f"S3_repair_{attempt}",
                    "description": "S3 repair — Gemini fixes incorrect measurements",
                    "status": "sanity_recheck_error",
                    "gemini_time": gt,
                    "error": str(e),
                    "spice_file": rep_sp,
                })
                break

            s3 = verdict.get("verdict", "UNKNOWN")
            s3_conf = verdict.get("confidence", "low")
            s3_issues = verdict.get("issues", [])
            s3_notes = verdict.get("notes", "")

            s3_rep_reasons = s3_issues if s3 not in ("PASS", "WARN") else [f"S3 {s3} ({s3_conf} confidence, {sgt}s): {s3_notes}"]
            rep_sp = _save_attempt_spice(source, name, "s3", s3, current_spice,
                                         reasons=s3_rep_reasons, attempt=attempt)
            result["attempts"].append({
                "step": f"S3_repair_{attempt}",
                "description": "S3 repair — Gemini fixes incorrect measurements",
                "status": s3,
                "confidence": s3_conf,
                "issues": s3_issues,
                "notes": s3_notes,
                "gemini_time": gt,
                "sanity_time": sgt,
                "values": {k: round(v, 6) for k, v in list(values.items())[:10]},
                "spice_file": rep_sp,
            })

            if s3 in ("PASS", "WARN"):
                print(f"{s3} ({s3_conf}, {sgt}s)", flush=True)
                repaired = True
                break
            else:
                print(f"still FAIL ({sgt}s)", flush=True)
                for iss in s3_issues[:2]:
                    print(f"    - {iss}", flush=True)

    result["s3_status"] = s3
    result["s3_issues"] = s3_issues
    result["s3_notes"] = s3_notes
    result["values"] = values

    # Save fixed SPICE if any repair was done
    if repaired:
        _save_fixed_spice(source, name, current_spice)
        result["final_spice"] = f"verification_spice_fixed/{source}/{name}.sp"

    result["total_time"] = round(time.time() - t_start, 1)
    return result


def _save_fixed_spice(source, name, spice_text):
    sp_dir = os.path.join(FIXED_SPICE_DIR, source)
    os.makedirs(sp_dir, exist_ok=True)
    sp_path = os.path.join(sp_dir, f"{name}.sp")
    with open(sp_path, "w") as f:
        f.write(spice_text)


# ── Main ──

def _set_model(model):
    global GEMINI_MODEL
    GEMINI_MODEL = model


def main():
    parser = argparse.ArgumentParser(description="Verify and repair testbenches (S1+S2+S3)")
    parser.add_argument("--source", choices=["baker", "rocktnet", "all"], default="baker")
    parser.add_argument("--circuit", type=str, default=None)
    parser.add_argument("--max-retries", type=int, default=3)
    parser.add_argument("--limit", type=int, default=None)
    parser.add_argument("--resume", action="store_true")
    parser.add_argument("--retry-failures", action="store_true",
                        help="Re-process FAIL circuits, keep PASS cached")
    parser.add_argument("--retry-errors", action="store_true",
                        help="Re-process only ERROR circuits, keep PASS/FAIL cached")
    parser.add_argument("--model", type=str, default=None,
                        help="Gemini model name")
    args = parser.parse_args()

    if args.model:
        _set_model(args.model)

    global OUTPUT_PATH
    OUTPUT_PATH = os.path.join(OUTPUT_DIR, f"verify_and_repair_{args.source}.json")

    circuits = collect_circuits(args.source, args.circuit)
    if args.limit:
        circuits = circuits[:args.limit]

    print(f"Verify & Repair: {len(circuits)} circuits")
    print(f"  Source: {args.source}")
    print(f"  Max retries per step: {args.max_retries}")
    print(f"  Gemini model: {GEMINI_MODEL}")
    print(f"  NgSPICE: {NGSPICE_BIN}")
    print()

    # Resume support
    existing = {}
    if (args.resume or args.retry_failures or args.retry_errors) and os.path.exists(OUTPUT_PATH):
        with open(OUTPUT_PATH) as f:
            prev = json.load(f)
        skipped = 0
        for r in prev.get("results", []):
            is_error = r.get("s3_status") == "ERROR" or r.get("s1_status") == "ERROR"
            is_fail = r.get("s1_status") == "FAIL" or r.get("s2_status") == "FAIL" or r.get("s3_status") == "FAIL"
            # Always retry ERRORs
            if is_error:
                skipped += 1
                continue
            # --retry-failures: also retry FAILs
            if args.retry_failures and is_fail:
                skipped += 1
                continue
            existing[(r["source"], r["name"])] = r
        print(f"Resuming: {len(existing)} cached, {skipped} will retry\n")

    all_results = list(existing.values())
    stats = Counter()
    for r in all_results:
        stats[f"s1_{r.get('s1_status', '?')}"] += 1
        stats[f"s2_{r.get('s2_status', '?')}"] += 1
        stats[f"s3_{r.get('s3_status', '?')}"] += 1

    for i, (source, name, json_path) in enumerate(circuits):
        if (args.resume or args.retry_failures or args.retry_errors) and (source, name) in existing:
            r = existing[(source, name)]
            s1 = r.get("s1_status", "?")
            s2 = r.get("s2_status", "?")
            s3 = r.get("s3_status", "?")
            print(f"[{i+1}/{len(circuits)}] {source}/{name}: (cached) S1:{s1} S2:{s2} S3:{s3}")
            continue

        print(f"\n{'='*60}")
        print(f"[{i+1}/{len(circuits)}] {source}/{name}")

        r = verify_and_repair_one(source, name, json_path, max_retries=args.max_retries)

        all_results.append(r)
        stats[f"s1_{r['s1_status']}"] += 1
        stats[f"s2_{r['s2_status']}"] += 1
        stats[f"s3_{r['s3_status']}"] += 1

        s1 = r["s1_status"]
        s2 = r["s2_status"]
        s3 = r["s3_status"]
        repairs = len([a for a in r.get("attempts", []) if "repair" in a.get("step", "")])
        gemini = r.get("total_gemini_calls", 0)
        t = r.get("total_time", 0)

        status = "ALL PASS" if s1 == "PASS" and s2 == "PASS" and s3 in ("PASS", "WARN") else "INCOMPLETE"
        print(f"  >>> {status} | S1:{s1} S2:{s2} S3:{s3} | {repairs} repairs, {gemini} Gemini calls, {t}s", flush=True)

        # Checkpoint every 20
        if (i + 1) % 20 == 0 or i == len(circuits) - 1:
            _save_summary(all_results, stats, len(circuits))

        time.sleep(0.3)

    _save_summary(all_results, stats, len(circuits))
    _print_summary(all_results, stats)


def _save_summary(results, stats, total):
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    summary = {
        "total": total,
        "verified": len(results),
        "stats": dict(stats),
        "model": GEMINI_MODEL,
        "results": results,
    }
    with open(OUTPUT_PATH, "w") as f:
        json.dump(summary, f, indent=2)


def _print_summary(results, stats):
    total = len(results)
    if total == 0:
        return

    all_pass = sum(1 for r in results
                   if r.get("s1_status") == "PASS"
                   and r.get("s2_status") == "PASS"
                   and r.get("s3_status") in ("PASS", "WARN"))
    total_repairs = sum(len([a for a in r.get("attempts", []) if "repair" in a.get("step", "")])
                        for r in results)
    total_gemini = sum(r.get("total_gemini_calls", 0) for r in results)

    print()
    print("=" * 60)
    print("VERIFY & REPAIR SUMMARY")
    print("=" * 60)
    print(f"Total circuits: {total}")
    print(f"All 3 steps PASS: {all_pass} ({100*all_pass/total:.0f}%)")
    print()

    s1p = stats.get("s1_PASS", 0)
    s1f = stats.get("s1_FAIL", 0)
    s1s = stats.get("s1_SKIP", 0)
    print(f"S1 (syntax):       PASS={s1p}  FAIL={s1f}  SKIP={s1s}")

    s2p = stats.get("s2_PASS", 0)
    s2f = stats.get("s2_FAIL", 0)
    s2w = stats.get("s2_WARN", 0)
    s2u = stats.get("s2_unknown", 0)
    print(f"S2 (convergence):  PASS={s2p}  FAIL={s2f}  WARN={s2w}")

    s3p = stats.get("s3_PASS", 0)
    s3f = stats.get("s3_FAIL", 0)
    s3w = stats.get("s3_WARN", 0)
    s3s = stats.get("s3_SKIP", 0)
    s3e = stats.get("s3_ERROR", 0)
    print(f"S3 (sanity):       PASS={s3p}  FAIL={s3f}  WARN={s3w}  SKIP={s3s}  ERROR={s3e}")

    print(f"\nTotal repairs: {total_repairs}")
    print(f"Total Gemini calls: {total_gemini}")
    print(f"\nResults: {OUTPUT_PATH}")


if __name__ == "__main__":
    main()
