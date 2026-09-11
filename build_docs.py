#!/usr/bin/env python3
"""
Build GitHub Pages site from baker_circuit_specs.json + results CSV + SPICE files.
Each circuit row is clickable → expands to show testbench, parameters, metrics.
"""

import ast
import csv
import json
import os
import re
import html as htmlmod

BENCH_DIR = os.path.dirname(os.path.abspath(__file__))
SPECS_JSON = os.path.join(BENCH_DIR, "baker_circuit_specs.json")
BAKER_RESULTS_CSV = os.path.join(BENCH_DIR, "results", "baker_textbook", "metrics_summary.csv")
ROCKTNET_RESULTS_CSV = os.path.join(BENCH_DIR, "results", "rocktnet", "metrics_summary.csv")
BAKER_DIR = os.path.join(BENCH_DIR, "ready_circuits", "baker_textbook")
ROCKTNET_DIR = os.path.join(BENCH_DIR, "ready_circuits", "rocktnet")
NEEDS_FIX_DIR = os.path.join(BENCH_DIR, "needs_fix", "rocktnet")
DOCS_DIR = os.path.join(BENCH_DIR, "docs")

DISPLAY_METRICS = {
    "dc_gain_db":    {"label": "DC Gain",       "unit": "dB",  "goal": "maximize"},
    "ugbw":          {"label": "UGBW",           "unit": "Hz",  "goal": "maximize"},
    "ugbw_hz":       {"label": "UGBW",           "unit": "Hz",  "goal": "maximize"},
    "power_dc":      {"label": "DC Power",       "unit": "W",   "goal": "minimize"},
    "avg_power":     {"label": "Avg Power",      "unit": "W",   "goal": "minimize"},
    "power_uw":      {"label": "Power",          "unit": "uW",  "goal": "minimize"},
    "rise_time":     {"label": "Rise Time",      "unit": "s",   "goal": "minimize"},
    "fall_time":     {"label": "Fall Time",      "unit": "s",   "goal": "minimize"},
    "vout_swing":    {"label": "Output Swing",   "unit": "V",   "goal": "maximize"},
    "iout_mid":      {"label": "I_out (mid)",    "unit": "A",   "goal": "match"},
    "rout_mid":      {"label": "R_out (mid)",    "unit": "Ohm", "goal": "maximize"},
    "vref":          {"label": "V_ref",          "unit": "V",   "goal": "match"},
    "psrr_100hz_db": {"label": "PSRR@100Hz",    "unit": "dB",  "goal": "maximize"},
    "dropout_mv":    {"label": "Dropout",        "unit": "mV",  "goal": "minimize"},
    "vout_max":      {"label": "V_out max",      "unit": "V",   "goal": "info"},
    "vout_min":      {"label": "V_out min",      "unit": "V",   "goal": "info"},
    "vout_dc":       {"label": "V_out DC",       "unit": "V",   "goal": "info"},
    "period":        {"label": "Period",         "unit": "s",   "goal": "info"},
    "power_avg":     {"label": "Avg Power",      "unit": "W",   "goal": "minimize"},
    "gain_db":       {"label": "Gain",           "unit": "dB",  "goal": "maximize"},
}


def fmt_value(val):
    try:
        val = float(val)
    except (TypeError, ValueError):
        return str(val)
    av = abs(val)
    if av == 0:
        return "0"
    if av >= 1e6:
        return f"{val:.3g}"
    if av >= 1:
        return f"{val:.4g}"
    if av >= 1e-3:
        return f"{val:.4g}"
    return f"{val:.3g}"


def parse_spice_header(filepath):
    """Extract Variables, Trial values, Metrics, Class from SPICE header comments."""
    variables = []
    trial_values = []
    header_metrics = []
    circuit_class = ""

    with open(filepath) as f:
        for line in f:
            line = line.strip()
            if not line.startswith("*"):
                break
            m = re.match(r'\* Variables:\s*(.+)', line)
            if m:
                try:
                    variables = ast.literal_eval(m.group(1))
                except:
                    pass
            m = re.match(r'\* Trial values \(midpoint\):\s*(.+)', line)
            if m:
                try:
                    trial_values = ast.literal_eval(m.group(1))
                except:
                    pass
            m = re.match(r'\* Metrics:\s*(.+)', line)
            if m:
                try:
                    header_metrics = ast.literal_eval(m.group(1))
                except:
                    pass
            m = re.match(r'\* Class:\s*(.+)', line)
            if m:
                circuit_class = m.group(1).strip()

    params = []
    for i, v in enumerate(variables):
        default = trial_values[i] if i < len(trial_values) else None
        params.append({"name": v, "default": default})

    return params, header_metrics, circuit_class


