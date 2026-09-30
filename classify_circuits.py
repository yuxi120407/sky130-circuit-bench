"""
Classify circuits into functional categories.

Hierarchical taxonomy:
  1. Amplifiers              (OTA, Op-Amp, Diff-Amp, Cascode, VGA, Buffer, etc.)
  2. Clock & Frequency Gen   (Ring Osc, VCO, PLL, CDR, Clock gen, etc.)
  3. Data Converters         (ADC, DAC, S/H, SC sampler, etc.)
  4. Comparators             (StrongARM, dynamic, clocked, etc.)
  5. References & Regulators (Bandgap, LDO, Voltage ref, Current ref, Bias, etc.)
  6. Power Management        (Charge pump, DC-DC, Level shifter, etc.)
  7. RF & Mixer              (Mixer, LNA, PA, Balun, etc.)
  8. SerDes & High-Speed I/O (Equalizer, CML driver, LVDS, line driver, etc.)
  9. Digital & Logic         (Inverter, NAND, NOR, Flip-flop, Latch, Mux, etc.)
  10. Memory & Sensing       (SRAM, Flash, Sense amp, etc.)
  11. Filters                (Low-pass, High-pass, Gm-C, Switched-cap filter, etc.)
  12. Other

Usage:
    python classify_circuits.py                      # classify all
    python classify_circuits.py --source baker       # baker only
    python classify_circuits.py --source rocktnet    # rocktnet only
    python classify_circuits.py --summary            # print category counts only
"""

import argparse
import json
import os
import re
import subprocess
import sys
import glob
import time
from collections import Counter, defaultdict

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
BAKER_DIR = os.path.join(SCRIPT_DIR, "extracted_metrics")
ROCKTNET_DIR = os.path.join(SCRIPT_DIR, "extracted_metrics_rocktnet")
OUTPUT_DIR = os.path.join(SCRIPT_DIR, "verification_results")

# ── Category definitions ──
# Each category: (name, keywords) — first match wins, so order matters.
# Keywords are matched against lowercased circuit_type string.

