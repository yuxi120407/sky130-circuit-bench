#!/usr/bin/env python3
"""
sky130-circuit-bench: Run and extract metrics from simulatable SPICE circuits.

This script demonstrates how to:
  1. List all available circuits
  2. Run a single circuit through ngspice
  3. Extract metrics (gain, power, bandwidth, etc.)
  4. Run all circuits in batch and generate a report

Usage:
    python run_simulation.py                     # List all circuits
    python run_simulation.py --run <circuit>      # Run one circuit
    python run_simulation.py --run-all            # Run all circuits
    python run_simulation.py --run-all --timeout 120  # With custom timeout

Requirements:
    - ngspice (tested with ngspice-41)
    - sky130 PDK (skywater-pdk-libs-sky130_fd_pr)

Paths below assume the SciServer/IDIES environment.
Adjust NGSPICE_BIN and PDK_LIB_PATH for your setup.
"""

import argparse
import json
import os
import re
import subprocess
import sys
import time
from pathlib import Path
from collections import defaultdict

# ──────────────────────────────────────────────────────────────────────
# Configuration — set via environment variables or defaults below
#
#   export NGSPICE_BIN=/path/to/ngspice
#   export SKY130_PDK=/path/to/sky130.lib.spice
#
# ──────────────────────────────────────────────────────────────────────
NGSPICE_BIN = os.environ.get("NGSPICE_BIN", "/home/idies/workspace/Storage/xyu1/persistent/pytorch_env/Spice/bin/ngspice")
PDK_LIB_PATH = os.environ.get("SKY130_PDK", "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice")

SPICE_DIR = Path(__file__).parent / "simulatable_spices"
RESULTS_DIR = Path(__file__).parent / "results"

# ──────────────────────────────────────────────────────────────────────
# Chapter metadata (from Baker's CMOS textbook, 3rd/4th edition)
# ──────────────────────────────────────────────────────────────────────
CHAPTER_INFO = {
    "Chap9":  "Models for Analog Design",
    "Chap10": "Models for Digital Design",
    "Chap11": "The Inverter",
    "Chap12": "Static Logic Gates",
    "Chap13": "Clocked Circuits",
    "Chap14": "Dynamic Logic Gates",
    "Chap16": "Memory Circuits",
    "Chap17": "Sensing Using Delta-Sigma Modulation",
    "Chap18": "Special Purpose CMOS Circuits",
    "Chap19": "Digital Phase-Locked Loops",
    "Chap20": "Current Mirrors",
    "Chap21": "Amplifiers",
    "Chap22": "Differential Amplifiers",
    "Chap23": "Voltage References",
    "Chap24": "Operational Amplifiers I",
    "Chap25": "Dynamic Analog Circuits",
    "Chap26": "Operational Amplifiers II",
    "Chap27": "Nonlinear Analog Circuits",
    "Chap31": "Feedback Amplifiers",
    "Chap32": "Hysteretic Power Converters",
}


def get_circuit_chapter(name):
    """Extract chapter from circuit name."""
    m = re.match(r"(Chap\d+)", name)
    if m:
        return m.group(1)
    if name.startswith("_Extras"):
        return "_Extras"
    return "Custom"


def detect_analysis_type(spice_text):
    """Detect primary analysis type from SPICE content."""
    lower = spice_text.lower()
    if "ac dec" in lower or ".ac " in lower:
        return "AC"
    elif ".tran " in lower or "tran " in lower:
        return "Tran"
    elif "dc " in lower:
        return "DC"
    elif ".op" in lower:
        return "OP"
    return "Unknown"