def read_spice_content(filepath):
    with open(filepath) as f:
        return f.read()


def load_results_csv(csv_path):
    results = {}
    if not os.path.exists(csv_path):
        return results
    with open(csv_path) as f:
        for row in csv.DictReader(f):
            name = row["circuit"]
            metrics = {}
            for key, val in row.items():
                if key in DISPLAY_METRICS and val:
                    try:
                        fv = float(val)
                        if fv != 0:
                            metrics[key] = fv
                    except ValueError:
                        pass
            results[name] = {
                "success": row.get("success", "False") == "True",
                "time_s": float(row.get("time_s", 0) or 0),
                "metrics": metrics,
                "analysis": row.get("analysis", ""),
            }
    return results


def load_data():
    with open(SPECS_JSON) as f:
        baker_specs = json.load(f)

    baker_results = load_results_csv(BAKER_RESULTS_CSV)
    rocktnet_results = load_results_csv(ROCKTNET_RESULTS_CSV)

    return baker_specs, baker_results, rocktnet_results


def extract_metrics(res):
    metric_results = {}
    for mkey in ["dc_gain_db", "ugbw", "ugbw_hz", "power_dc", "avg_power",
                  "power_uw", "power_avg", "rise_time", "fall_time", "vout_swing",
                  "iout_mid", "rout_mid", "vref", "psrr_100hz_db", "dropout_mv",
                  "vout_max", "vout_min", "vout_dc", "period", "gain_db"]:
        if mkey in res.get("metrics", {}):
            info = DISPLAY_METRICS[mkey]
            metric_results[mkey] = {
                "label": info["label"],
                "unit": info["unit"],
                "goal": info["goal"],
                "value": res["metrics"][mkey],
            }
    return metric_results


def count_transistors_in_spice(filepath):
    try:
        with open(filepath) as f:
            content = f.read()
        nfet = len(re.findall(r'sky130_fd_pr__nfet', content))
        pfet = len(re.findall(r'sky130_fd_pr__pfet', content))
        return nfet + pfet
    except:
        return 0


def count_components_in_spice(filepath):
    try:
        with open(filepath) as f:
            content = f.read()
        nfet = len(re.findall(r'sky130_fd_pr__nfet', content))
        pfet = len(re.findall(r'sky130_fd_pr__pfet', content))
        resistors = len(re.findall(r'(?m)^R\w+\s', content))
        capacitors = len(re.findall(r'(?m)^C\w+\s', content))
        inductors = len(re.findall(r'(?m)^L\w+\s', content))
        vsources = len(re.findall(r'(?m)^V\w+\s', content))
        isources = len(re.findall(r'(?m)^I\w+\s', content))
        return {"nfet": nfet, "pfet": pfet, "R": resistors, "C": capacitors,
                "L": inductors, "V": vsources, "I": isources}
    except:
        return {}


def detect_analyses(filepath):
    try:
        with open(filepath) as f:
            content = f.read()
        analyses = []
        if re.search(r'^\s*ac\s', content, re.MULTILINE):
            analyses.append("AC")
        if re.search(r'^\s*tran\s', content, re.MULTILINE):
            analyses.append("Tran")
        if re.search(r'^\s*dc\s', content, re.MULTILINE):
            analyses.append("DC")
        if re.search(r'^\s*op\s*$', content, re.MULTILINE):
            analyses.append("OP")
        return analyses
    except:
        return []