CATEGORIES = [
    # Subcircuits / Building Blocks — match first to exclude from functional types
    # NOTE: order keywords carefully to avoid catching standalone circuits
    #   e.g. "Beta-Multiplier Reference" has "current" but is a Reference, not subcircuit
    #   So we DON'T match generic "current" — only specific subcircuit patterns
    ("Subcircuit / Building Block", [
        "current mirror", "current_mirror", "cascode mirror",
        "wilson mirror", "widlar",
        "differential pair", "diff pair", "diff-pair",
        "bias cell", "bias stage",
        "current source", "current sink", "tail current",
        "active load", "diode-connected", "diode connected",
        "transmission gate", "pass gate", "pass-gate",
        "single nmos transistor", "single pmos transistor",
        "sub-block", "subblock",
        "replica bias",
        "passive rc network", "passive bias",
        "pi-model", "pi model",
    ]),

    # 9. Digital & Logic — match early to avoid "inverter" hitting Amplifiers
    ("Digital & Logic", [
        "inverter", "nand", "nor", "xor", "xnor", "flip-flop", "flip_flop",
        "flipflop", "dff", "d-ff", "latch", "register", "mux", "multiplexer",
        "demux", "decoder", "encoder", "counter", "divider", "divide-by",
        "schmitt trigger", "logic gate", "cml gate", "ecl gate",
        "buffer chain", "tapered buffer", "cascaded inverter",
        "cmos buffer", "digital buffer",
    ]),

    # 10. Memory & Sensing
    ("Memory & Sensing", [
        "sram", "dram", "flash", "memory", "sense amp", "sense_amp",
        "sensing", "bit line", "bitline", "word line", "wordline",
        "cam ", "content-addressable",
    ]),

    # 8. SerDes & High-Speed I/O — match before RF and Amplifiers
    #    Be specific — "buffer" alone is too broad (matches op-amp output buffers)
    ("SerDes & High-Speed I/O", [
        "equalizer", "ffe", "dfe", "ctle",
        "cml driver", "cml output",
        "lvds driver", "lvds transmit", "lvds receiv",
        "line driver", "serdes", "ser/des",
        "pre-emphasis", "pre emphasis",
        "eye diagram", "high-speed link", "high speed link",
        "transmitter driver", "receiver front",
    ]),

    # 7. RF & Mixer — match before Amplifiers so "LNA" doesn't become generic amp
    ("RF & Mixer", [
        "mixer", "lna ", "low noise amplifier", "low-noise amplifier",
        "balun", "power amplifier", " pa ", "rf front",
        "down-convert", "up-convert", "demodulator", "modulator",
        "gilbert cell", "double-balanced", "single-balanced",
        "passive mixer", "active mixer",
        "quadrature", "iq ", "i/q",
    ]),

    # 3. Data Converters (includes S&H, SC sampler as ADC sub-blocks)
    ("Data Converters", [
        "adc", "dac", "analog-to-digital", "digital-to-analog",
        "sample-and-hold", "sample and hold", "track-and-hold", "s/h",
        "sc sampler", "switched-capacitor sampler",
        "flash adc", "sar ", "sigma-delta", "delta-sigma", "dsm",
        "pipeline", "successive approximation",
        "current steering", "current cell", "r-2r", "r2r",
        "quantizer", "thermometer",
    ]),

    # 4. Comparators
    ("Comparators", [
        "comparator", "comp ", "strongarm", "strong-arm",
        "dynamic comparator", "clocked comparator",
        "regenerative", "sense amplifier latch",
    ]),

    # 2. Clock & Frequency Generation (includes CDR)
    ("Clock & Frequency Generation", [
        "oscillator", "osc ", "ring osc", "vco", "dco", "nco",
        "pll", "phase-locked", "phase locked", "dll", "delay-locked",
        "clock gen", "clock recov", "cdr", "clock and data recovery",
        "frequency synth", "freq synth", "frequency multiplier",
        "freq doubler", "frequency doubler",
        "colpitts", "hartley", "crystal osc", "relaxation",
        "multivibrator", "astable", "timer",
        "lc tank", "resonator",
        "clock driver",
    ]),

    # 5. References & Regulators
    ("References & Regulators", [
        "bandgap", "bgr", "voltage ref", "voltage_ref", "vref",
        "current ref", "current_ref", "iref", "current mirror ref",
        "ldo", "regulator", "low dropout", "low-dropout",
        "beta-multiplier", "beta multiplier", "bmr",
        "bias circuit", "bias gen", "bias network", "biasing",
        "constant-gm", "constant gm", "self-bias",
        "start-up", "startup",
    ]),

    # 11. Filters — standalone category (NOT under Data Converters)
    ("Filters", [
        "filter", "low-pass", "low pass", "high-pass", "high pass",
        "band-pass", "band pass", "notch", "all-pass", "all pass",
        "gm-c", "gm_c", "switched-cap filter", "sc filter",
        "biquad", "butterworth", "chebyshev", "elliptic",
    ]),

    # 6. Power Management
    ("Power Management", [
        "charge pump", "charge_pump", "dc-dc", "dc_dc", "dcdc",
        "boost converter", "buck converter", "switching regulator",
        "level shift", "level_shift", "voltage doubler",
        "power management", "pmic", "energy harvest",
        "rectifier", "envelope detect",
        "power gating", "header circuit",
    ]),

    # 1. Amplifiers — broadest category, match last among functional blocks
    ("Amplifiers", [
        "ota", "op-amp", "op amp", "opamp", "operational amplifier",
        "operational transconductance",
        "diff amp", "diff-amp", "differential amplifier", "differential pair",
        "cascode amp", "cascode amplifier", "telescopic",
        "folded cascode", "folded-cascode",
        "two-stage", "two stage", "2-stage", "miller comp",
        "class-ab", "class ab", "push-pull", "push pull",
        "source follower", "common source", "common-source",
        "common gate", "common-gate", "common drain", "common-drain",
        "transimpedance", "tia", "trans-impedance",
        "vga", "variable gain", "programmable gain",
        "instrumentation amp", "fully differential",
        "cmfb", "common-mode feedback",
        "amplifier", " amp ", "gain stage",
        "current mirror ota", "nmcnr", "smc ", "dfcfc", "iac ",
        "feedforward", "feed-forward",
    ]),

    # 12. Other — catch-all
    ("Other", []),
]


def classify(circuit_type):
    """Return (major_category, matched_keyword) for a circuit type string."""
    ct = circuit_type.lower().strip()
    if not ct:
        return "Other", ""

    for category, keywords in CATEGORIES:
        for kw in keywords:
            if kw in ct:
                return category, kw

    return "Other", ""


CATEGORY_NAMES = [cat for cat, _ in CATEGORIES if cat != "Other"]

GEMINI_SCRIPT = os.path.join(SCRIPT_DIR, "test", "gemini_call_v2.py")
SAM3_PYTHON = "/home/idies/workspace/Storage/xyu1/persistent/pytorch_env/sam3_gcloud/bin/python3"
GEMINI_MODEL = "gemini-3.1-pro-preview"

GEMINI_CLASSIFY_PROMPT = f"""\
You are classifying analog/mixed-signal circuits into categories.

Categories:
{chr(10).join(f"  - {c}" for c in CATEGORY_NAMES)}
  - Other

Rules:
- Pick exactly ONE category that best describes the circuit's primary function.
- If it is a sub-block (current mirror, diff pair, bias cell) with no standalone function, pick "Subcircuit / Building Block".
- If none fit, pick "Other".
- Reply with ONLY the category name, nothing else.
"""