def list_circuits():
    """List all available circuits grouped by chapter."""
    if not SPICE_DIR.exists():
        print(f"Error: {SPICE_DIR} not found")
        return []

    circuits = []
    for f in sorted(SPICE_DIR.glob("*.spice")):
        name = f.stem
        content = f.read_text()
        analysis = detect_analysis_type(content)
        chapter = get_circuit_chapter(name)
        circuits.append({
            "name": name,
            "path": str(f),
            "chapter": chapter,
            "analysis": analysis,
        })

    by_chapter = defaultdict(list)
    for c in circuits:
        by_chapter[c["chapter"]].append(c)

    print(f"\nsky130-circuit-bench: {len(circuits)} simulatable circuits\n")
    print(f"{'Chapter':<10} {'Topic':<45} {'Count':>5}")
    print("-" * 65)

    for ch in sorted(by_chapter.keys(), key=lambda x: (0 if x.startswith("Chap") else 1, x)):
        items = by_chapter[ch]
        topic = CHAPTER_INFO.get(ch, ch)
        print(f"{ch:<10} {topic:<45} {len(items):>5}")

    print("-" * 65)
    print(f"{'Total':<56} {len(circuits):>5}")

    return circuits


def extract_metrics(stdout):
    """Extract numeric metrics from ngspice stdout.

    Returns a dict of {metric_name: float_value}.
    Filters out ngspice internal variables.
    """
    skip = {"nodes", "transistor", "source", "voltage", "temp", "tnom",
            "no", "reference", "of", "data", "all", "rows"}
    metrics = {}
    for m in re.finditer(
        r"(\w+)\s*=\s*([+-]?\d+(?:\.\d+)?(?:[eE][+-]?\d+)?)", stdout
    ):
        name, val = m.groups()
        if name.lower() not in skip:
            try:
                metrics[name] = float(val)
            except ValueError:
                pass
    return metrics


def run_circuit(circuit_name, timeout=60, verbose=False):
    """Run a single circuit through ngspice.

    Args:
        circuit_name: Name without .spice extension, e.g. 'five_trans_ota'
        timeout: Max simulation time in seconds
        verbose: Print full ngspice output

    Returns:
        dict with keys: name, success, metrics, time_s, error
    """
    spice_file = SPICE_DIR / f"{circuit_name}.spice"
    if not spice_file.exists():
        return {
            "name": circuit_name,
            "success": False,
            "metrics": {},
            "time_s": 0,
            "error": f"File not found: {spice_file}",
        }

    # Resolve ${SKY130_PDK} in spice file to actual PDK path
    spice_text = spice_file.read_text()
    if "${SKY130_PDK}" in spice_text:
        if not os.path.exists(PDK_LIB_PATH):
            return {
                "name": circuit_name,
                "success": False,
                "metrics": {},
                "time_s": 0,
                "error": f"SKY130 PDK not found at {PDK_LIB_PATH}. Set SKY130_PDK env variable.",
            }
        resolved_text = spice_text.replace("${SKY130_PDK}", PDK_LIB_PATH)
        tmp_file = RESULTS_DIR / f"_tmp_{circuit_name}.spice"
        RESULTS_DIR.mkdir(parents=True, exist_ok=True)
        tmp_file.write_text(resolved_text)
        run_file = tmp_file
    else:
        run_file = spice_file

    def _cleanup():
        if run_file != spice_file and run_file.exists():
            run_file.unlink()

    start = time.time()
    try:
        result = subprocess.run(
            [NGSPICE_BIN, "-b", str(run_file.resolve())],
            capture_output=True,
            text=True,
            timeout=timeout,
        )
        elapsed = time.time() - start
        stdout = result.stdout or ""
        stderr = result.stderr or ""
    except subprocess.TimeoutExpired:
        elapsed = time.time() - start
        _cleanup()
        return {
            "name": circuit_name,
            "success": False,
            "metrics": {},
            "time_s": elapsed,
            "error": f"Timeout after {timeout}s",
        }
    except FileNotFoundError:
        _cleanup()
        return {
            "name": circuit_name,
            "success": False,
            "metrics": {},
            "time_s": 0,
            "error": f"ngspice not found at {NGSPICE_BIN}",
        }

    _cleanup()

    if verbose:
        print(f"\n--- ngspice stdout ---\n{stdout}")
        if stderr:
            print(f"\n--- ngspice stderr ---\n{stderr}")

    # Check for fatal errors
    combined = (stdout + stderr).lower()
    for pat in ["error: could not find", "error: unknown subckt",
                "error: no model", "segmentation fault"]:
        if pat in combined:
            return {
                "name": circuit_name,
                "success": False,
                "metrics": {},
                "time_s": elapsed,
                "error": f"ngspice error: {pat}",
            }

    metrics = extract_metrics(stdout)

    return {
        "name": circuit_name,
        "success": len(metrics) > 0,
        "metrics": metrics,
        "time_s": round(elapsed, 2),
        "error": "" if metrics else "No metrics extracted",
    }