def build_all_circuits(baker_specs, baker_results, rocktnet_results):
    circuits = []
    idx = 0

    # Baker circuits
    for name in sorted(baker_specs.keys()):
        idx += 1
        spec = baker_specs[name]
        spice_path = os.path.join(BAKER_DIR, name + ".spice")
        res = baker_results.get(name, {})
        params, header_metrics, circuit_class = [], [], ""
        spice_content = ""

        components = {}
        if os.path.exists(spice_path):
            params, header_metrics, circuit_class = parse_spice_header(spice_path)
            spice_content = read_spice_content(spice_path)
            components = count_components_in_spice(spice_path)

        circuits.append({
            "idx": idx,
            "name": name,
            "source": "Baker",
            "type": spec["circuit_type"],
            "chapter": spec.get("chapter") or "Custom",
            "topic": spec.get("chapter_topic", "Custom"),
            "analyses": spec["analyses"],
            "transistors": spec["total_transistors"],
            "success": res.get("success", False),
            "time_s": res.get("time_s", 0),
            "params": params,
            "header_metrics": header_metrics,
            "metric_results": extract_metrics(res),
            "optimize": spec["spec_template"]["optimize"],
            "tradeoffs": spec["spec_template"]["tradeoffs"],
            "description": spec["spec_template"]["description"],
            "components": components,
            "spice": spice_content,
        })

    # RoCktNet circuits
    for name in sorted(rocktnet_results.keys()):
        idx += 1
        res = rocktnet_results[name]
        spice_path = os.path.join(ROCKTNET_DIR, name + ".spice")
        params, header_metrics, circuit_class = [], [], ""
        spice_content = ""
        transistors = 0
        analyses = []

        components = {}
        if os.path.exists(spice_path):
            params, header_metrics, circuit_class = parse_spice_header(spice_path)
            spice_content = read_spice_content(spice_path)
            transistors = count_transistors_in_spice(spice_path)
            analyses = detect_analyses(spice_path)
            components = count_components_in_spice(spice_path)

        # Classify RoCktNet by metrics available
        metric_results = extract_metrics(res)
        has_gain = "dc_gain_db" in metric_results
        has_power = "power_dc" in metric_results or "avg_power" in metric_results
        rtype = "unknown"
        if has_gain and has_power:
            rtype = "amplifier"
        elif has_gain:
            rtype = "amplifier"
        elif has_power:
            rtype = "active_circuit"
        else:
            rtype = "unknown"

        analysis_str = res.get("analysis", "")
        if not analyses and analysis_str:
            analyses = [analysis_str]

        circuits.append({
            "idx": idx,
            "name": name,
            "source": "RoCktNet",
            "type": rtype,
            "chapter": "RoCktNet",
            "topic": "IEEE Paper Circuit",
            "analyses": analyses,
            "transistors": transistors,
            "success": res.get("success", False),
            "time_s": res.get("time_s", 0),
            "params": params,
            "header_metrics": header_metrics,
            "metric_results": metric_results,
            "optimize": ["dc_gain_db", "power_w"] if has_gain else ["power_w"],
            "tradeoffs": "gain vs power" if has_gain else "power optimization",
            "description": f"IEEE paper circuit ({name})",
            "components": components,
            "spice": spice_content,
        })

    # Needs-fix circuits (from needs_fix/rocktnet/)
    if os.path.isdir(NEEDS_FIX_DIR):
        import glob
        needs_fix_files = sorted(glob.glob(os.path.join(NEEDS_FIX_DIR, "*.spice")))
        for spice_path in needs_fix_files:
            name = os.path.splitext(os.path.basename(spice_path))[0]
            idx += 1
            params, header_metrics, circuit_class = parse_spice_header(spice_path)
            spice_content = read_spice_content(spice_path)
            transistors = count_transistors_in_spice(spice_path)
            analyses = detect_analyses(spice_path)
            components = count_components_in_spice(spice_path)

            circuits.append({
                "idx": idx,
                "name": name,
                "source": "Needs Fix",
                "type": "needs_fix",
                "chapter": "RoCktNet",
                "topic": "IEEE Paper Circuit (needs fix)",
                "analyses": analyses,
                "transistors": transistors,
                "success": False,
                "time_s": 0,
                "params": params,
                "header_metrics": header_metrics,
                "metric_results": {},
                "components": components,
                "optimize": [],
                "tradeoffs": "Circuit needs testbench fixes to simulate",
                "description": f"Needs fix: {name}",
                "spice": spice_content,
            })

    return circuits


def type_stats_from_circuits(circuits):
    stats = {}
    for c in circuits:
        t = c["type"]
        if t not in stats:
            stats[t] = {"count": 0, "passed": 0, "desc": c["description"],
                        "optimize": c["optimize"], "tradeoffs": c["tradeoffs"]}
        stats[t]["count"] += 1
        if c["success"]:
            stats[t]["passed"] += 1
    return dict(sorted(stats.items(), key=lambda x: -x[1]["count"]))


