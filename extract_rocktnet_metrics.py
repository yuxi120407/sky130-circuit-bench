"""
Extract metrics and generate testbenches for RoCktNet IEEE paper circuits
using Gemini, based on CIS metadata (no paper PDFs needed).

For each passing circuit (L3=true), sends Gemini:
  1. Sky130 netlist (circuit topology)
  2. CIS metadata (circuit type, reported metrics, numerical values, abstract)

Gemini returns: circuit analysis, metrics with expected ranges, ngspice testbench.

Usage:
    python extract_rocktnet_metrics.py                              # All 751 passing circuits
    python extract_rocktnet_metrics.py --circuit 000001
    python extract_rocktnet_metrics.py --type "amplifier"
    python extract_rocktnet_metrics.py --list
    python extract_rocktnet_metrics.py --dry-run
    python extract_rocktnet_metrics.py --resume
    python extract_rocktnet_metrics.py --model gemini-3.8-flash

Requires: google-auth, requests
"""

import os
import sys
import json
import argparse
import time
import subprocess

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
GEMINI_SCRIPT = os.path.join(BASE_DIR, "test", "gemini_call_v2.py")


SAM3_PYTHON = "/home/idies/workspace/Storage/xyu1/persistent/pytorch_env/sam3_gcloud/bin/python"


def call_gemini(prompt, temperature=0.0, max_tokens=65536, model=None):
    """Call Gemini via subprocess using sam3_gcloud env (has google.auth)."""
    cmd = [SAM3_PYTHON, GEMINI_SCRIPT]
    if model:
        cmd += ["--model", model]
    proc = subprocess.run(cmd, input=prompt, capture_output=True, text=True, timeout=300)
    if proc.returncode != 0:
        raise RuntimeError(f"gemini_call_v2 failed: {proc.stderr.strip()}")
    data = json.loads(proc.stdout)
    if not data.get("ok"):
        raise RuntimeError(data.get("error", "unknown error"))
    return data["text"]
ROCKTNET_DIR = os.path.join(BASE_DIR, "sky130rocktnet")
CIS_DIR = os.path.join(BASE_DIR, "RoCktNet", "dataset", "CIS")
NETLIST_DIR = os.path.join(BASE_DIR, "RoCktNet", "dataset", "netlist")
DECKS_DIR = os.path.join(ROCKTNET_DIR, "decks")
L3_FILE = os.path.join(ROCKTNET_DIR, "sky130_l3.json")
ID_MAPPING_FILE = os.path.join(ROCKTNET_DIR, "id_mapping.json")
OUTPUT_DIR = os.path.join(BASE_DIR, "extracted_metrics_rocktnet")


def load_l3():
    with open(L3_FILE) as f:
        return json.load(f)


def load_id_mapping():
    with open(ID_MAPPING_FILE) as f:
        data = json.load(f)
    mapping = {}
    for c in data["cases"]:
        mapping[c["name"]] = c
    return mapping


def load_cis_metadata(paper_id):
    summary_path = os.path.join(CIS_DIR, paper_id, "summary.json")
    analysis_path = os.path.join(CIS_DIR, paper_id, "analysis.json")
    meta = {}
    if os.path.exists(summary_path):
        with open(summary_path) as f:
            meta["summary"] = json.load(f)
    if os.path.exists(analysis_path):
        with open(analysis_path) as f:
            meta["analysis"] = json.load(f)
    return meta


def load_sky130_netlist(circuit_name):
    path = os.path.join(DECKS_DIR, f"tc{circuit_name}_sky130.spice")
    if os.path.exists(path):
        with open(path) as f:
            return f.read()
    return None


def load_generic_netlist(circuit_name):
    path = os.path.join(NETLIST_DIR, f"{circuit_name}.cir")
    if os.path.exists(path):
        with open(path) as f:
            return f.read()
    return None


