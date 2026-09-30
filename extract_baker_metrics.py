"""
Extract circuit type, metrics, testbench, and expected ranges for each Baker circuit
using Gemini 3.1 Pro.

For each circuit, sends Gemini three sources:
  1. Baker PDF (+ Razavi/Allen for relevant types)
  2. Original LTspice .asc file from CMOSedu.com (Baker's intended simulation)
  3. Current sky130 .spice testbench (what we have now)

Gemini returns: circuit type, metrics with sky130 ranges, and a proper ngspice testbench.

Usage:
    python extract_baker_metrics.py                              # All 246 circuits
    python extract_baker_metrics.py --circuit Chap24_LTspice_Fig24_10
    python extract_baker_metrics.py --type op_amp
    python extract_baker_metrics.py --list
    python extract_baker_metrics.py --dry-run
    python extract_baker_metrics.py --resume                     # Skip already-done circuits

Requires: google-auth, requests
"""

import os
import sys
import json
import argparse
import time
import glob

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "test"))
from gemini_call_v2 import call_gemini

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
BAKER_PDF = os.path.join(BASE_DIR, "pdfs", "CMOS_Circuit_Design__Layout__and_Simulation__3rd_Edition.pdf")
RAZAVI_PDF = os.path.join(BASE_DIR, "pdfs", "Design.of.Analog.CMOS.Integrated.Circuits.2nd.Edition.pdf")
ALLEN_PDF = os.path.join(BASE_DIR, "pdfs", "Phillip E. Allen, Douglas R. Holberg - CMOS Analog Circuit Design (3th 2011).pdf")
CIRCUIT_SPECS = os.path.join(BASE_DIR, "baker_circuit_specs.json")
LTSPICE_DIR = os.path.join(BASE_DIR, "LTspice_original", "LTspice_CMOSedu")
SPICE_DIR = os.path.join(BASE_DIR, "ready_circuits", "baker_textbook")
OUTPUT_DIR = os.path.join(BASE_DIR, "extracted_metrics")

# Baker PDF page mapping: chapter -> (start_pdf_page, end_pdf_page)
# Found by scanning chapter title pages in the actual PDF
BAKER_CHAPTER_PAGES = {
    9:  (307, 348),
    10: (349, 368),
    11: (369, 390),
    12: (391, 412),
    13: (413, 434),
    14: (435, 470),
    16: (471, 520),
    17: (521, 560),
    18: (561, 588),
    19: (589, 650),
    20: (651, 694),
    21: (695, 748),
    22: (749, 782),
    23: (783, 810),
    24: (811, 866),
    25: (867, 900),
    26: (901, 946),
    27: (947, 1000),
    31: (1137, 1190),
    32: (1191, 1213),
}


def load_circuit_specs():
    with open(CIRCUIT_SPECS) as f:
        return json.load(f)


def find_figure_page(chapter_num, fig_str):
    """Find the first PDF page mentioning this figure."""
    if chapter_num not in BAKER_CHAPTER_PAGES:
        return None
    start, end = BAKER_CHAPTER_PAGES[chapter_num]
    try:
        from pypdf import PdfReader
        reader = PdfReader(BAKER_PDF)
        targets = [f"Fig. {fig_str}", f"Figure {fig_str}", fig_str]
        for i in range(start, min(end + 1, len(reader.pages))):
            text = reader.pages[i].extract_text() or ""
            if any(t in text for t in targets):
                return i
    except Exception:
        pass
    return None


def extract_figure_pdf(chapter_num, fig_str, window=5):
    """Extract ±window pages around the figure. Falls back to full chapter."""
    chapter_dir = os.path.join(OUTPUT_DIR, "chapter_pdfs")
    os.makedirs(chapter_dir, exist_ok=True)
    start, end = BAKER_CHAPTER_PAGES.get(chapter_num, (0, 0))

    fig_page = find_figure_page(chapter_num, fig_str)
    if fig_page is None:
        return extract_chapter_pdf(chapter_num)

    lo = max(start, fig_page - window)
    hi = min(end, fig_page + window)

    out_path = os.path.join(chapter_dir, f"baker_fig{fig_str}.pdf")
    if os.path.exists(out_path):
        return out_path, fig_page

    try:
        from pypdf import PdfReader, PdfWriter
        reader = PdfReader(BAKER_PDF)
        writer = PdfWriter()
        for i in range(lo, hi + 1):
            writer.add_page(reader.pages[i])
        with open(out_path, "wb") as f:
            writer.write(f)
        print(f"  Figure at PDF page {fig_page}, extracted pages {lo}-{hi} ({hi-lo+1} pages)")
        return out_path, fig_page
    except Exception as e:
        print(f"  Warning: could not extract figure PDF: {e}")
        return extract_chapter_pdf(chapter_num), None