def run_all(timeout=60):
    """Run all circuits and generate a report."""
    circuits = list_circuits()
    if not circuits:
        return

    RESULTS_DIR.mkdir(parents=True, exist_ok=True)

    print(f"\nRunning {len(circuits)} circuits (timeout={timeout}s each)...\n")

    results = []
    passed = 0
    failed = 0
    report_path = RESULTS_DIR / "simulation_report.json"

    for i, circ in enumerate(circuits, 1):
        name = circ["name"]
        sys.stdout.write(f"  [{i:3d}/{len(circuits)}] {name:<55} ")
        sys.stdout.flush()

        r = run_circuit(name, timeout=timeout)
        results.append(r)

        if r["success"]:
            passed += 1
            n_metrics = len(r["metrics"])
            print(f"PASS  ({r['time_s']:.1f}s, {n_metrics} metrics)")
        else:
            failed += 1
            print(f"FAIL  ({r['error']})")

        # Save after each circuit so results are never lost
        with open(report_path, "w") as f:
            json.dump(results, f, indent=2)

    # Summary
    print(f"\n{'=' * 65}")
    print(f"RESULTS: {passed} passed, {failed} failed, {len(circuits)} total")
    print(f"{'=' * 65}")
    print(f"\nReport saved to {report_path}")

    # Save summary CSV
    csv_path = RESULTS_DIR / "metrics_summary.csv"
    all_metric_names = set()
    for r in results:
        all_metric_names.update(r["metrics"].keys())
    all_metric_names = sorted(all_metric_names)

    with open(csv_path, "w") as f:
        header = ["circuit", "chapter", "analysis", "success", "time_s"] + all_metric_names
        f.write(",".join(header) + "\n")
        for r in results:
            name = r["name"]
            chapter = get_circuit_chapter(name)
            spice_file = SPICE_DIR / f"{name}.spice"
            analysis = detect_analysis_type(spice_file.read_text()) if spice_file.exists() else ""
            row = [name, chapter, analysis, str(r["success"]), str(r["time_s"])]
            for mn in all_metric_names:
                row.append(str(r["metrics"].get(mn, "")))
            f.write(",".join(row) + "\n")

    print(f"CSV saved to {csv_path}")

    return results


def main():
    parser = argparse.ArgumentParser(
        description="sky130-circuit-bench: simulate and extract metrics from CMOS circuits"
    )
    parser.add_argument("--run", type=str, help="Run a single circuit by name")
    parser.add_argument("--run-all", action="store_true", help="Run all circuits")
    parser.add_argument("--timeout", type=int, default=60, help="Timeout per circuit in seconds (default: 60)")
    parser.add_argument("--verbose", "-v", action="store_true", help="Show full ngspice output")
    parser.add_argument("--list", action="store_true", help="List all circuits")

    args = parser.parse_args()

    if args.run:
        r = run_circuit(args.run, timeout=args.timeout, verbose=args.verbose)
        print(f"\nCircuit: {r['name']}")
        print(f"Success: {r['success']}")
        print(f"Time:    {r['time_s']:.2f}s")
        if r["error"]:
            print(f"Error:   {r['error']}")
        if r["metrics"]:
            print(f"\nMetrics:")
            for k, v in sorted(r["metrics"].items()):
                print(f"  {k:<20} = {v:.6g}")

    elif args.run_all:
        run_all(timeout=args.timeout)

    else:
        list_circuits()
        print("\nUsage examples:")
        print(f"  python {sys.argv[0]} --list                          # List circuits")
        print(f"  python {sys.argv[0]} --run five_trans_ota            # Run one circuit")
        print(f"  python {sys.argv[0]} --run five_trans_ota -v         # Verbose output")
        print(f"  python {sys.argv[0]} --run-all                       # Run all circuits")
        print(f"  python {sys.argv[0]} --run-all --timeout 120         # With longer timeout")


if __name__ == "__main__":
    main()