def parameterize_netlist(sky130_netlist):
    """Extract transistors from the sky130 deck and parameterize W/L.
    Turns 'XM1 ... l=0.5 w=5' into '.param W_xm1=5u L_xm1=0.5u' + 'XM1 ... l={L_xm1} w={W_xm1}'.
    """
    if not sky130_netlist:
        return None, None
    import re
    params = []
    circuit_lines = []
    for line in sky130_netlist.split("\n"):
        stripped = line.strip()
        if not (stripped.upper().startswith("XM") or stripped.upper().startswith("xm")):
            continue
        name = stripped.split()[0].lower()
        w_match = re.search(r'\bw=([\d.]+)', stripped, re.IGNORECASE)
        l_match = re.search(r'\bl=([\d.]+)', stripped, re.IGNORECASE)
        if w_match and l_match:
            w_val = w_match.group(1)
            l_val = l_match.group(1)
            w_param = f"W_{name}"
            l_param = f"L_{name}"
            params.append(f".param {w_param}={w_val}u {l_param}={l_val}u")
            new_line = re.sub(r'\bw=[\d.]+', f'w={{{w_param}}}', stripped, flags=re.IGNORECASE)
            new_line = re.sub(r'\bl=[\d.]+', f'l={{{l_param}}}', new_line, flags=re.IGNORECASE)
            circuit_lines.append(new_line)
        else:
            circuit_lines.append(stripped)
    if not circuit_lines:
        return None, None
    param_block = "\n".join(params)
    netlist_block = "\n".join(circuit_lines)
    return param_block, netlist_block


