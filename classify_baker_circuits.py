#!/usr/bin/env python3
"""
Classify Baker textbook circuits and assign spec templates.

For each of the 246 Baker circuits, this script:
1. Identifies the circuit type (op-amp, OTA, current mirror, etc.)
2. Determines what analysis it currently runs (AC, Tran, DC, OP)
3. Assigns a spec template: the metrics that SHOULD be measured for optimization
4. Based on Baker Ch20-32 + the textbook's treatment of each circuit type

Output: baker_circuit_specs.json — structured per-circuit classification
"""

import os
import re
import json
import glob

BAKER_DIR = os.path.join(os.path.dirname(__file__),
                         "ready_circuits", "baker_textbook")

# ── Circuit type classification based on chapter + figure content ──

CHAPTER_INFO = {
    9:  {"topic": "Models for Analog Design",       "default_type": "mosfet_model"},
    10: {"topic": "Models for Digital Design",       "default_type": "digital_model"},
    11: {"topic": "The Inverter",                    "default_type": "inverter"},
    12: {"topic": "Static Logic Gates",              "default_type": "logic_gate"},
    13: {"topic": "Clocked Circuits",                "default_type": "clocked_circuit"},
    14: {"topic": "Dynamic Logic Gates",             "default_type": "dynamic_logic"},
    16: {"topic": "Memory Circuits",                 "default_type": "memory"},
    17: {"topic": "Sensing (Delta-Sigma)",           "default_type": "delta_sigma"},
    18: {"topic": "Special Purpose Circuits",        "default_type": "special_purpose"},
    19: {"topic": "Digital PLLs",                    "default_type": "pll"},
    20: {"topic": "Current Mirrors",                 "default_type": "current_mirror"},
    21: {"topic": "Amplifiers",                      "default_type": "amplifier"},
    22: {"topic": "Differential Amplifiers",         "default_type": "diff_amp"},
    23: {"topic": "Voltage References",              "default_type": "voltage_reference"},
    24: {"topic": "Operational Amplifiers I",         "default_type": "op_amp"},
    25: {"topic": "Dynamic Analog Circuits",         "default_type": "dynamic_analog"},
    26: {"topic": "Operational Amplifiers II",        "default_type": "op_amp_ii"},
    27: {"topic": "Nonlinear Analog Circuits",       "default_type": "comparator"},
    31: {"topic": "Feedback Amplifiers",             "default_type": "feedback_amp"},
    32: {"topic": "Hysteretic Power Converters",     "default_type": "power_converter"},
}

# Spec templates: what metrics to measure for each circuit type
# Based on Baker textbook Ch20-32 discussion of each circuit class
# "optimize" = metrics that involve real design tradeoffs
# "measure"  = metrics to report but not optimize against

