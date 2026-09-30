"""
Verify extracted testbenches by running them through NgSPICE.

Workflow:
  1. Read testbench SPICE from extracted_metrics JSON (original untouched)
  2. Resolve placeholders and write runnable .sp files to verification_spice/
  3. Run through NgSPICE and check:
     Step 1: Syntax — does NgSPICE parse without errors?
     Step 2: Convergence — does simulation run and produce values?
     Step 3: Sanity — are measured values physically reasonable?

Usage:
    python verify_testbenches.py                        # run all
    python verify_testbenches.py --source baker         # baker only
    python verify_testbenches.py --source rocktnet      # rocktnet only
    python verify_testbenches.py --limit 10             # first 10 only
    python verify_testbenches.py --circuit five_trans_ota
    python verify_testbenches.py --resume               # skip already-verified
"""

import argparse
import json
import os
import re
import glob
import subprocess
import time
from collections import Counter

NGSPICE_BIN = os.environ.get(
    "NGSPICE_BIN",
    "/home/idies/workspace/Storage/xyu1/persistent/pytorch_env/Spice/bin/ngspice",
)
PDK_LIB_PATH = os.environ.get(
    "SKY130_PDK",
    "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice",
)

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
BAKER_DIR = os.path.join(SCRIPT_DIR, "extracted_metrics")
ROCKTNET_DIR = os.path.join(SCRIPT_DIR, "extracted_metrics_rocktnet")
SPICE_DIR = os.path.join(SCRIPT_DIR, "verification_spice")
OUTPUT_DIR = os.path.join(SCRIPT_DIR, "verification_results")

TIMEOUT_SEC = 60

# SKY130 PDK uses micron units for W/L (W=5.0 means 5 microns, NOT W=5u which is 5e-6 meters)
DEFAULT_W = "5.0"
DEFAULT_L = "0.5"
DEFAULT_R = "10k"
DEFAULT_C = "1p"
DEFAULT_L_IND = "1n"

# ── Step 3: sanity ranges per metric keyword ──
# Ordered list: longer/more-specific keywords first to avoid false matches
# e.g. "unity_gain_freq" must match before "gain"
# Ranges are wide to catch unit variations (Hz vs MHz, W vs µW, V/s vs V/µs)
SANITY_RULES = [
    ("unity_gain_freq", {"min": 1e2, "max": 100e9}),
    ("ugbw_mhz",        {"min": 1e-3, "max": 1e6}),
    ("ugbw",            {"min": 1e2, "max": 100e9}),
    ("gbw",             {"min": 1e2, "max": 100e9}),
    ("bandwidth",       {"min": 1e0, "max": 100e9}),
    ("frequency",       {"min": 1e0, "max": 100e9}),
    ("freq",            {"min": 1e0, "max": 100e9}),
    ("phase_margin",    {"min": -360, "max": 720}),
    ("phase_noise",     {"min": -200, "max": 0}),
    ("dc_gain",         {"min": -300, "max": 300}),
    ("open_loop_gain",  {"min": -300, "max": 300}),
    ("conversion_gain", {"min": -60, "max": 60}),
    ("noise_figure",    {"min": 0, "max": 40}),
    ("gain_db",         {"min": -300, "max": 300}),
    ("gain",            {"min": -300, "max": 1e6}),
    ("cmrr",            {"min": -200, "max": 200}),
    ("psrr",            {"min": -200, "max": 200}),
    ("power_uw",        {"min": -1e6, "max": 1e6}),
    ("power_dc",        {"min": -1e6, "max": 1e6}),
    ("power",           {"min": -1.0, "max": 10.0}),
    ("current",         {"min": -1.0, "max": 1.0}),
    ("slew_rate",       {"min": 1e-3, "max": 1e16}),
    ("slew",            {"min": 1e-3, "max": 1e16}),
    ("noise",           {"min": 0, "max": 1.0}),
    ("offset",          {"min": -5.0, "max": 5.0}),
    ("delay",           {"min": 0, "max": 1.0}),
    ("period",          {"min": 1e-12, "max": 1.0}),
    ("swing",           {"min": 0, "max": 10}),
    ("dropout",         {"min": 0, "max": 5}),
    ("ripple",          {"min": 0, "max": 5}),
    ("iip3",            {"min": -40, "max": 40}),
    ("nf",              {"min": 0, "max": 40}),
    ("efficiency",      {"min": 0, "max": 100}),
]