def generate_html(circuits):
    tstats = type_stats_from_circuits(circuits)
    total = len(circuits)
    passed = sum(1 for c in circuits if c["success"])
    baker_count = sum(1 for c in circuits if c["source"] == "Baker")
    rocktnet_count = sum(1 for c in circuits if c["source"] == "RoCktNet")
    needsfix_count = sum(1 for c in circuits if c["source"] == "Needs Fix")

    # Build table rows + detail panels
    table_html = []
    for c in circuits:
        status = "PASS" if c["success"] else "FAIL"
        status_class = "pass" if c["success"] else "fail"
        analyses_str = ", ".join(c["analyses"])

        # Summary metrics for table row
        summary_metrics = []
        for mkey, minfo in list(c["metric_results"].items())[:3]:
            summary_metrics.append(f"<span class='metric-tag'>{minfo['label']}: {fmt_value(minfo['value'])} {minfo['unit']}</span>")
        summary_str = " ".join(summary_metrics) if summary_metrics else "<span class='muted'>--</span>"

        # Detail: Parameters
        params_html = ""
        if c["params"]:
            param_rows = ""
            for p in c["params"]:
                dv = fmt_value(p["default"]) if p["default"] is not None else "--"
                param_rows += f"<tr><td class='param-name'>{htmlmod.escape(p['name'])}</td><td>{dv}</td></tr>"
            params_html = f"""<div class="detail-section">
  <h4>Tunable Parameters ({len(c['params'])})</h4>
  <table class="param-table"><tr><th>Parameter</th><th>Default Value</th></tr>{param_rows}</table>
</div>"""
        else:
            params_html = '<div class="detail-section"><h4>Tunable Parameters</h4><p class="muted">No structured parameters found in header</p></div>'

        # Detail: Component inventory (for needs_fix or any circuit)
        components = c.get("components", {})
        if components and any(v > 0 for v in components.values()):
            comp_rows = ""
            comp_labels = {"nfet": "NMOS (nfet)", "pfet": "PMOS (pfet)", "R": "Resistors",
                           "C": "Capacitors", "L": "Inductors", "V": "Voltage Sources", "I": "Current Sources"}
            for k, label in comp_labels.items():
                count = components.get(k, 0)
                if count > 0:
                    comp_rows += f"<tr><td>{label}</td><td class='metric-val'>{count}</td></tr>"
            params_html += f"""<div class="detail-section">
  <h4>Components</h4>
  <table class="param-table"><tr><th>Type</th><th>Count</th></tr>{comp_rows}</table>
</div>"""

        # Detail: Output Metrics
        metrics_html = ""
        if c["metric_results"]:
            metric_rows = ""
            for mkey, minfo in c["metric_results"].items():
                goal_cls = minfo["goal"]
                goal_label = {"maximize": "Maximize", "minimize": "Minimize", "match": "Match target", "info": "Info"}.get(goal_cls, "")
                goal_icon = {"maximize": "&#9650;", "minimize": "&#9660;", "match": "&#9644;", "info": "&#8505;"}.get(goal_cls, "")
                metric_rows += f"""<tr>
  <td><b>{minfo['label']}</b></td>
  <td class="metric-val">{fmt_value(minfo['value'])} {minfo['unit']}</td>
  <td class="goal goal-{goal_cls}">{goal_icon} {goal_label}</td>
</tr>"""
            metrics_html = f"""<div class="detail-section">
  <h4>Output Metrics (Baseline)</h4>
  <table class="metric-table"><tr><th>Metric</th><th>Baseline Value</th><th>Optimization Goal</th></tr>{metric_rows}</table>
</div>"""
        else:
            metrics_html = '<div class="detail-section"><h4>Output Metrics</h4><p class="muted">Not yet simulated</p></div>'

        # Detail: Tradeoff
        tradeoff_html = f"""<div class="detail-section">
  <h4>Design Tradeoff</h4>
  <p>{htmlmod.escape(c['tradeoffs'])}</p>
</div>"""

        # Detail: SPICE netlist
        spice_escaped = htmlmod.escape(c["spice"])
        spice_html = f"""<div class="detail-section">
  <h4>SPICE Testbench <button class="copy-btn" onclick="copySpice(this)">Copy</button></h4>
  <pre class="spice-code"><code>{spice_escaped}</code></pre>
</div>"""

        source = c["source"]
        source_cls = {"Baker": "source-baker", "RoCktNet": "source-rocktnet", "Needs Fix": "source-needsfix"}.get(source, "source-rocktnet")

        # Combine
        table_html.append(f"""<tr class="circuit-row {status_class}" data-type="{c['type']}" data-chapter="{c['chapter']}" data-source="{source}" onclick="toggleDetail('detail-{c['idx']}')">
  <td class="idx">{c['idx']}</td>
  <td class="name">{htmlmod.escape(c['name'])}</td>
  <td><span class="badge {source_cls}">{source}</span></td>
  <td><span class="badge badge-{c['type']}">{c['type']}</span></td>
  <td class="topic">{c['topic']}</td>
  <td>{analyses_str}</td>
  <td class="center">{c['transistors']}</td>
  <td class="status {status_class}">{status}</td>
  <td class="metrics-summary">{summary_str}</td>
</tr>
<tr class="detail-row" id="detail-{c['idx']}" style="display:none" data-source="{source}">
  <td colspan="9">
    <div class="detail-panel">
      <div class="detail-header">
        <h3>Task #{c['idx']}: {htmlmod.escape(c['name'])}</h3>
        <div class="detail-tags">
          <span class="badge badge-{c['type']}">{c['type']}</span>
          <span class="tag">{c['description']}</span>
          <span class="tag">{c['transistors']} transistors</span>
          <span class="tag">Analysis: {analyses_str}</span>
          <span class="tag">Sim time: {c['time_s']:.1f}s</span>
        </div>
      </div>
      <div class="detail-grid">
        {params_html}
        {metrics_html}
        {tradeoff_html}
      </div>
      {spice_html}
    </div>
  </td>
</tr>""")

    # Type cards
    type_cards = []
    for tname, tinfo in tstats.items():
        opt_list = "".join(f"<li>{m}</li>" for m in tinfo["optimize"])
        type_cards.append(f"""<div class="type-card">
  <h3>{tname} <span class="count">({tinfo['count']} circuits, {tinfo['passed']} pass)</span></h3>
  <p class="desc">{htmlmod.escape(tinfo['desc'])}</p>
  <div class="opt-label">Optimize:</div>
  <ul class="opt-list">{opt_list}</ul>
  <div class="tradeoff"><b>Tradeoff:</b> {htmlmod.escape(tinfo['tradeoffs'])}</div>
</div>""")

    all_types = sorted(set(c["type"] for c in circuits))
    type_options = "".join(f'<option value="{t}">{t} ({sum(1 for c in circuits if c["type"]==t)})</option>' for t in all_types)
    all_sources = sorted(set(c["source"] for c in circuits))
    source_options = "".join(f'<option value="{s}">{s} ({sum(1 for c in circuits if c["source"]==s)})</option>' for s in all_sources)

    page_html = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>sky130-circuit-bench</title>