SPEC_TEMPLATES = {
    "op_amp": {
        "description": "Two-stage or multi-stage operational amplifier",
        "textbook_specs": "A_OLDC (gain), f_un (UGBW), phase margin, power, output swing, CMRR, PSRR, slew rate",
        "optimize": ["dc_gain_db", "ugbw_hz", "power_w"],
        "measure": ["phase_margin_deg", "output_swing_v", "slew_rate_vus"],
        "tradeoffs": "gain vs bandwidth vs power (fundamental GBW product tradeoff)",
    },
    "op_amp_ii": {
        "description": "Fully-differential or switched-capacitor op-amp (Ch26)",
        "textbook_specs": "A_OLDC, f_un, PM, CMFB settling, offset, power",
        "optimize": ["dc_gain_db", "ugbw_hz", "power_w"],
        "measure": ["phase_margin_deg", "settling_time_ns", "output_swing_v"],
        "tradeoffs": "gain vs speed vs power; CMFB adds complexity",
    },
    "ota": {
        "description": "Operational Transconductance Amplifier",
        "textbook_specs": "Gm, A_OLDC, f_un, power, output resistance",
        "optimize": ["dc_gain_db", "ugbw_hz", "power_w"],
        "measure": ["phase_margin_deg", "output_swing_v"],
        "tradeoffs": "gain vs bandwidth vs power; OTA drives capacitive loads only",
    },
    "amplifier": {
        "description": "Single-stage amplifier (CS, CG, SF, cascode)",
        "textbook_specs": "voltage gain, bandwidth, power, noise figure",
        "optimize": ["dc_gain_db", "ugbw_hz", "power_w"],
        "measure": ["output_swing_v", "bandwidth_hz"],
        "tradeoffs": "gain vs bandwidth (pole splitting); power vs speed",
    },
    "diff_amp": {
        "description": "Differential amplifier pair",
        "textbook_specs": "differential gain, CMRR, input range, bandwidth, power",
        "optimize": ["dc_gain_db", "ugbw_hz", "power_w"],
        "measure": ["output_swing_v"],
        "tradeoffs": "gain vs CMRR vs input range vs power",
    },
    "feedback_amp": {
        "description": "Feedback amplifier configuration",
        "textbook_specs": "closed-loop gain, bandwidth, gain margin, phase margin",
        "optimize": ["dc_gain_db", "ugbw_hz", "power_w"],
        "measure": ["phase_margin_deg"],
        "tradeoffs": "gain-bandwidth product; stability vs speed",
    },
    "current_mirror": {
        "description": "Current mirror (basic, cascode, wide-swing, regulated)",
        "textbook_specs": "output current accuracy, output resistance, compliance voltage, power",
        "optimize": ["iout_mid_a", "rout_mid_ohm", "power_w"],
        "measure": ["compliance_v"],
        "tradeoffs": "output resistance vs compliance voltage (headroom); accuracy vs area",
    },
    "voltage_reference": {
        "description": "Bandgap or MOSFET voltage reference",
        "textbook_specs": "V_REF accuracy, temp coefficient, PSRR, power",
        "optimize": ["vref_v", "power_w"],
        "measure": ["psrr_db", "temp_coefficient_ppmC"],
        "tradeoffs": "accuracy vs power; minimum VDD vs temperature stability",
    },
    "inverter": {
        "description": "CMOS inverter",
        "textbook_specs": "propagation delay, rise/fall time, power, noise margins",
        "optimize": ["avg_power_w", "rise_time_s", "fall_time_s"],
        "measure": ["vout_swing_v"],
        "tradeoffs": "speed (delay) vs power; sizing ratio affects noise margins",
    },
    "logic_gate": {
        "description": "Static CMOS logic gate (NAND, NOR, XOR, etc.)",
        "textbook_specs": "propagation delay, power, rise/fall time, noise margins",
        "optimize": ["avg_power_w", "rise_time_s", "fall_time_s"],
        "measure": ["vout_swing_v"],
        "tradeoffs": "speed vs power vs fan-in; PMOS/NMOS sizing ratio",
    },
    "clocked_circuit": {
        "description": "Latch, flip-flop, transmission gate circuit",
        "textbook_specs": "setup/hold time, clock-to-Q delay, power",
        "optimize": ["avg_power_w", "rise_time_s", "fall_time_s"],
        "measure": ["vout_swing_v"],
        "tradeoffs": "speed vs power; setup/hold window vs robustness",
    },
    "memory": {
        "description": "SRAM, DRAM, sense amplifier, decoder",
        "textbook_specs": "read/write time, power, sense margin",
        "optimize": ["avg_power_w", "rise_time_s", "fall_time_s"],
        "measure": ["vout_swing_v"],
        "tradeoffs": "access time vs power vs cell area",
    },
    "delta_sigma": {
        "description": "Delta-sigma modulator or sensing circuit",
        "textbook_specs": "SNR, resolution, power, settling behavior",
        "optimize": ["avg_power_w", "vout_swing_v"],
        "measure": ["rise_time_s", "fall_time_s"],
        "tradeoffs": "resolution vs speed vs power",
    },
    "special_purpose": {
        "description": "Schmitt trigger, multivibrator, charge pump, buffer",
        "textbook_specs": "varies by sub-type: hysteresis, frequency, output voltage",
        "optimize": ["avg_power_w", "vout_swing_v"],
        "measure": ["rise_time_s", "fall_time_s"],
        "tradeoffs": "depends on sub-type",
    },
    "pll": {
        "description": "Phase-locked loop or delay-locked loop",
        "textbook_specs": "lock range, jitter, VCO gain, power",
        "optimize": ["avg_power_w"],
        "measure": ["vout_swing_v", "period_s"],
        "tradeoffs": "jitter vs power vs lock range",
    },
    "comparator": {
        "description": "CMOS comparator or nonlinear circuit",
        "textbook_specs": "propagation delay, input offset, power, resolution",
        "optimize": ["avg_power_w"],
        "measure": ["vout_swing_v", "rise_time_s", "fall_time_s"],
        "tradeoffs": "speed (delay) vs power vs offset",
    },
    "dynamic_analog": {
        "description": "Sample-and-hold, switched-capacitor circuit",
        "textbook_specs": "settling time, charge injection, clock feedthrough, SNR",
        "optimize": ["avg_power_w", "vout_swing_v"],
        "measure": ["rise_time_s", "fall_time_s"],
        "tradeoffs": "speed vs accuracy (charge injection) vs power",
    },
    "power_converter": {
        "description": "Hysteretic buck/boost converter",
        "textbook_specs": "efficiency, output ripple, load regulation, power",
        "optimize": ["avg_power_w", "vout_swing_v"],
        "measure": ["rise_time_s"],
        "tradeoffs": "efficiency vs ripple vs transient response",
    },
    "mosfet_model": {
        "description": "MOSFET characterization / model verification",
        "textbook_specs": "IV curves, gm, gds, Vth",
        "optimize": ["dc_gain_db", "power_w"],
        "measure": ["vout_dc_v"],
        "tradeoffs": "characterization circuit, not optimized per se",
    },
    "digital_model": {
        "description": "Digital MOSFET model verification",
        "textbook_specs": "switching behavior, delay, power",
        "optimize": ["avg_power_w", "rise_time_s", "fall_time_s"],
        "measure": ["vout_swing_v"],
        "tradeoffs": "characterization circuit",
    },
    "oscillator": {
        "description": "Ring oscillator or VCO",
        "textbook_specs": "frequency, phase noise, power, tuning range",
        "optimize": ["avg_power_w", "period_s"],
        "measure": ["vout_swing_v"],
        "tradeoffs": "frequency vs power vs phase noise",
    },
    "ldo": {
        "description": "Low-dropout voltage regulator",
        "textbook_specs": "dropout voltage, load regulation, line regulation, PSRR, power",
        "optimize": ["vref_v", "power_w", "dropout_mv"],
        "measure": ["psrr_db"],
        "tradeoffs": "dropout vs quiescent current vs transient response",
    },
    "filter": {
        "description": "Active filter (LP, HP, BP)",
        "textbook_specs": "passband gain, cutoff frequency, stopband rejection, power",
        "optimize": ["dc_gain_db", "ugbw_hz", "power_w"],
        "measure": ["bandwidth_hz"],
        "tradeoffs": "selectivity vs power vs noise",
    },
}