# ── SPICE resolution ──

def resolve_spice(spice, json_data):
    """
    Take raw SPICE from JSON and produce a runnable .sp file.
    The original JSON is never modified.
    """
    # 1) Fix PDK .lib paths
    lib_patterns = [
        r'\.lib\s+"?\$\{SKY130_PDK\}[^"]*"?\s+',
        r'\.lib\s+"?\$SKY130_PDK[^"]*"?\s+',
        r'\.lib\s+\{pdk_lib_path\}\s+',
        r'\.lib\s+"?/home/designer[^"]*"?\s+',
        r'\.lib\s+"?sky130_fd_pr[^"]*"?\s+',
    ]
    for pat in lib_patterns:
        spice = re.sub(pat, f'.lib "{PDK_LIB_PATH}" ', spice, flags=re.IGNORECASE)

    # 2) Fix unit conventions: SKY130 PDK expects W/L in microns (W=5.0),
    #    not SI meters (W=5u = 5e-6). Convert all .param W_*/L_* values.
    spice = _fix_wl_units(spice)

    # 3) Handle AMS-SizingBench {inst_pins} / {subckt_name}
    source = json_data.get("_source", "")
    if source == "AMS-SizingBench":
        spice = _resolve_ams_sizing(spice)

    # 3) Collect existing .param definitions
    existing_params = set()
    for m in re.finditer(r"\.param\s+(\w+)\s*=", spice, re.IGNORECASE):
        existing_params.add(m.group(1))

    # 4) Find all {placeholder} tokens in the SPICE.
    #    NgSPICE uses {param_name} to reference .param values in device lines,
    #    so we KEEP braces for sizing params (W_*, L_*, R*_val, etc.)
    #    and REMOVE braces only for non-param tokens (pdk_lib_path, etc.)
    param_like = re.compile(
        r"^(W_|L_|R\d*_|C\d*_|val_|RVAL|CVAL|scale|VDD)", re.IGNORECASE
    )

    def replace_curly(m):
        name = m.group(1)
        if param_like.match(name):
            return m.group(0)  # keep {W_xm1} as-is
        return name            # strip braces: {foo} -> foo
    spice = re.sub(r"\{(\w+)\}", replace_curly, spice)

    # 5) Find all param-like tokens referenced via {name} that lack .param defs
    all_param_refs = set(re.findall(r"\{(\w+)\}", spice))
    # Also find bare W_*/L_* not inside braces (e.g. w=W_tail from AMS-SizingBench)
    bare_params = set(re.findall(r"\b([WL]_\w+)\b", spice))
    # Check which bare params are NOT already wrapped in {} and not in .param
    for bp in bare_params:
        if f"{{{bp}}}" not in spice and bp not in existing_params:
            all_param_refs.add(bp)
    # Also catch R/C/L value params
    all_param_refs |= set(re.findall(r"\{([RCL]\d*_val)\}", spice))
    all_param_refs |= set(re.findall(r"\{(RVAL|CVAL)\}", spice))

    param_lines = []
    for tok in sorted(all_param_refs | bare_params):
        if tok in existing_params:
            continue
        tok_lower = tok.lower()
        if tok_lower.startswith("w_"):
            param_lines.append(f".param {tok}={DEFAULT_W}")
        elif tok_lower.startswith("l_"):
            param_lines.append(f".param {tok}={DEFAULT_L}")
        elif (tok_lower.startswith("r") and "val" in tok_lower) or tok_lower == "rval":
            param_lines.append(f".param {tok}={DEFAULT_R}")
        elif (tok_lower.startswith("c") and "val" in tok_lower) or tok_lower == "cval":
            param_lines.append(f".param {tok}={DEFAULT_C}")
        elif tok_lower.startswith("l") and "val" in tok_lower:
            param_lines.append(f".param {tok}={DEFAULT_L_IND}")
        elif tok_lower == "scale":
            param_lines.append(f".param {tok}=1")

    # Wrap bare param refs in device lines with {} so NgSPICE resolves them
    for tok in sorted(bare_params):
        if f"{{{tok}}}" not in spice:
            spice = re.sub(
                rf"(?<=[=]){re.escape(tok)}(?=[\s\n,)]|$)",
                f"{{{tok}}}",
                spice,
            )

    if param_lines:
        # Insert after title line and .lib line
        lines = spice.split("\n")
        insert_idx = 0
        for j, line in enumerate(lines):
            if line.strip().lower().startswith(".lib"):
                insert_idx = j + 1
                break
        lines = lines[:insert_idx] + param_lines + lines[insert_idx:]
        spice = "\n".join(lines)

    # 6) Ensure title line exists
    first_line = spice.lstrip().split("\n")[0].strip()
    if not first_line.startswith("*") and not first_line.startswith("."):
        spice = "* Testbench\n" + spice

    # 7) Ensure .end exists
    stripped_lines = [l.strip().lower() for l in spice.strip().split("\n")]
    if ".end" not in stripped_lines:
        spice = spice.rstrip() + "\n.end\n"

    return spice