<style>
:root {{
  --bg: #0d1117; --card: #161b22; --border: #30363d;
  --text: #e6edf3; --muted: #8b949e; --accent: #58a6ff;
  --green: #3fb950; --red: #f85149; --yellow: #d29922;
  --purple: #bc8cff;
  --font: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;
  --mono: 'SFMono-Regular', Consolas, 'Liberation Mono', Menlo, monospace;
}}
* {{ box-sizing: border-box; margin: 0; padding: 0; }}
body {{ font-family: var(--font); background: var(--bg); color: var(--text); line-height: 1.6; }}
a {{ color: var(--accent); text-decoration: none; }}
.container {{ max-width: 1400px; margin: 0 auto; padding: 0 24px; }}
.muted {{ color: var(--muted); }}

/* Hero */
.hero {{ padding: 60px 0 40px; text-align: center; border-bottom: 1px solid var(--border); }}
.hero h1 {{ font-size: 2.2em; margin-bottom: 8px; }}
.hero h1 span {{ color: var(--accent); }}
.hero .subtitle {{ color: var(--muted); font-size: 1.15em; margin-bottom: 24px; }}
.stats {{ display: flex; gap: 32px; justify-content: center; flex-wrap: wrap; }}
.stat {{ text-align: center; }}
.stat .num {{ font-size: 2em; font-weight: 700; color: var(--accent); display: block; }}
.stat .label {{ color: var(--muted); font-size: 0.85em; }}

/* Quick Start */
.quickstart {{ padding: 32px 0; border-bottom: 1px solid var(--border); }}
.quickstart h2 {{ margin-bottom: 12px; font-size: 1.3em; }}
pre {{ background: var(--card); border: 1px solid var(--border); border-radius: 8px;
       padding: 16px; overflow-x: auto; font-size: 0.88em; color: var(--green); font-family: var(--mono); }}

section {{ padding: 32px 0; border-bottom: 1px solid var(--border); }}
section h2 {{ font-size: 1.5em; margin-bottom: 16px; }}

/* Filters */
.filters {{ display: flex; gap: 12px; margin-bottom: 16px; flex-wrap: wrap; align-items: center; }}
.filters input, .filters select {{
  background: var(--card); border: 1px solid var(--border); border-radius: 6px;
  padding: 8px 12px; color: var(--text); font-size: 0.9em; }}
.filters input {{ flex: 1; min-width: 200px; }}
.filters select {{ min-width: 150px; }}
.filter-count {{ color: var(--muted); font-size: 0.85em; }}

/* Table */
.table-wrap {{ overflow-x: auto; }}
table.main {{ width: 100%; border-collapse: collapse; font-size: 0.85em; }}
table.main th {{ background: var(--card); position: sticky; top: 0; z-index: 2; cursor: pointer;
  padding: 10px 8px; text-align: left; border-bottom: 2px solid var(--border);
  color: var(--muted); font-weight: 600; white-space: nowrap; }}