# ── Custom circuit name → type overrides ──

CUSTOM_OVERRIDES = {
    "five_trans_ota": "ota",
    "folded_cascode_ota": "ota",
    "folded_cascode_ota_lp": "filter",
    "folded_cascode_ota_hp": "filter",
    "folded_cascode_ota_bandp": "filter",
    "telescopic_ota": "ota",
    "current_mirror_ota": "ota",
    "azc": "ota",           # Ahuja-compensated OTA
    "iac": "ota",           # Indirect-compensated amplifier
    "smc": "ota",           # Simple Miller Compensation
    "nmcnr": "ota",         # Nested Miller Compensation No Resistor
    "dfcfc": "ota",         # Damping Factor Control Frequency Compensation
    "fdgb": "ota",          # FDGB compensation
    "resistive_load_amp": "amplifier",
    "diode_load_amp": "amplifier",
    "buffer": "inverter",
    "inverter": "inverter",
    "nand_gate": "logic_gate",
    "xor_gate": "logic_gate",
    "3_stage_ring_osc": "oscillator",
    "voltage_controlled_osc": "oscillator",
    "bandgap_reference": "voltage_reference",
    "ldo_regulator": "ldo",
    "switched_capacitor": "dynamic_analog",
    "_Extras_LTspice_Analog_3_stage_opamp_AC": "op_amp",
    "_Extras_LTspice_Analog_3_stage_opamp_tran": "op_amp",
    "_Extras_LTspice_Analog_3_stage_opamp_tran2": "op_amp",
    "_Extras_LTspice_Memory_DSM_sensing_Flash_simple": "delta_sigma",
    "_Extras_LTspice_Memory_DSM_sensing_Flash_wcount": "delta_sigma",
    "_Extras_LTspice_Memory_DSM_sensing_Flash_wcount_5bit": "delta_sigma",
}