def _si_to_micron(val_str):
    """Convert SI-unit value string to microns for SKY130 PDK.
    E.g. '5u' -> '5.0', '0.5u' -> '0.5', '500n' -> '0.5', '5e-6' -> '5.0'
    Values already in micron range (>0.01) are left as-is.
    """
    val_str = val_str.strip()
    try:
        if val_str.lower().endswith("u"):
            return str(float(val_str[:-1]))
        elif val_str.lower().endswith("n"):
            return str(float(val_str[:-1]) / 1000.0)
        else:
            num = float(val_str)
            if num < 1e-4 and num > 0:
                return str(num * 1e6)
            return val_str
    except ValueError:
        return val_str


def _fix_wl_units(spice):
    """Convert .param W_*/L_* values and inline w=/l= from SI to microns."""
    # Fix all name=value pairs on .param lines (may have multiple per line)
    def fix_param_assignment(m):
        name = m.group(1)
        value = m.group(2)
        name_lower = name.lower()
        if name_lower.startswith("w_") or name_lower.startswith("l_"):
            value = _si_to_micron(value)
        return f"{name}={value}"

    def fix_param_line(m):
        full_line = m.group(0)
        return re.sub(r"(\w+)\s*=\s*(\S+)", fix_param_assignment, full_line)

    spice = re.sub(
        r"^\.param\s+.+$",
        fix_param_line,
        spice,
        flags=re.IGNORECASE | re.MULTILINE,
    )

    # Fix inline w=/l= on device instance lines
    def fix_inline_wl(m):
        param = m.group(1)
        value = m.group(2)
        if not value.startswith("{"):
            value = _si_to_micron(value)
        return f"{param}={value}"

    spice = re.sub(
        r"\b([wWlL])\s*=\s*(\S+?)(?=[\s,)]|$)",
        fix_inline_wl,
        spice,
    )

    return spice


def _resolve_ams_sizing(spice):
    """Resolve AMS-SizingBench-specific placeholders: {inst_pins}, {subckt_name}."""
    subckt_match = re.search(
        r"\.subckt\s+(\S+)\s+(.+)", spice, re.IGNORECASE
    )
    if not subckt_match:
        return spice

    subckt_name = subckt_match.group(1)
    pins_str = subckt_match.group(2).strip()
    # Remove everything after a newline or component definition
    pins_str = pins_str.split("\n")[0].strip()
    pins = pins_str.split()

    # Map external net names to subckt pins
    # For AMS-SizingBench, the testbench defines external nets with the same names
    # XOTA VSS VDD VOUT VINN VINP ID FIVE_TRANSISTOR_OTA
    inst_line = f"XOTA {' '.join(pins)} {subckt_name}"

    spice = spice.replace("XOTA inst_pins subckt_name", inst_line)
    spice = spice.replace("XOTA {inst_pins} {subckt_name}", inst_line)
    spice = re.sub(
        r"XOTA\s+inst_pins\s+subckt_name", inst_line, spice
    )

    return spice