def classify_with_gemini(circuit_type):
    """Use Gemini to classify a circuit type string. Returns category name."""
    prompt = GEMINI_CLASSIFY_PROMPT + f'\nCircuit: "{circuit_type}"\nCategory:'
    proc = subprocess.run(
        [SAM3_PYTHON, GEMINI_SCRIPT, "--model", GEMINI_MODEL],
        input=prompt,
        capture_output=True,
        text=True,
        timeout=120,
    )
    if proc.returncode != 0:
        return "Other"
    try:
        result = json.loads(proc.stdout)
    except json.JSONDecodeError:
        return "Other"
    if not result.get("ok"):
        return "Other"

    response = result["text"].strip().strip('"').strip("'")
    # Match response to a valid category name
    for cat in CATEGORY_NAMES:
        if cat.lower() == response.lower():
            return cat
        if cat.lower() in response.lower():
            return cat
    return "Other"


def load_circuits(source):
    """Load (name, source, circuit_type, json_path) tuples."""
    circuits = []

    if source in ("baker", "all"):
        for f in sorted(glob.glob(os.path.join(BAKER_DIR, "*.json"))):
            name = os.path.basename(f).replace(".json", "")
            with open(f) as fh:
                d = json.load(fh)
            if "_error" in d:
                continue
            ct = ""
            for k in ("step1_figure", "step1_analysis"):
                if k in d:
                    ct = d[k].get("circuit_type", "")
                    break
            circuits.append({"name": name, "source": "baker",
                             "circuit_type": ct, "path": f})

    if source in ("rocktnet", "all"):
        for f in sorted(glob.glob(os.path.join(ROCKTNET_DIR, "*.json"))):
            name = os.path.basename(f).replace(".json", "")
            with open(f) as fh:
                d = json.load(fh)
            if "_error" in d:
                continue
            ct = ""
            for k in ("step1_figure", "step1_analysis"):
                if k in d:
                    ct = d[k].get("circuit_type", "")
                    break
            circuits.append({"name": name, "source": "rocktnet",
                             "circuit_type": ct, "path": f})

    return circuits


def _save_json(out_path, results, source, category_counts):
    out_data = {
        "total": len(results),
        "source": source,
        "category_counts": dict(category_counts),
        "circuits": [{
            "name": r["name"],
            "source": r["source"],
            "circuit_type": r["circuit_type"],
            "category": r["category"],
            "method": r.get("method", "keyword"),
        } for r in results],
    }
    with open(out_path, "w") as f:
        json.dump(out_data, f, indent=2)