# Chapter-level sub-classification overrides based on figure content
FIGURE_OVERRIDES = {
    # Ch18 sub-types
    "Chap18_LTspice_Fig18_5": "special_purpose",     # Schmitt trigger
    "Chap18_LTspice_Fig18_13": "special_purpose",    # Schmitt trigger app
    "Chap18_LTspice_Fig18_14": "special_purpose",    # Monostable multivibrator
    "Chap18_LTspice_Fig18_15": "special_purpose",    # Astable multivibrator
    "Chap18_LTspice_Fig18_18": "special_purpose",    # Input buffer DC ref
    "Chap18_LTspice_Fig18_19": "special_purpose",    # Differential buffer
    "Chap18_LTspice_Fig18_20": "special_purpose",    # Differential buffer transient
    "Chap18_LTspice_Fig18_22": "special_purpose",    # Buffer reducing Rin
    "Chap18_LTspice_Fig18_24": "special_purpose",    # Charge pump basic
    "Chap18_LTspice_Fig18_29a": "special_purpose",   # Charge pump
    "Chap18_LTspice_Fig18_29b": "special_purpose",   # Charge pump
    "Chap18_LTspice_Fig18_31": "special_purpose",    # Dickson charge pump
    "Chap18_LTspice_Fig18_34": "special_purpose",    # Clock driver
    "Chap18_LTspice_Fig18_38": "special_purpose",    # Charge pump example
    "Chap18_LTspice_Fig18_39": "special_purpose",    # Charge pump example
    "Chap18_LTspice_Fig18_40a": "special_purpose",   # Charge pump example
    "Chap18_LTspice_Fig18_40b": "special_purpose",   # Charge pump example

    # Ch20: some are biasing circuits, not just mirrors
    "Chap20_LTspice_Fig20_48": "voltage_reference",  # Beta-multiplier reference
    "Chap20_LTspice_Fig20_50": "current_mirror",     # Temperature behavior

    # Ch21: sub-types
    "Chap21_LTspice_Fig21_10": "amplifier",    # CS amp with gate-drain load
    "Chap21_LTspice_Fig21_17": "amplifier",    # CS amp DC curves
    "Chap21_LTspice_Fig21_19": "amplifier",    # CS with source degeneration
    "Chap21_LTspice_Fig21_42": "amplifier",    # Push-pull DC curves
    "Chap21_LTspice_Fig21_46": "amplifier",    # Push-pull biasing
    "Chap21_LTspice_Fig21_51": "amplifier",    # Distortion
    "Chap21_LTspice_Fig21_52": "amplifier",    # Distortion
    "Chap21_LTspice_Fig21_56": "amplifier",    # Class AB

    # Ch22: telescopic as sub-type
    "Chap22_LTspice_Fig22_23": "diff_amp",     # Telescopic diff-amp
    "Chap22_LTspice_Fig22_24": "diff_amp",     # Wide-swing diff-amp

    # Ch24: specific figure types
    "Chap24_LTspice_Fig24_3": "op_amp",        # DC transfer curves
    "Chap24_LTspice_Fig24_4": "op_amp",        # Offset analysis
    "Chap24_LTspice_Fig24_25_CMRR": "op_amp",  # CMRR measurement
    "Chap24_LTspice_Fig24_27_PSRR_minus": "op_amp",
    "Chap24_LTspice_Fig24_27_PSRR_plus": "op_amp",

    # Ch26: fully-differential
    "Chap26_LTspice_Fig26_44_DC": "op_amp_ii",

    # Ch27: comparators and multipliers
    "Chap27_LTspice_Fig27_6a": "comparator",
    "Chap27_LTspice_Fig27_6b": "comparator",
    "Chap27_LTspice_Fig27_7a": "comparator",
    "Chap27_LTspice_Fig27_7b": "comparator",
    "Chap27_LTspice_Fig27_10": "comparator",
    "Chap27_LTspice_Fig27_11": "comparator",
    "Chap27_LTspice_Fig27_12": "comparator",
    "Chap27_LTspice_Fig27_13": "comparator",
    "Chap27_LTspice_Fig27_27": "comparator",   # Analog multiplier
}