# ── NgSPICE execution ──

def run_ngspice(sp_path, timeout=TIMEOUT_SEC):
    """Run .sp file through NgSPICE. Returns (returncode, stdout, stderr, elapsed)."""
    try:
        t0 = time.time()
        proc = subprocess.run(
            [NGSPICE_BIN, "-b", sp_path],
            capture_output=True,
            text=True,
            timeout=timeout,
        )
        elapsed = time.time() - t0
        return proc.returncode, proc.stdout, proc.stderr, elapsed
    except subprocess.TimeoutExpired:
        return -1, "", "TIMEOUT", timeout


# ── Verification checks ──

def parse_values(stdout):
    """Extract print and meas values from NgSPICE output."""
    values = {}
    for line in stdout.split("\n"):
        m = re.match(r"\s*(\w[\w\[\]]*)\s*=\s*([+-]?\d+\.?\d*[eE]?[+-]?\d*)", line)
        if m:
            try:
                values[m.group(1)] = float(m.group(2))
            except ValueError:
                pass
    return values


def check_syntax(stdout, stderr):
    """Step 1: Check for syntax/parse errors."""
    errors = []
    combined = (stdout + "\n" + stderr).lower()

    fatal_patterns = [
        r"error[:\s]",
        r"unknown subckt",
        r"unknown device",
        r"could not find",
        r"no such file",
        r"unresolved",
        r"undefined",
        r"syntax error",
        r"missing \.end",
        r"bad expression",
        r"can't open",
        r"no circuit loaded",
        r"subckt \S+ not found",
    ]

    ignore_patterns = [
        r"error amplifier",
        r"error_amp",
        r"reference error",
        r"measurement .* fail",
        r"measure .* out of interval",
        r"measure .* trig",
        r"measure .* targ",
        r"measure .* find",
        r"measure .* max",
        r"measure .* min",
        r"measure .* cross",
        r"^error: measure\s+\S+\s+:",
    ]

    for line in combined.split("\n"):
        line_s = line.strip()
        if not line_s:
            continue
        if any(re.search(p, line_s) for p in ignore_patterns):
            continue
        for pat in fatal_patterns:
            if re.search(pat, line_s):
                errors.append(line_s[:200])
                break

    return errors


def check_convergence(stdout, stderr):
    """Step 2: Check simulation convergence and value production."""
    issues = []
    combined = (stdout + "\n" + stderr).lower()

    if "no convergence" in combined:
        issues.append("no_convergence")
    if "singular matrix" in combined:
        issues.append("singular_matrix")
    if "timestep too small" in combined:
        issues.append("timestep_too_small")
    if "doanalysis: too many iterations" in combined:
        issues.append("too_many_iterations")

    values = parse_values(stdout)
    if not values:
        issues.append("no_values_produced")

    return issues, values


def check_sanity(values):
    """Step 3: Check if measured values are physically reasonable."""
    issues = []
    checked = 0

    for name, val in values.items():
        name_lower = name.lower()
        for keyword, rule in SANITY_RULES:
            if keyword in name_lower:
                checked += 1
                if val < rule["min"]:
                    issues.append(
                        f"{name}={val:.4g} < min({rule['min']})"
                    )
                elif val > rule["max"]:
                    issues.append(
                        f"{name}={val:.4g} > max({rule['max']})"
                    )
                break

    return issues, checked


# ── Main pipeline ──