def build_prompt(circuit_name, case_info, cis_meta, generic_netlist, sky130_netlist):
    summary = cis_meta.get("summary", {})
    analysis = cis_meta.get("analysis", {})

    circuit_type = summary.get("type", "unknown")
    title = summary.get("title", "")
    bib = summary.get("bibliography", {})
    year = bib.get("year", "")
    venue = bib.get("venue", "")
    keywords = bib.get("keywords", [])
    metrics = summary.get("metrics", [])
    numerical = summary.get("numerical_performance", [])
    function_summary = summary.get("function_summary", "")
    design_purpose = summary.get("design_purpose", "")
    sub_blocks = summary.get("sub_blocks", [])

    paper_context = analysis.get("paper_circuit_context", {})
    abstract = analysis.get("paper_metadata", {}).get("abstract", "")
    app_domain = paper_context.get("application_domain", "")

    # Build metadata block
    meta_block = f"""**IEEE Paper Context:**
- Title: {title}
- Venue: {venue}, Year: {year}
- Keywords: {', '.join(keywords)}
- Circuit Type: {circuit_type}
- Application: {app_domain}
- Sub-blocks: {', '.join(sub_blocks)}
- Function: {function_summary}
- Design Purpose: {design_purpose}

**Reported Metrics from Paper:** {', '.join(metrics)}
**Reported Numerical Values:** {', '.join(str(v) for v in numerical)}

**Abstract:** {abstract[:1000]}
"""

    # Build netlist block
    netlist_block = ""
    param_block, circuit_lines = parameterize_netlist(sky130_netlist)
    if param_block and circuit_lines:
        netlist_block = f"""
**Circuit netlist (sky130, parameterized W/L):**
```spice
{param_block}

{circuit_lines}
```
"""
    elif generic_netlist:
        netlist_block = f"""
**Circuit netlist (generic MOSFET):**
```spice
{generic_netlist}
```
"""

    # Extract source info from sky130 deck
    source_block = ""
    if sky130_netlist:
        sources = []
        for line in sky130_netlist.split("\n"):
            stripped = line.strip()
            if stripped.startswith("V") and " 0 " in stripped:
                sources.append(stripped)
        if sources:
            source_block = f"""
**DC sources in existing testbench:**
```
{chr(10).join(sources)}
```
"""

    prompt = f"""I give you a SPICE netlist extracted from an IEEE paper schematic, along with metadata about the paper. Do three things:

**Step 1: Analyze the circuit.**
Read the netlist and the paper metadata. Identify what this circuit does and what type it is. Map the node names to circuit functions (inputs, outputs, bias, supply, etc.).
{meta_block}{netlist_block}{source_block}
**Step 2: List every metric that should be measured.**
Based on the circuit type and the paper's reported metrics, list all metrics that characterize this circuit's performance.

For each reported metric from the paper, include it. Also add standard metrics for this circuit type that a designer would measure, even if not explicitly listed.

For each metric, estimate the expected value on SKY130 (VDD=1.8V):
- NMOS: Vth=0.42V, un*Cox=270uA/V², lambda=0.1/V
- PMOS: |Vth|=0.42V, up*Cox=50uA/V², lambda=0.1/V
- Use the paper's reported numerical values as reference where applicable, but adjust for SKY130 1.8V if the paper used a different technology/supply.

**Step 3: Write ngspice testbench.**
Write one complete testbench that measures every metric from Step 2.
- The netlist transistors above ARE the DUT — include them directly in the testbench.
- Add appropriate voltage sources for VDD (1.8V) and input signals.
- Use `.lib "${{SKY130_PDK}}" tt`
- Use `.control`/`.endc` with `.meas` and `print`
- End with `quit`
- Use parameterized W/L: `.param W_xm1=... L_xm1=...` etc.

**ngspice syntax reference** (use these patterns, adapt to the circuit type):
```
* === Correct ngspice functions ===
* Voltage magnitude in dB (AC only): vdb(node)
* Phase in radians (AC only):        cph(v(node))
* Phase in degrees:                   180/PI * cph(v(node))
* Current through source:             i(Vsource)
* DO NOT use db(), ph(), vm() — they do not exist in ngspice.

* === AC analysis ===
ac dec 100 1 1G
let gain_db = vdb(out)
let phase = 180/PI * cph(v(out))
meas ac val_at_freq find gain_db at=1k
meas ac freq_at_val when gain_db=0 fall=1
meas ac phase_at_freq find phase when gain_db=0 fall=1

* === DC operating point ===
op
print v(node1) v(node2)
let power = -i(vdd) * 1.8
print power

* === Transient analysis ===
tran 1n 1u
meas tran v_max max v(out)
meas tran v_min min v(out)
meas tran t_rise trig v(out) val=0.36 rise=1 targ v(out) val=1.44 rise=1
meas tran t_fall trig v(out) val=1.44 fall=1 targ v(out) val=0.36 fall=1

* === DC sweep ===
dc Vin 0 1.8 0.01
meas dc threshold when v(out)=0.9 rise=1
```

Return JSON only:
```json
{{
  "step1_analysis": {{
    "circuit_type": "what this circuit is",
    "description": "1-2 sentences about function",
    "node_mapping": {{
      "input": ["node names"],
      "output": ["node names"],
      "supply": ["VDD"],
      "bias": ["node names if any"],
      "ground": ["GND"]
    }},
    "paper_reference": {{
      "title": "paper title",
      "figure": "figure number from case name",
      "year": 2000
    }}
  }},
  "step2_metrics": {{
    "<metric_name>": {{
      "description": "what it measures",
      "unit": "dB|Hz|V|A|W|degrees|V/us|ohm",
      "analysis_type": "AC|DC|Tran|OP|Noise",
      "paper_reported": {{
        "value": "from paper if available",
        "technology": "original process node"
      }},
      "sky130_expected": {{
        "calculation": "step-by-step with sky130 params",
        "range": {{ "min": null, "typical": null, "max": null, "unit": "..." }},
        "reasoning": "why this range, how adjusted from paper"
      }},
      "importance": "essential|recommended|optional"
    }}
  }},
  "step3_testbench": {{
    "description": "what it measures",
    "analyses": ["AC", "Tran"],
    "metrics_measured": ["metric1", "metric2"],
    "spice": "complete ngspice code"
  }}
}}
```
"""
    return prompt