def parse_circuit(filepath):
    """Parse a .spice file and extract analysis types + existing metrics."""
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

    metric_patterns = [
        'dc_gain_db', 'ugbw', 'power_dc', 'avg_power', 'vout_swing',
        'rise_time', 'fall_time', 'iout_mid', 'rout_mid', 'vref',
        'psrr_100hz_db', 'vout_dc', 'vout_max', 'vout_min', 'period',
        'power_avg', 'power_uw', 'power_total', 'bandwidth', 'bw_3db',
        'static_current', 'tphl', 'tplh', 'gain_db', 'dropout',
        'output_swing', 'probe_db', 'dynamic_power', 'average_delay',
        'avg_delay', 'phase_margin', 'slew_rate',
    ]
    existing_metrics = sorted(set(
        m for m in metric_patterns
        if re.search(rf'\b{m}\b', content)
    ))

    # Count transistors
    nfet_count = len(re.findall(r'sky130_fd_pr__nfet', content))
    pfet_count = len(re.findall(r'sky130_fd_pr__pfet', content))

    # Check for subcircuits
    has_subckt = '.subckt' in content.lower()

    # Extract chapter/figure
    chap_match = re.search(r'Chap(\d+)', os.path.basename(filepath))
    fig_match = re.search(r'Fig(\d+)_(\d+)', os.path.basename(filepath))

    return {
        "analyses": analyses,
        "existing_metrics": existing_metrics,
        "nfet_count": nfet_count,
        "pfet_count": pfet_count,
        "total_transistors": nfet_count + pfet_count,
        "has_subckt": has_subckt,
        "chapter": int(chap_match.group(1)) if chap_match else None,
        "figure": f"{fig_match.group(1)}.{fig_match.group(2)}" if fig_match else None,
    }


