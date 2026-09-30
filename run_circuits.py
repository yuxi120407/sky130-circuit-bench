"""
Run circuits from circuit_collection/ through NgSPICE and extract measured values.

Usage:
    python run_circuits.py                                # run all pass circuits
    python run_circuits.py --status pass                  # run pass only (default)
    python run_circuits.py --status all                   # run all 989
    python run_circuits.py --source baker                 # baker only
    python run_circuits.py --category Amplifiers          # one category
    python run_circuits.py --circuit Chap11_LTspice_Fig11_10  # single circuit
    python run_circuits.py --limit 10                     # first 10 only
    python run_circuits.py --timeout 120                  # custom timeout (seconds)
    python run_circuits.py --output results.json          # save results to file
"""

import argparse
import json
import os
import re
import subprocess
import time
from collections import Counter

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
COLLECTION_DIR = os.path.join(SCRIPT_DIR, "circuit_collection")
INDEX_PATH = os.path.join(COLLECTION_DIR, "circuit_index.json")

NGSPICE_BIN = os.environ.get(
    "NGSPICE_BIN",
    "/home/idies/workspace/Storage/xyu1/persistent/pytorch_env/Spice/bin/ngspice",
)

TIMEOUT_SEC = 60


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


def parse_values(stdout):
    """Extract measured values from NgSPICE output."""
    values = {}
    for line in stdout.split("\n"):
        m = re.match(r"\s*(\w[\w\[\]]*)\s*=\s*([+-]?\d+\.?\d*[eE]?[+-]?\d*)", line)
        if m:
            try:
                values[m.group(1)] = float(m.group(2))
            except ValueError:
                pass
    return values


def check_errors(stdout, stderr):
    """Check for syntax/simulation errors."""
    errors = []
    combined = (stdout + "\n" + stderr).lower()
    error_patterns = [
        "error:", "fatal:", "unknown subckt",
        "no such file", "can't open", "undefined",
        "singular matrix", "no convergence",
    ]
    for pat in error_patterns:
        for line in combined.split("\n"):
            if pat in line and line.strip() not in [e.lower() for e in errors]:
                errors.append(line.strip()[:200])
    return errors[:10]


def load_index():
    """Load circuit_index.json."""
    with open(INDEX_PATH) as f:
        return json.load(f)


def main():
    parser = argparse.ArgumentParser(description="Run circuits from circuit_collection/")
    parser.add_argument("--status", choices=["pass", "fail", "all"], default="pass",
                        help="Which circuits to run (default: pass)")
    parser.add_argument("--source", choices=["baker", "rocktnet"], default=None)
    parser.add_argument("--category", type=str, default=None,
                        help="Filter by category (e.g. 'Amplifiers')")
    parser.add_argument("--circuit", type=str, default=None,
                        help="Run a single circuit by name")
    parser.add_argument("--limit", type=int, default=None)
    parser.add_argument("--timeout", type=int, default=TIMEOUT_SEC)
    parser.add_argument("--output", type=str, default=None,
                        help="Save results to JSON file")
    parser.add_argument("--verbose", "-v", action="store_true")
    args = parser.parse_args()

    index = load_index()
    circuits = index["circuits"]

    # Filter
    if args.circuit:
        circuits = [c for c in circuits if c["name"] == args.circuit]
    else:
        if args.status == "pass":
            circuits = [c for c in circuits if c["status"] == "pass"]
        elif args.status == "fail":
            circuits = [c for c in circuits if c["status"] != "pass"]

        if args.source:
            circuits = [c for c in circuits if c["source"] == args.source]

        if args.category:
            cat_lower = args.category.lower()
            circuits = [c for c in circuits
                        if cat_lower in c.get("category", "").lower()]

    if args.limit:
        circuits = circuits[:args.limit]

    print(f"Running {len(circuits)} circuits (timeout={args.timeout}s)")
    print()

    results = []
    stats = Counter()

    for i, entry in enumerate(circuits):
        name = entry["name"]
        source = entry["source"]
        sp_file = entry.get("file")

        if not sp_file:
            print(f"[{i+1}/{len(circuits)}] {source}/{name}: NO FILE")
            stats["no_file"] += 1
            continue

        sp_path = os.path.join(COLLECTION_DIR, sp_file)
        if not os.path.exists(sp_path):
            print(f"[{i+1}/{len(circuits)}] {source}/{name}: FILE MISSING")
            stats["missing"] += 1
            continue

        returncode, stdout, stderr, elapsed = run_ngspice(sp_path, timeout=args.timeout)

        if returncode == -1:
            print(f"[{i+1}/{len(circuits)}] {source}/{name}: TIMEOUT ({args.timeout}s)")
            stats["timeout"] += 1
            results.append({
                "name": name, "source": source,
                "category": entry.get("category", ""),
                "circuit_type": entry.get("circuit_type", ""),
                "result": "TIMEOUT", "values": {}, "elapsed": args.timeout,
            })
            continue

        values = parse_values(stdout)
        errors = check_errors(stdout, stderr)

        if errors:
            status = "ERROR"
            stats["error"] += 1
        elif values:
            status = "PASS"
            stats["pass"] += 1
        else:
            status = "NO_VALUES"
            stats["no_values"] += 1

        val_str = ", ".join(f"{k}={v:.4g}" for k, v in list(values.items())[:5])
        print(f"[{i+1}/{len(circuits)}] {source}/{name:<45s} {status}  ({elapsed:.1f}s, {len(values)} values: {val_str})")

        if args.verbose and errors:
            for e in errors[:3]:
                print(f"    ! {e}")

        results.append({
            "name": name,
            "source": source,
            "category": entry.get("category", ""),
            "circuit_type": entry.get("circuit_type", ""),
            "result": status,
            "values": values,
            "errors": errors if errors else [],
            "elapsed": round(elapsed, 2),
        })

    # Summary
    print()
    print("=" * 60)
    print(f"RESULTS: {len(results)} circuits")
    print(f"  PASS:      {stats['pass']}")
    print(f"  ERROR:     {stats['error']}")
    print(f"  NO_VALUES: {stats['no_values']}")
    print(f"  TIMEOUT:   {stats['timeout']}")
    if stats["missing"]:
        print(f"  MISSING:   {stats['missing']}")
    print("=" * 60)

    if args.output:
        output = {
            "total": len(results),
            "stats": dict(stats),
            "results": results,
        }
        with open(args.output, "w") as f:
            json.dump(output, f, indent=2)
        print(f"\nResults saved to {args.output}")


if __name__ == "__main__":
    main()