def extract_chapter_pdf(chapter_num):
    """Extract just the relevant chapter pages from Baker PDF into a smaller PDF."""
    if chapter_num not in BAKER_CHAPTER_PAGES:
        return BAKER_PDF

    start, end = BAKER_CHAPTER_PAGES[chapter_num]
    chapter_dir = os.path.join(OUTPUT_DIR, "chapter_pdfs")
    os.makedirs(chapter_dir, exist_ok=True)
    out_path = os.path.join(chapter_dir, f"baker_ch{chapter_num}.pdf")

    if os.path.exists(out_path):
        return out_path

    try:
        from pypdf import PdfReader, PdfWriter
        reader = PdfReader(BAKER_PDF)
        writer = PdfWriter()
        for i in range(start, min(end + 1, len(reader.pages))):
            writer.add_page(reader.pages[i])
        with open(out_path, "wb") as f:
            writer.write(f)
        return out_path
    except Exception as e:
        print(f"  Warning: could not extract chapter PDF: {e}")
        return BAKER_PDF


def get_pdfs(chapter_num=None, fig_str=None, window=5):
    """Get PDFs to send. Tries figure ±window pages first, falls back to full chapter."""
    if chapter_num and fig_str:
        result = extract_figure_pdf(chapter_num, fig_str, window)
        path = result[0] if isinstance(result, tuple) else result
        return [path]
    if chapter_num:
        return [extract_chapter_pdf(chapter_num)]
    return []


TASK2_FILE = os.path.join(BASE_DIR, "benchmark", "task2_testbench_generation.json")
_task2_cache = None

def load_netlist(circuit_name):
    """Load the clean parameterized netlist from task2_testbench_generation.json."""
    global _task2_cache
    if _task2_cache is None:
        try:
            with open(TASK2_FILE) as f:
                data = json.load(f)
            entries = data if isinstance(data, list) else data.get("data", [])
            _task2_cache = {e["circuit_name"]: e["input"]["netlist"]
                            for e in entries if "circuit_name" in e}
        except Exception:
            _task2_cache = {}
    return _task2_cache.get(circuit_name)


def find_original_ltspice(circuit_name):
    """Find the original LTspice .asc file for a circuit.
    Circuit names like 'Chap24_LTspice_Fig24_10' -> Chap24_LTspice/Fig24_10.asc
    """
    parts = circuit_name.split("_LTspice_")
    if len(parts) == 2:
        chap_dir = parts[0] + "_LTspice"
        fig_name = parts[1]
        asc_path = os.path.join(LTSPICE_DIR, chap_dir, f"{fig_name}.asc")
        if os.path.exists(asc_path):
            with open(asc_path, errors="replace") as f:
                return f.read()
        # Try with _Extras
    # Try glob match
    for asc in glob.glob(os.path.join(LTSPICE_DIR, "**", "*.asc"), recursive=True):
        if circuit_name.split("_")[-1] in os.path.basename(asc):
            with open(asc, errors="replace") as f:
                return f.read()
    return None


def extract_ltspice_commands(asc_content):
    """Extract simulation commands and .meas statements from LTspice .asc file."""
    if not asc_content:
        return None
    commands = []
    for line in asc_content.split("\n"):
        if line.startswith("TEXT") and "!" in line:
            cmd = line.split("!", 1)[1].strip()
            if not cmd.startswith(".include"):
                commands.append(cmd)
        elif line.startswith("TEXT") and ";" in line:
            comment = line.split(";", 1)[1].strip()
            if comment:
                commands.append(f"; {comment}")
    return commands if commands else None