def verify_one(source, name, json_path, spice_dir):
    """Full 3-step verification on one circuit."""
    result = {
        "name": name,
        "source": source,
        "step1_syntax": "unknown",
        "step2_convergence": "unknown",
        "step3_sanity": "unknown",
        "values": {},
        "errors": [],
        "warnings": [],
        "elapsed_sec": 0,
        "spice_file": "",
    }

    # Load original JSON (read-only)
    try:
        with open(json_path) as f:
            data = json.load(f)
    except Exception as e:
        result["step1_syntax"] = "FAIL"
        result["errors"].append(f"JSON load error: {e}")
        return result

    if "_error" in data:
        result["step1_syntax"] = "SKIP"
        result["errors"].append("extraction had error")
        return result

    tb = data.get("step3_testbench", {})
    raw_spice = tb.get("spice", "")
    if not raw_spice:
        result["step1_syntax"] = "SKIP"
        result["errors"].append("no SPICE testbench")
        return result

    circuit_type = ""
    for key in ("step1_figure", "step1_analysis"):
        if key in data:
            circuit_type = data[key].get("circuit_type", "")
            break
    result["circuit_type"] = circuit_type

    # Resolve and write to verification_spice/
    try:
        resolved = resolve_spice(raw_spice, data)
    except Exception as e:
        result["step1_syntax"] = "FAIL"
        result["errors"].append(f"resolve error: {e}")
        return result

    sp_subdir = os.path.join(spice_dir, source)
    os.makedirs(sp_subdir, exist_ok=True)
    sp_path = os.path.join(sp_subdir, f"{name}.sp")
    with open(sp_path, "w") as f:
        f.write(resolved)
    result["spice_file"] = os.path.relpath(sp_path, SCRIPT_DIR)

    # Run NgSPICE
    returncode, stdout, stderr, elapsed = run_ngspice(sp_path)
    result["elapsed_sec"] = round(elapsed, 2)

    if returncode == -1:
        result["step1_syntax"] = "FAIL"
        result["errors"].append("TIMEOUT")
        return result

    # Step 1: Syntax
    syntax_errors = check_syntax(stdout, stderr)
    if syntax_errors:
        result["step1_syntax"] = "FAIL"
        result["errors"] = syntax_errors[:5]
        return result
    result["step1_syntax"] = "PASS"

    # Step 2: Convergence
    conv_issues, values = check_convergence(stdout, stderr)
    result["values"] = values

    if "no_convergence" in conv_issues or "singular_matrix" in conv_issues:
        result["step2_convergence"] = "FAIL"
        result["errors"].extend(conv_issues)
        return result
    if "no_values_produced" in conv_issues:
        result["step2_convergence"] = "WARN"
        result["warnings"].append("ran but no measurable values")
    else:
        result["step2_convergence"] = "PASS"

    # Step 3: Sanity
    sanity_issues, checked = check_sanity(values)
    if sanity_issues:
        result["step3_sanity"] = "FAIL"
        result["warnings"].extend(sanity_issues)
    elif checked == 0:
        result["step3_sanity"] = "SKIP"
        result["warnings"].append("no metrics matched sanity rules")
    else:
        result["step3_sanity"] = "PASS"

    return result


def collect_circuits(source, circuit_filter=None):
    """Collect (source, name, path) tuples."""
    circuits = []

    if source in ("baker", "all"):
        for f in sorted(glob.glob(os.path.join(BAKER_DIR, "*.json"))):
            name = os.path.basename(f).replace(".json", "")
            if circuit_filter and circuit_filter != name:
                continue
            circuits.append(("baker", name, f))

    if source in ("rocktnet", "all"):
        for f in sorted(glob.glob(os.path.join(ROCKTNET_DIR, "*.json"))):
            name = os.path.basename(f).replace(".json", "")
            if circuit_filter and circuit_filter != name:
                continue
            circuits.append(("rocktnet", name, f))

    return circuits


def _save_summary(path, results, stats, total):
    summary = {
        "total": total,
        "verified": len(results),
        "stats": dict(stats),
        "results": results,
    }
    with open(path, "w") as f:
        json.dump(summary, f, indent=2)