def main():
    parser = argparse.ArgumentParser(description="Classify circuits into categories")
    parser.add_argument("--source", choices=["baker", "rocktnet", "all"], default="all")
    parser.add_argument("--summary", action="store_true", help="Print counts only")
    parser.add_argument("--save", action="store_true", help="Save classification to JSON")
    parser.add_argument("--use-gemini", action="store_true",
                        help="Use Gemini to classify circuits that keywords can't match")
    parser.add_argument("--gemini-all", action="store_true",
                        help="Use Gemini to classify ALL circuits (keywords as fallback)")
    parser.add_argument("--resume", action="store_true",
                        help="Skip circuits already classified by Gemini in previous run")
    args = parser.parse_args()

    circuits = load_circuits(args.source)
    print(f"Loaded {len(circuits)} circuits from {args.source}\n")

    # Step 1: Keyword classification for all circuits
    results = []
    unclassified = []
    category_counts = Counter()
    category_circuits = defaultdict(list)

    for c in circuits:
        cat, kw = classify(c["circuit_type"])
        c["category"] = cat
        c["matched_keyword"] = kw
        c["method"] = "keyword"
        results.append(c)
        if cat == "Other" and c["circuit_type"]:
            unclassified.append(c)
        category_counts[cat] += 1
        category_circuits[cat].append(c)

    # Step 2: Use Gemini for "Other" circuits (if --use-gemini)
    if args.use_gemini and unclassified:
        print(f"Using Gemini to classify {len(unclassified)} unmatched circuits...\n",
              flush=True)
        gemini_fixed = 0
        for i, c in enumerate(unclassified):
            print(f"  [{i+1}/{len(unclassified)}] {c['circuit_type'][:60]}... ",
                  end="", flush=True)
            new_cat = classify_with_gemini(c["circuit_type"])
            print(f"-> {new_cat}", flush=True)

            if new_cat != "Other" and new_cat != c["category"]:
                # Update counts
                category_counts[c["category"]] -= 1
                category_circuits[c["category"]].remove(c)
                c["category"] = new_cat
                c["method"] = "gemini"
                category_counts[new_cat] += 1
                category_circuits[new_cat].append(c)
                gemini_fixed += 1

            time.sleep(0.5)

        print(f"\nGemini reclassified {gemini_fixed}/{len(unclassified)} circuits\n")

    # Step 3: Use Gemini for ALL circuits (if --gemini-all)
    if args.gemini_all:
        # Load previous Gemini results for --resume
        out_path = os.path.join(OUTPUT_DIR, "circuit_classification.json")
        prev_gemini = {}
        if args.resume and os.path.exists(out_path):
            with open(out_path) as f:
                prev_data = json.load(f)
            for c in prev_data.get("circuits", []):
                if c.get("method") == "gemini":
                    prev_gemini[(c["source"], c["name"])] = c["category"]

        to_classify = []
        for c in results:
            if not c["circuit_type"]:
                continue
            if args.resume and (c["source"], c["name"]) in prev_gemini:
                # Use cached Gemini result
                new_cat = prev_gemini[(c["source"], c["name"])]
                if new_cat != c["category"]:
                    category_counts[c["category"]] -= 1
                    category_circuits[c["category"]].remove(c)
                    c["category"] = new_cat
                    c["method"] = "gemini"
                    category_counts[new_cat] += 1
                    category_circuits[new_cat].append(c)
            else:
                to_classify.append(c)

        if args.resume and prev_gemini:
            print(f"Resumed {len(prev_gemini)} cached Gemini results")

        if to_classify:
            print(f"Classifying {len(to_classify)} circuits with Gemini...\n", flush=True)
            gemini_changed = 0
            for i, c in enumerate(to_classify):
                ct_short = c["circuit_type"][:60]
                kw_cat = c["category"]
                print(f"  [{i+1}/{len(to_classify)}] {ct_short}...", flush=True)
                print(f"    keyword: {kw_cat}", flush=True)

                gemini_cat = classify_with_gemini(c["circuit_type"])
                print(f"    gemini:  {gemini_cat}", flush=True)

                if gemini_cat != kw_cat:
                    category_counts[kw_cat] -= 1
                    category_circuits[kw_cat].remove(c)
                    c["category"] = gemini_cat
                    c["method"] = "gemini"
                    category_counts[gemini_cat] += 1
                    category_circuits[gemini_cat].append(c)
                    gemini_changed += 1
                    print(f"    >>> CHANGED: {kw_cat} -> {gemini_cat}", flush=True)
                else:
                    c["method"] = "gemini"

                # Save incrementally every 50 circuits
                if (i + 1) % 50 == 0:
                    os.makedirs(OUTPUT_DIR, exist_ok=True)
                    _save_json(out_path, results, args.source, category_counts)
                    print(f"    (saved checkpoint at {i+1})", flush=True)

                time.sleep(0.5)

            print(f"\nGemini changed {gemini_changed}/{len(to_classify)} classifications\n")

    # Print summary table
    print(f"{'Category':<25} {'Count':>6}  {'%':>5}")
    print("-" * 40)
    for cat, _ in CATEGORIES:
        cnt = category_counts.get(cat, 0)
        pct = 100 * cnt / len(results) if results else 0
        print(f"{cat:<25} {cnt:>6}  {pct:>5.1f}%")
    print("-" * 40)
    print(f"{'TOTAL':<25} {len(results):>6}")

    # Per-source breakdown
    if args.source == "all":
        print()
        for src in ("baker", "rocktnet"):
            src_results = [r for r in results if r["source"] == src]
            src_counts = Counter(r["category"] for r in src_results)
            print(f"\n  {src.upper()} ({len(src_results)} circuits):")
            for cat, _ in CATEGORIES:
                cnt = src_counts.get(cat, 0)
                if cnt > 0:
                    print(f"    {cat:<25} {cnt:>4}")

    if not args.summary:
        # Show circuits per category
        print()
        for cat, _ in CATEGORIES:
            circs = category_circuits.get(cat, [])
            if not circs:
                continue
            print(f"\n{'='*60}")
            print(f"{cat} ({len(circs)} circuits)")
            print(f"{'='*60}")
            for c in circs[:20]:
                print(f"  [{c['source']:>8}] {c['name']}")
                print(f"           {c['circuit_type'][:80]}")
            if len(circs) > 20:
                print(f"  ... and {len(circs)-20} more")

    # Save to JSON
    if args.save or args.gemini_all:
        os.makedirs(OUTPUT_DIR, exist_ok=True)
        out_path = os.path.join(OUTPUT_DIR, "circuit_classification.json")
        _save_json(out_path, results, args.source, category_counts)
        print(f"\nSaved classification to {out_path}")


if __name__ == "__main__":
    main()