def extract_json_from_response(text):
    text = text.strip()
    if "```json" in text:
        text = text.split("```json", 1)[1]
        text = text.split("```", 1)[0]
    elif "```" in text:
        text = text.split("```", 1)[1]
        text = text.split("```", 1)[0]
    return json.loads(text.strip())


def run_one(circuit_name, case_info, cis_meta, dry_run=False, model=None):
    paper_id = case_info["case"].split("_image_")[0]
    circuit_type = cis_meta.get("summary", {}).get("type", "unknown")

    generic_netlist = load_generic_netlist(circuit_name)
    sky130_netlist = load_sky130_netlist(circuit_name)
    prompt = build_prompt(circuit_name, case_info, cis_meta, generic_netlist, sky130_netlist)

    print(f"  {circuit_name} (paper={paper_id}, type={circuit_type})")
    print(f"  Case: {case_info['case']}")
    print(f"  Netlist: sky130={'yes' if sky130_netlist else 'no'}, generic={'yes' if generic_netlist else 'no'}")
    metrics = cis_meta.get("summary", {}).get("metrics", [])
    print(f"  Paper metrics: {', '.join(metrics)}")

    if dry_run:
        print(f"\n--- PROMPT ({len(prompt)} chars) ---\n{prompt[:3000]}...\n--- END ---")
        return None

    model_name = model or "gemini-3.1-pro-preview"
    print(f"  Calling {model_name}...")
    try:
        response = call_gemini(prompt, temperature=0.0, max_tokens=65536, model=model)
        result = extract_json_from_response(response)
        result["_raw_response"] = response
        result["_paper_id"] = paper_id
        result["_case"] = case_info["case"]

        out_file = os.path.join(OUTPUT_DIR, f"{circuit_name}.json")
        with open(out_file, "w") as f:
            json.dump(result, f, indent=2)

        step1 = result.get("step1_analysis", {})
        metrics_out = result.get("step2_metrics", {})
        print(f"  -> Type: {step1.get('circuit_type', '?')}")
        print(f"  -> {len(metrics_out)} metrics: {', '.join(metrics_out.keys())}")

        return result

    except Exception as e:
        print(f"  ERROR: {e}")
        result = {"_error": str(e), "_paper_id": paper_id, "_case": case_info["case"]}
        out_file = os.path.join(OUTPUT_DIR, f"{circuit_name}.json")
        with open(out_file, "w") as f:
            json.dump(result, f, indent=2)
        return None