table.main th:hover {{ color: var(--text); }}
table.main td {{ padding: 8px; border-bottom: 1px solid var(--border); vertical-align: top; }}
.circuit-row {{ cursor: pointer; transition: background 0.15s; }}
.circuit-row:hover {{ background: rgba(88,166,255,0.06); }}
.circuit-row.fail {{ opacity: 0.6; }}
.idx {{ color: var(--muted); width: 40px; }}
.name {{ font-family: var(--mono); font-size: 0.92em; white-space: nowrap; }}
.center {{ text-align: center; }}
.status.pass {{ color: var(--green); font-weight: 700; }}
.status.fail {{ color: var(--red); font-weight: 700; }}

/* Badges */
.badge {{ display: inline-block; padding: 2px 8px; border-radius: 12px; font-size: 0.8em;
         background: var(--border); white-space: nowrap; }}
.badge-op_amp, .badge-op_amp_ii {{ background: #1f3d1f; color: var(--green); }}
.badge-ota {{ background: #1a3a2a; color: #56d364; }}
.badge-amplifier, .badge-diff_amp, .badge-feedback_amp {{ background: #1f2d3d; color: var(--accent); }}
.badge-current_mirror {{ background: #2d2a1f; color: var(--yellow); }}
.badge-voltage_reference, .badge-ldo {{ background: #2d1f2d; color: var(--purple); }}
.badge-inverter, .badge-logic_gate, .badge-clocked_circuit, .badge-memory, .badge-digital_model, .badge-dynamic_logic {{
  background: #1f2d2d; color: #79c0ff; }}
.badge-comparator, .badge-oscillator, .badge-pll {{ background: #2d1f1f; color: #ffa198; }}
.badge-filter {{ background: #1f3d3d; color: #7ee787; }}
.badge-unknown, .badge-active_circuit {{ background: #2d2d2d; color: var(--muted); }}
.source-baker {{ background: #1f2d3d; color: var(--accent); font-weight: 600; }}
.source-rocktnet {{ background: #2d1f2d; color: var(--purple); font-weight: 600; }}
.source-needsfix {{ background: #3d1f1f; color: var(--red); font-weight: 600; }}
.badge-needs_fix {{ background: #3d1f1f; color: var(--red); }}

/* Summary metrics in table */
.metrics-summary {{ font-size: 0.88em; }}
.metric-tag {{ display: inline-block; background: var(--card); border: 1px solid var(--border);
  border-radius: 4px; padding: 1px 6px; margin: 1px 2px; font-size: 0.9em; white-space: nowrap; }}

/* Detail panel */
.detail-row td {{ padding: 0 !important; border-bottom: 2px solid var(--accent) !important; }}
.detail-panel {{ background: var(--card); border: 1px solid var(--border); border-radius: 0 0 8px 8px;
  padding: 24px; margin: 0; }}
.detail-header {{ margin-bottom: 20px; }}
.detail-header h3 {{ font-size: 1.2em; margin-bottom: 8px; }}
.detail-tags {{ display: flex; gap: 8px; flex-wrap: wrap; }}
.tag {{ display: inline-block; background: var(--bg); border: 1px solid var(--border);
  border-radius: 4px; padding: 2px 8px; font-size: 0.82em; color: var(--muted); }}

.detail-grid {{ display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 20px; margin-bottom: 20px; }}
@media (max-width: 900px) {{ .detail-grid {{ grid-template-columns: 1fr; }} }}

.detail-section h4 {{ font-size: 0.95em; color: var(--accent); margin-bottom: 8px;
  border-bottom: 1px solid var(--border); padding-bottom: 4px; }}

/* Param table */
.param-table, .metric-table {{ width: 100%; border-collapse: collapse; font-size: 0.88em; }}
.param-table th, .metric-table th {{ text-align: left; color: var(--muted); font-weight: 600;
  padding: 4px 8px; border-bottom: 1px solid var(--border); font-size: 0.85em; }}
.param-table td, .metric-table td {{ padding: 4px 8px; border-bottom: 1px solid rgba(48,54,61,0.5); }}
.param-name {{ font-family: var(--mono); color: var(--yellow); }}
.metric-val {{ font-family: var(--mono); font-weight: 600; }}

/* Goal indicators */
.goal {{ font-size: 0.85em; }}
.goal-maximize {{ color: var(--green); }}
.goal-minimize {{ color: var(--accent); }}
.goal-match {{ color: var(--yellow); }}
.goal-info {{ color: var(--muted); }}

/* SPICE code */
.spice-code {{ max-height: 400px; overflow-y: auto; font-size: 0.82em; line-height: 1.5;
  background: var(--bg); border: 1px solid var(--border); white-space: pre-wrap; word-break: break-all; }}
.copy-btn {{ float: right; background: var(--border); color: var(--text); border: none;
  border-radius: 4px; padding: 2px 10px; cursor: pointer; font-size: 0.85em; }}
.copy-btn:hover {{ background: var(--accent); color: var(--bg); }}

/* Type cards */
.type-grid {{ display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 16px; }}
.type-card {{ background: var(--card); border: 1px solid var(--border); border-radius: 8px; padding: 16px; }}
.type-card h3 {{ font-size: 1.05em; margin-bottom: 4px; }}
.type-card .count {{ color: var(--muted); font-weight: 400; font-size: 0.85em; }}
.type-card .desc {{ color: var(--muted); font-size: 0.9em; margin-bottom: 8px; }}
.opt-label {{ font-size: 0.85em; color: var(--accent); font-weight: 600; }}
.opt-list {{ margin: 4px 0 8px 20px; font-size: 0.85em; }}
.opt-list li {{ color: var(--green); }}
.tradeoff {{ font-size: 0.85em; color: var(--muted); }}

footer {{ padding: 32px 0; text-align: center; color: var(--muted); font-size: 0.85em; }}
</style>
</head>
<body>

<div class="container">

<div class="hero">
  <h1><span>sky130-circuit-bench</span></h1>
  <p class="subtitle">A benchmark of simulatable CMOS circuits on the SkyWater SKY130 open-source PDK</p>
  <div class="stats">
    <div class="stat"><span class="num">{total:,}</span><span class="label">Total Circuits</span></div>
    <div class="stat"><span class="num">{baker_count}</span><span class="label">Baker Textbook</span></div>
    <div class="stat"><span class="num">{rocktnet_count}</span><span class="label">RoCktNet IEEE</span></div>
    <div class="stat"><span class="num">{needsfix_count}</span><span class="label">Needs Fix</span></div>
    <div class="stat"><span class="num">{passed:,}</span><span class="label">Passing</span></div>
    <div class="stat"><span class="num">130nm</span><span class="label">SKY130 PDK</span></div>
  </div>
</div>

<div class="quickstart">
  <h2>Quick Start</h2>
  <pre><code>git clone https://github.com/yuxi120407/sky130-circuit-bench.git
cd sky130-circuit-bench
python run_simulation.py --spice-dir ready_circuits/baker_textbook --run five_trans_ota -v
python run_simulation.py --spice-dir ready_circuits/baker_textbook --run-all --timeout 120</code></pre>
</div>

<section>
  <h2>All Circuits ({total:,} circuits, {passed:,} passing)</h2>
  <p class="muted" style="margin-bottom: 12px;">Click any row to expand task details: tunable parameters, output metrics, design tradeoffs, and the full SPICE testbench.</p>
  <div class="filters">
    <input type="text" id="search" placeholder="Search circuit name...">
    <select id="sourceFilter">
      <option value="">All sources</option>
      {source_options}
    </select>
    <select id="typeFilter">
      <option value="">All types</option>
      {type_options}
    </select>
    <select id="statusFilter">
      <option value="">All status</option>
      <option value="pass">Passing only</option>
      <option value="fail">Failing only</option>
    </select>
    <span class="filter-count" id="filterCount">{total:,} circuits</span>
  </div>
  <div class="table-wrap">
    <table class="main" id="circuitTable">
      <thead>
        <tr>
          <th>#</th>
          <th>Circuit Name</th>
          <th>Source</th>
          <th>Type</th>
          <th>Chapter/Topic</th>
          <th>Analysis</th>
          <th>FETs</th>
          <th>Status</th>
          <th>Key Metrics</th>
        </tr>
      </thead>
      <tbody>
        {"".join(table_html)}
      </tbody>
    </table>
  </div>
</section>

<section>
  <h2>Spec Templates by Circuit Type</h2>
  <p class="muted" style="margin-bottom: 16px;">
    Each circuit type has optimization metrics derived from Baker's textbook treatment of the circuit class.
  </p>
  <div class="type-grid">
    {"".join(type_cards)}
  </div>
</section>

<section>
  <h2>Sources</h2>
  <table class="main" style="max-width: 700px;">
    <tr><th>Source</th><th>Circuits</th><th>Description</th></tr>
    <tr><td>Baker Textbook</td><td>{baker_count}</td><td>From <i>CMOS: Circuit Design, Layout, and Simulation</i> (4th Ed.), adapted to SKY130</td></tr>
    <tr><td>RoCktNet</td><td>{rocktnet_count}</td><td>IEEE paper schematics via <a href="https://github.com/xz-group/RoCktNet/tree/master">RoCktNet</a>, converted to SKY130</td></tr>
    <tr><td>Needs Fix</td><td>{needsfix_count}</td><td>RoCktNet circuits that need testbench fixes to simulate correctly</td></tr>
  </table>
</section>

</div>

<footer>
  <div class="container">
    <p>sky130-circuit-bench &middot; SKY130 PDK (Apache 2.0) &middot; Built for AMS circuit design research</p>
  </div>
</footer>

<script>
function toggleDetail(id) {{
  const row = document.getElementById(id);
  if (!row) return;
  const isOpen = row.style.display !== 'none';
  document.querySelectorAll('.detail-row').forEach(r => r.style.display = 'none');
  if (!isOpen) row.style.display = '';
}}

function copySpice(btn) {{
  const code = btn.parentElement.nextElementSibling.textContent;
  navigator.clipboard.writeText(code).then(() => {{
    btn.textContent = 'Copied!';
    setTimeout(() => btn.textContent = 'Copy', 1500);
  }});
}}

const table = document.getElementById('circuitTable');
const tbody = table.querySelector('tbody');
const circuitRows = Array.from(tbody.querySelectorAll('.circuit-row'));
const detailRows = Array.from(tbody.querySelectorAll('.detail-row'));
const search = document.getElementById('search');
const sourceFilter = document.getElementById('sourceFilter');
const typeFilter = document.getElementById('typeFilter');
const statusFilter = document.getElementById('statusFilter');
const filterCount = document.getElementById('filterCount');

function applyFilters() {{
  const q = search.value.toLowerCase();
  const src = sourceFilter.value;
  const t = typeFilter.value;
  const s = statusFilter.value;
  let visible = 0;

  detailRows.forEach(r => r.style.display = 'none');

  circuitRows.forEach(row => {{
    const name = row.querySelector('.name')?.textContent.toLowerCase() || '';
    const type = row.dataset.type || '';
    const source = row.dataset.source || '';
    const isPass = row.classList.contains('pass');
    const show = (!q || name.includes(q)) && (!src || source === src) && (!t || type === t) && (!s || (s === 'pass' && isPass) || (s === 'fail' && !isPass));
    row.style.display = show ? '' : 'none';
    if (show) visible++;
  }});
  filterCount.textContent = visible + ' circuits';
}}

search.addEventListener('input', applyFilters);
sourceFilter.addEventListener('change', applyFilters);
typeFilter.addEventListener('change', applyFilters);
statusFilter.addEventListener('change', applyFilters);

const headers = table.querySelectorAll('th');
headers.forEach((th, idx) => {{
  th.addEventListener('click', (e) => {{
    if (e.target !== th) return;
    const asc = th.dataset.sort !== 'asc';
    headers.forEach(h => h.dataset.sort = '');
    th.dataset.sort = asc ? 'asc' : 'desc';

    const pairs = circuitRows.map(cr => {{
      const detailId = cr.getAttribute('onclick')?.match(/'([^']+)'/)?.[1];
      const dr = detailId ? document.getElementById(detailId) : null;
      return [cr, dr];
    }});

    pairs.sort((a, b) => {{
      let va = a[0].children[idx]?.textContent.trim() || '';
      let vb = b[0].children[idx]?.textContent.trim() || '';
      const na = parseFloat(va), nb = parseFloat(vb);
      if (!isNaN(na) && !isNaN(nb)) return asc ? na - nb : nb - na;
      return asc ? va.localeCompare(vb) : vb.localeCompare(va);
    }});

    pairs.forEach(([cr, dr]) => {{
      tbody.appendChild(cr);
      if (dr) tbody.appendChild(dr);
    }});
  }});
}});
</script>

</body>
</html>"""
    return page_html


def main():
    baker_specs, baker_results, rocktnet_results = load_data()
    circuits = build_all_circuits(baker_specs, baker_results, rocktnet_results)
    html_content = generate_html(circuits)

    os.makedirs(DOCS_DIR, exist_ok=True)
    output = os.path.join(DOCS_DIR, "index.html")
    with open(output, "w") as f:
        f.write(html_content)

    baker_n = sum(1 for c in circuits if c["source"] == "Baker")
    rocktnet_n = sum(1 for c in circuits if c["source"] == "RoCktNet")
    passed = sum(1 for c in circuits if c["success"])
    fsize = os.path.getsize(output)
    print(f"Built {output} ({fsize/1024:.0f} KB)")
    print(f"  Baker: {baker_n}, RoCktNet: {rocktnet_n}, Total: {len(circuits)}")
    print(f"  Passing: {passed}")
    print(f"  Each row expands to show: parameters, metrics, tradeoffs, SPICE netlist")


if __name__ == "__main__":
    main()