def build_prompt(circuit_name, circuit_info, netlist, ltspice_commands):
    ct = circuit_info.get("circuit_type", "unknown")
    ch = circuit_info.get("chapter", "unknown")
    fig = circuit_info.get("figure", circuit_name)

    netlist_block = ""
    if netlist:
        netlist_block = f"""
**Circuit netlist (sky130, parameterized W/L):**
```spice
{netlist}
```
"""

    ltspice_block = ""
    if ltspice_commands:
        cmds_str = "\n".join(ltspice_commands)
        ltspice_block = f"""
**Baker's original LTspice simulation commands (from CMOSedu.com):**
```
{cmds_str}
```
"""

    prompt = f"""I give you a SPICE netlist and pages from Baker's CMOS textbook (Chapter {ch}). Do three things:

**Step 1: Match netlist to schematic.**
Read the netlist. Find the figure in the PDF that shows this circuit's schematic. State the figure number and page.
{netlist_block}{ltspice_block}
**Step 2: List every metric.**
Go through ALL the provided PDF pages, one by one. For every equation, every simulation figure, and every performance discussion you find that applies to this circuit, add a metric.

An equation means a metric. Examples:
- Equation for open-loop gain (A_OL = ...) → metric: open_loop_gain
- Equation for unity-gain frequency (fun = gm/2piCc) → metric: unity_gain_frequency
- Equation for output swing → metric: output_swing
- Equation for slew rate → metric: slew_rate
- Discussion of phase margin → metric: phase_margin
- Discussion of power → metric: power

Do NOT skip any equation. If there is an equation on the page, it is a metric.

For each metric, calculate the expected value on SKY130 (VDD=1.8V):
- NMOS: Vth=0.42V, un*Cox=270uA/V², lambda=0.1/V
- PMOS: |Vth|=0.42V, up*Cox=50uA/V², lambda=0.1/V
Show your calculation step by step.

**Step 3: Write ngspice testbench.**
Write one testbench that measures every metric from Step 2.
- The netlist above IS the DUT — `.include` it or paste it directly. Do NOT use a placeholder.
- Use `.lib "${{SKY130_PDK}}" tt`
- Use `.control`/`.endc` with `.meas` and `print`
- End with `quit`

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
meas tran freq find 1/period when v(out)=0.9 rise=2

* === DC sweep ===
dc Vin 0 1.8 0.01
meas dc threshold when v(out)=0.9 rise=1
```

Return JSON only:
```json
{{
  "step1_figure": {{
    "schematic_figure": "Fig X.Y",
    "page": "page number",
    "circuit_type": "what this circuit is",
    "description": "1-2 sentences"
  }},
  "step2_metrics": {{
    "<metric_name>": {{
      "description": "what it measures",
      "unit": "dB|Hz|V|A|W|degrees|V/us|ohm",
      "analysis_type": "AC|DC|Tran|OP|Noise",
      "source": {{ "page": "N", "reference": "Eq X.Y or Fig X.Y" }},
      "equation": {{ "formula": "...", "explanation": "...", "assumptions": "..." }},
      "sky130_expected": {{
        "calculation": "step-by-step with sky130 params",
        "range": {{ "min": null, "typical": null, "max": null, "unit": "..." }},
        "reasoning": "why this range"
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


def run_one(circuit_name, circuit_info, dry_run=False, model=None):
    ct = circuit_info.get("circuit_type", "unknown")
    ch = circuit_info.get("chapter", "?")
    fig = circuit_info.get("figure", circuit_name)

    netlist = load_netlist(circuit_name)
    ltspice_asc = find_original_ltspice(circuit_name)
    ltspice_commands = extract_ltspice_commands(ltspice_asc)
    prompt = build_prompt(circuit_name, circuit_info, netlist, ltspice_commands)
    ch_num = int(ch) if str(ch).isdigit() else None
    pdfs = get_pdfs(chapter_num=ch_num, fig_str=str(fig))

    print(f"  {circuit_name} (type={ct}, ch={ch}, fig={fig})")
    print(f"  PDFs: {[os.path.basename(p) for p in pdfs]}")
    print(f"  Netlist: {'yes' if netlist else 'no'}")
    print(f"  LTspice commands: {'yes' if ltspice_commands else 'no'}")
    if ltspice_commands:
        print(f"    {' | '.join(c for c in ltspice_commands if not c.startswith(';'))}")

    if dry_run:
        print(f"\n--- PROMPT ({len(prompt)} chars) ---\n{prompt[:3000]}...\n--- END ---")
        return None

    model_name = model or "gemini-3.1-pro-preview"
    print(f"  Calling {model_name}...")
    try:
        response = call_gemini(prompt, pdf_path=pdfs, temperature=0.0, max_tokens=65536, model=model)
        result = extract_json_from_response(response)
        result["_raw_response"] = response

        # Single JSON output per circuit
        out_file = os.path.join(OUTPUT_DIR, f"{circuit_name}.json")
        with open(out_file, "w") as f:
            json.dump(result, f, indent=2)

        step1 = result.get("step1_figure", {})
        metrics = result.get("step2_metrics", {})
        print(f"  -> Schematic: {step1.get('schematic_figure', '?')}")
        print(f"  -> Type: {step1.get('circuit_type', '?')}")
        print(f"  -> {len(metrics)} metrics: {', '.join(metrics.keys())}")

        return result

    except Exception as e:
        print(f"  ERROR: {e}")
        result = {"_error": str(e)}
        out_file = os.path.join(OUTPUT_DIR, f"{circuit_name}.json")
        with open(out_file, "w") as f:
            json.dump(result, f, indent=2)
        return None


def main():
    parser = argparse.ArgumentParser(
        description="Extract metrics + testbench per Baker circuit figure via Gemini")
    parser.add_argument("--circuit", type=str, default=None,
                        help="Run for one circuit by name")
    parser.add_argument("--type", type=str, default=None,
                        help="Run for all circuits of one type")
    parser.add_argument("--list", action="store_true",
                        help="List all circuits")
    parser.add_argument("--dry-run", action="store_true",
                        help="Show prompt without calling Gemini")
    parser.add_argument("--model", type=str, default=None,
                        help="Gemini model name (default: gemini-3.1-pro-preview)")
    parser.add_argument("--delay", type=int, default=3,
                        help="Delay between API calls (default: 3s)")
    parser.add_argument("--resume", action="store_true",
                        help="Skip circuits that already have output files")
    args = parser.parse_args()

    circuit_specs = load_circuit_specs()

    if args.list:
        by_type = {}
        for cname, cinfo in circuit_specs.items():
            ct = cinfo.get("circuit_type", "?")
            if ct not in by_type:
                by_type[ct] = []
            by_type[ct].append((cname, cinfo.get("chapter", "?"), cinfo.get("figure", "?")))

        for ct in sorted(by_type.keys()):
            circuits = by_type[ct]
            print(f"\n{ct} ({len(circuits)} circuits):")
            for cname, ch, fig in circuits:
                print(f"  Ch {str(ch):4s}  {fig:30s}  {cname}")
        print(f"\nTotal: {len(circuit_specs)} circuits, {len(by_type)} types")
        return

    # Select circuits to process
    if args.circuit:
        if args.circuit not in circuit_specs:
            print(f"Unknown circuit: {args.circuit}")
            sys.exit(1)
        targets = [(args.circuit, circuit_specs[args.circuit])]
    elif args.type:
        targets = [(n, s) for n, s in circuit_specs.items()
                    if s.get("circuit_type") == args.type]
        if not targets:
            print(f"No circuits of type: {args.type}")
            sys.exit(1)
        print(f"Found {len(targets)} circuits of type '{args.type}'")
    else:
        targets = list(circuit_specs.items())

    os.makedirs(OUTPUT_DIR, exist_ok=True)

    results = {}
    for i, (cname, cinfo) in enumerate(targets):
        # Resume support
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
        result = run_one(cname, cinfo, dry_run=args.dry_run, model=args.model)
        if result:
            results[cname] = result
        if not args.dry_run and i < len(targets) - 1:
            time.sleep(args.delay)

    if results and not args.dry_run:
        # Save summary
        summary = os.path.join(OUTPUT_DIR, "extraction_summary.json")
        summary_data = {}
        for cname, r in results.items():
            step1 = r.get("step1_figure", {})
            metrics = r.get("step2_metrics", r.get("metrics", {}))
            tb = r.get("step3_testbench", r.get("testbench", {}))
            summary_data[cname] = {
                "schematic_figure": step1.get("schematic_figure"),
                "circuit_type": step1.get("circuit_type"),
                "num_metrics": len(metrics),
                "metrics": list(metrics.keys()),
                "has_testbench": bool(tb.get("spice")),
            }
        with open(summary, "w") as f:
            json.dump(summary_data, f, indent=2)

        # Print summary
        print(f"\n{'='*60}")
        print(f"DONE — {len(results)} circuits processed")
        total_metrics = sum(len(r.get("step2_metrics", r.get("metrics", {})))
                           for r in results.values())
        print(f"Total metrics extracted: {total_metrics}")
        print(f"Avg metrics per circuit: {total_metrics/len(results):.1f}")

        # Per-type summary
        by_type = {}
        for cname, r in results.items():
            ct = r.get("step1_figure", {}).get("circuit_type", "?")
            if ct not in by_type:
                by_type[ct] = {"count": 0, "metrics": 0}
            by_type[ct]["count"] += 1
            by_type[ct]["metrics"] += len(r.get("step2_metrics", r.get("metrics", {})))

        print(f"\nPer-type summary:")
        for ct in sorted(by_type.keys()):
            s = by_type[ct]
            avg = s["metrics"] / s["count"]
            print(f"  {ct:40s}: {s['count']:3d} circuits, {avg:.0f} avg metrics")

        print(f"\nOutput: {OUTPUT_DIR}/*.json")
        print(f"Summary: {summary}")


if __name__ == "__main__":
    main()