def main():
    parser = argparse.ArgumentParser(description="Verify testbenches via NgSPICE")
    parser.add_argument(
        "--source", choices=["baker", "rocktnet", "all"], default="all"
    )
    parser.add_argument("--limit", type=int, default=None)
    parser.add_argument("--circuit", type=str, default=None)
    parser.add_argument("--resume", action="store_true")
    args = parser.parse_args()

    os.makedirs(SPICE_DIR, exist_ok=True)
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    circuits = collect_circuits(args.source, args.circuit)
    if args.limit:
        circuits = circuits[: args.limit]

    print(f"Verifying {len(circuits)} testbenches...")
    print(f"NgSPICE:  {NGSPICE_BIN}")
    print(f"PDK:      {PDK_LIB_PATH}")
    print(f"SPICE ->  {SPICE_DIR}")
    print(f"Results-> {OUTPUT_DIR}")
    print()

    results = []
    stats = Counter()
    existing_results = {}

    summary_path = os.path.join(OUTPUT_DIR, "verification_summary.json")
    if args.resume and os.path.exists(summary_path):
        with open(summary_path) as f:
            prev = json.load(f)
        for r in prev.get("results", []):
            existing_results[(r["source"], r["name"])] = r
        print(f"Resuming: {len(existing_results)} previous results loaded\n")

    for i, (source, name, path) in enumerate(circuits):
        if args.resume and (source, name) in existing_results:
            r = existing_results[(source, name)]
            results.append(r)
            stats[f"s1_{r['step1_syntax']}"] += 1
            stats[f"s2_{r['step2_convergence']}"] += 1
            stats[f"s3_{r['step3_sanity']}"] += 1
            continue

        r = verify_one(source, name, path, SPICE_DIR)
        results.append(r)

        stats[f"s1_{r['step1_syntax']}"] += 1
        stats[f"s2_{r['step2_convergence']}"] += 1
        stats[f"s3_{r['step3_sanity']}"] += 1

        s1 = r["step1_syntax"]
        s2 = r["step2_convergence"]
        s3 = r["step3_sanity"]
        vals = len(r.get("values", {}))
        errs = "; ".join(r["errors"][:2]) if r["errors"] else ""
        print(
            f"[{i+1}/{len(circuits)}] {source}/{name}: "
            f"S1:{s1:<4} S2:{s2:<7} S3:{s3:<4} "
            f"({vals} vals, {r['elapsed_sec']:.1f}s)"
            + (f" | {errs[:80]}" if errs else "")
        )

        if (i + 1) % 50 == 0:
            _save_summary(summary_path, results, stats, len(circuits))

    _save_summary(summary_path, results, stats, len(circuits))

    # ── Summary ──
    total = len(results)
    print()
    print("=" * 60)
    print("VERIFICATION SUMMARY")
    print("=" * 60)
    print(f"Total circuits: {total}")
    print()

    s1p = stats.get("s1_PASS", 0)
    s1f = stats.get("s1_FAIL", 0)
    s1s = stats.get("s1_SKIP", 0)
    print(f"Step 1 — Syntax check:")
    print(f"  PASS: {s1p:>5}  ({100*s1p/total:.0f}%)" if total else "")
    print(f"  FAIL: {s1f:>5}  ({100*s1f/total:.0f}%)" if total else "")
    print(f"  SKIP: {s1s:>5}")
    print()

    if s1p > 0:
        s2p = stats.get("s2_PASS", 0)
        s2f = stats.get("s2_FAIL", 0)
        s2w = stats.get("s2_WARN", 0)
        print(f"Step 2 — Convergence (of {s1p} syntax-OK):")
        print(f"  PASS: {s2p:>5}  ({100*s2p/s1p:.0f}%)")
        print(f"  FAIL: {s2f:>5}  ({100*s2f/s1p:.0f}%)")
        print(f"  WARN: {s2w:>5}  ({100*s2w/s1p:.0f}%)")
        print()

    s2p = stats.get("s2_PASS", 0)
    if s2p > 0:
        s3p = stats.get("s3_PASS", 0)
        s3f = stats.get("s3_FAIL", 0)
        s3s = stats.get("s3_SKIP", 0)
        print(f"Step 3 — Sanity (of {s2p} converged):")
        print(f"  PASS: {s3p:>5}  ({100*s3p/s2p:.0f}%)")
        print(f"  FAIL: {s3f:>5}  ({100*s3f/s2p:.0f}%)")
        print(f"  SKIP: {s3s:>5}  ({100*s3s/s2p:.0f}%)")

    print(f"\nResolved SPICE: {SPICE_DIR}")
    print(f"Results JSON:   {summary_path}")


if __name__ == "__main__":
    main()