def classify_circuit(name, parsed):
    """Classify circuit type based on name, chapter, and content."""
    # Check custom overrides first
    if name in CUSTOM_OVERRIDES:
        return CUSTOM_OVERRIDES[name]

    # Check figure-level overrides
    if name in FIGURE_OVERRIDES:
        return FIGURE_OVERRIDES[name]

    # Fall back to chapter default
    chapter = parsed["chapter"]
    if chapter and chapter in CHAPTER_INFO:
        return CHAPTER_INFO[chapter]["default_type"]

    # Custom circuits without chapter number
    name_lower = name.lower()
    if any(x in name_lower for x in ['ota', 'opamp', 'op_amp']):
        return "ota"
    if any(x in name_lower for x in ['amp', 'gain']):
        return "amplifier"
    if 'mirror' in name_lower:
        return "current_mirror"
    if any(x in name_lower for x in ['inv', 'buffer']):
        return "inverter"
    if any(x in name_lower for x in ['osc', 'vco', 'ring']):
        return "oscillator"
    if any(x in name_lower for x in ['bandgap', 'bgr', 'reference', 'ref']):
        return "voltage_reference"
    if any(x in name_lower for x in ['ldo', 'regulator']):
        return "ldo"
    if any(x in name_lower for x in ['filter', '_lp', '_hp', '_bp', '_bandp']):
        return "filter"

    return "special_purpose"


def main():
    spice_files = sorted(glob.glob(os.path.join(BAKER_DIR, "*.spice")))
    print(f"Processing {len(spice_files)} Baker textbook circuits\n")

    results = {}
    type_counts = {}

    for fpath in spice_files:
        name = os.path.splitext(os.path.basename(fpath))[0]
        parsed = parse_circuit(fpath)
        circuit_type = classify_circuit(name, parsed)

        template = SPEC_TEMPLATES.get(circuit_type, SPEC_TEMPLATES["special_purpose"])
        chapter = parsed["chapter"]
        chapter_info = CHAPTER_INFO.get(chapter, {}) if chapter else {}

        results[name] = {
            "circuit_type": circuit_type,
            "chapter": chapter,
            "chapter_topic": chapter_info.get("topic", "Custom"),
            "figure": parsed["figure"],
            "analyses": parsed["analyses"],
            "total_transistors": parsed["total_transistors"],
            "has_subcircuit": parsed["has_subckt"],
            "existing_metrics": parsed["existing_metrics"],
            "spec_template": {
                "description": template["description"],
                "optimize": template["optimize"],
                "measure": template["measure"],
                "tradeoffs": template["tradeoffs"],
            },
        }

        type_counts[circuit_type] = type_counts.get(circuit_type, 0) + 1

    # Save JSON
    output_path = os.path.join(os.path.dirname(__file__), "baker_circuit_specs.json")
    with open(output_path, 'w') as f:
        json.dump(results, f, indent=2)

    # Print summary
    print("=" * 70)
    print("CLASSIFICATION SUMMARY")
    print("=" * 70)
    for ctype, count in sorted(type_counts.items(), key=lambda x: -x[1]):
        template = SPEC_TEMPLATES.get(ctype, {})
        opt_metrics = ", ".join(template.get("optimize", []))
        print(f"  {ctype:25s}  {count:3d} circuits  optimize: [{opt_metrics}]")

    print(f"\n  Total: {len(results)} circuits")
    print(f"\n  Output: {output_path}")

    # Print per-chapter breakdown
    print("\n" + "=" * 70)
    print("PER-CHAPTER BREAKDOWN")
    print("=" * 70)
    chapters = {}
    for name, info in results.items():
        ch = info["chapter"] or "Custom"
        if ch not in chapters:
            chapters[ch] = {"types": {}, "count": 0}
        chapters[ch]["count"] += 1
        t = info["circuit_type"]
        chapters[ch]["types"][t] = chapters[ch]["types"].get(t, 0) + 1

    for ch in sorted(chapters.keys(), key=lambda x: (isinstance(x, str), x)):
        ch_info = CHAPTER_INFO.get(ch, {"topic": "Custom"}) if isinstance(ch, int) else {"topic": "Custom"}
        types_str = ", ".join(f"{t}({n})" for t, n in sorted(chapters[ch]["types"].items()))
        print(f"  Ch{ch:>3}  {ch_info['topic']:40s}  {chapters[ch]['count']:3d}  [{types_str}]")


if __name__ == "__main__":
    main()