def main():
    parser = argparse.ArgumentParser(
        description="Extract metrics + testbench for RoCktNet IEEE paper circuits via Gemini")
    parser.add_argument("--circuit", type=str, default=None,
                        help="Run for one circuit by name (e.g. 000001)")
    parser.add_argument("--type", type=str, default=None,
                        help="Run for all circuits of one type (substring match)")
    parser.add_argument("--list", action="store_true",
                        help="List all passing circuits")
    parser.add_argument("--dry-run", action="store_true",
                        help="Show prompt without calling Gemini")
    parser.add_argument("--model", type=str, default=None,
                        help="Gemini model name (default: gemini-3.1-pro-preview)")
    parser.add_argument("--delay", type=int, default=5,
                        help="Delay between API calls (default: 5s)")
    parser.add_argument("--resume", action="store_true",
                        help="Skip circuits that already have output files")
    parser.add_argument("--limit", type=int, default=None,
                        help="Process at most N circuits")
    args = parser.parse_args()

    l3 = load_l3()
    id_mapping = load_id_mapping()

    # Build list of passing circuits with CIS metadata
    circuits = {}
    for name, passed in l3.items():
        if not passed:
            continue
        if name not in id_mapping:
            continue
        case = id_mapping[name]
        paper_id = case["case"].split("_image_")[0]
        cis = load_cis_metadata(paper_id)
        if not cis.get("summary"):
            continue
        circuits[name] = {"case": case, "cis": cis}

    if args.list:
        by_type = {}
        for name, info in circuits.items():
            ct = info["cis"]["summary"].get("type", "unknown")
            if ct not in by_type:
                by_type[ct] = []
            by_type[ct].append(name)

        for ct in sorted(by_type.keys()):
            names = by_type[ct]
            print(f"\n{ct} ({len(names)} circuits):")
            for n in names[:10]:
                pid = circuits[n]["case"]["case"].split("_image_")[0]
                title = circuits[n]["cis"]["summary"].get("title", "")[:60]
                print(f"  {n}  paper={pid}  {title}")
            if len(names) > 10:
                print(f"  ... and {len(names)-10} more")
        print(f"\nTotal: {len(circuits)} passing circuits with metadata, {len(by_type)} types")
        return

    # Select circuits
    if args.circuit:
        if args.circuit not in circuits:
            print(f"Unknown or non-passing circuit: {args.circuit}")
            print(f"Available: {len(circuits)} passing circuits")
            sys.exit(1)
        targets = [(args.circuit, circuits[args.circuit])]
    elif args.type:
        targets = [(n, info) for n, info in circuits.items()
                    if args.type.lower() in info["cis"]["summary"].get("type", "").lower()]
        if not targets:
            print(f"No circuits matching type: {args.type}")
            sys.exit(1)
        print(f"Found {len(targets)} circuits matching type '{args.type}'")
    else:
        targets = list(circuits.items())

    if args.limit:
        targets = targets[:args.limit]

    os.makedirs(OUTPUT_DIR, exist_ok=True)

    results = {}
    for i, (cname, info) in enumerate(targets):
        if args.resume:
            out_file = os.path.join(OUTPUT_DIR, f"{cname}.json")
            if os.path.exists(out_file):
                try:
                    with open(out_file) as f:
                        existing = json.load(f)
                    if "_error" not in existing:
                        print(f"[{i+1}/{len(targets)}] Skipping {cname} (already exists)")
                        results[cname] = existing
                        continue
                except Exception:
                    pass

        print(f"\n[{i+1}/{len(targets)}]")
        result = run_one(cname, info["case"], info["cis"],
                         dry_run=args.dry_run, model=args.model)
        if result:
            results[cname] = result
        if not args.dry_run and i < len(targets) - 1:
            time.sleep(args.delay)

    if results and not args.dry_run:
        summary = os.path.join(OUTPUT_DIR, "extraction_summary.json")
        summary_data = {}
        for cname, r in results.items():
            step1 = r.get("step1_analysis", {})
            metrics_out = r.get("step2_metrics", {})
            tb = r.get("step3_testbench", {})
            summary_data[cname] = {
                "paper_id": r.get("_paper_id"),
                "case": r.get("_case"),
                "circuit_type": step1.get("circuit_type"),
                "num_metrics": len(metrics_out),
                "metrics": list(metrics_out.keys()),
                "has_testbench": bool(tb.get("spice")),
            }
        with open(summary, "w") as f:
            json.dump(summary_data, f, indent=2)

        print(f"\n{'='*60}")
        print(f"DONE — {len(results)} circuits processed")
        total_metrics = sum(len(r.get("step2_metrics", {})) for r in results.values())
        print(f"Total metrics extracted: {total_metrics}")
        if results:
            print(f"Avg metrics per circuit: {total_metrics/len(results):.1f}")

        by_type = {}
        for cname, r in results.items():
            ct = r.get("step1_analysis", {}).get("circuit_type", "?")
            if ct not in by_type:
                by_type[ct] = {"count": 0, "metrics": 0}
            by_type[ct]["count"] += 1
            by_type[ct]["metrics"] += len(r.get("step2_metrics", {}))

        print(f"\nPer-type summary:")
        for ct in sorted(by_type.keys()):
            s = by_type[ct]
            avg = s["metrics"] / s["count"] if s["count"] else 0
            print(f"  {ct:40s}: {s['count']:3d} circuits, {avg:.0f} avg metrics")

        print(f"\nOutput: {OUTPUT_DIR}/*.json")
        print(f"Summary: {summary}")


if __name__ == "__main__":
    main()
