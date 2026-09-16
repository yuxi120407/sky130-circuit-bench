# sky130-circuit-bench

A benchmark suite of **1,097 simulatable CMOS circuits** on the SkyWater SKY130 open-source PDK, plus **AMS-ReasonBench** — a 4-task benchmark evaluating LLM understanding of analog/mixed-signal circuit design.

All circuits run in [ngspice](https://ngspice.sourceforge.io/) and produce extractable performance metrics (gain, power, bandwidth, etc.). Ground truth specifications come from Baker's *CMOS: Circuit Design, Layout, and Simulation* (3rd Edition).

## AMS-ReasonBench: 4 Benchmark Tasks

**980 total benchmark entries** across 246 Baker textbook circuits and 24 circuit types.

| Task | File | Entries | Input | Expected Output | Evaluation |
|------|------|---------|-------|-----------------|------------|
| **1. Spec Generation** | `task1_spec_generation.json` | 246 | Circuit netlist | List of performance metrics (name, unit, analysis, description) | Compare against Baker textbook ground truth |
| **2. Testbench Generation** | `task2_testbench_generation.json` | 246 | Circuit netlist + metrics list + PDK info | ngspice testbench code | Run in ngspice, check metrics extracted |
| **3. Sizing Optimization** | `task3_sizing_optimization.json` | 244 | Parameterized netlist + Baker target specs | W/L per transistor | Simulate proposed sizing, verify specs met |
| **4. Full Design** | `task4_full_design.json` | 244 | Parameterized netlist + PDK info only | Specs + W/L sizing | (1) Metric ID vs Baker, (2) simulate sizing |

All benchmark files are in `benchmark/`.

### Task 1: Spec Generation

Given a circuit netlist, identify all performance metrics that should be measured. The LLM must recognize the circuit type and enumerate the relevant specifications from analog design theory.

**Example** (op_amp, Ch 24 — `Chap24_LTspice_Fig24_10`):

```
Input:  34-transistor two-stage op_amp netlist

Output: 18 metrics
  open_loop_dc_gain_db     dB       AC     Open-loop voltage gain
  unity_gain_bandwidth_hz  Hz       AC     Frequency where |A_OL| = 0 dB
  phase_margin_deg         degrees  AC     180 + phase at unity-gain freq
  slew_rate_v_per_us       V/us     Tran   Max dVout/dt = Iss/Cc
  cmrr_db                  dB       AC     Common-mode rejection ratio
  psrr_positive_db         dB       AC     Power supply rejection (VDD)
  power_dc_w               W        OP     Total DC power
  settling_time_s          s        Tran   Time to settle within error band
  ... (+10 more)
  required_analyses: [AC, DC, OP, Tran]
```

### Task 2: Testbench Generation

Given a circuit netlist (subcircuit + top-level connections) and a list of metrics, write an ngspice testbench with input stimuli, analysis commands, and `.meas` statements.

**Example** (same op_amp):

```
Input:  netlist (subcircuit + top-level devices + power supply)
        metrics_to_measure: [dc_gain_db, ugbw, power_dc]
        pdk: sky130_fd_pr, vdd: 1.8, simulator: ngspice

Output: Stimulus + analysis code:
        vp vp 0 500m AC 1
        .control
        op
        let power_dc = abs(i(VDD)) * v(VDD)
        ac dec 100 1 10g
        let gain_db = db(vm(vout))
        meas ac ugbw WHEN gain_db=0 CROSS=1
        .endc

        Reference values: dc_gain_db=34.82, ugbw=2.54 MHz, power_dc=47.6 uW
```

### Task 3: Sizing Optimization

Given a parameterized netlist (W/L replaced with `{variables}`) and target specifications from Baker's textbook, choose optimal transistor sizing.

**Example** (same op_amp):

```
Input:  Parameterized netlist:
          xmsu2 N002 N002 VDD VDD pfet w={W_xmsu2} l={L_xmsu2}
          xm3   N003 Vbiasp VDD VDD pfet w={W_xm3}   l={L_xm3}
          ... (34 tunable devices)

        Baker target specs (Ch 24):
          open_loop_dc_gain_db:    >40 dB   (Baker: ~58 dB)
          unity_gain_bandwidth_hz: >10 MHz  (Baker: 10-400 MHz)
          phase_margin_deg:        >60 deg  (Baker: >=60 for stability)
          power_dc_w:              <300 uW  (Baker: 30-300 uW)
          slew_rate_v_per_us:      >5 V/us  (Baker: Iss/Cc)

        Constraints: min_L=0.15um, max_W=100um, VDD=1.8V

Output: W, L for each of 34 devices → verified by ngspice simulation
```

For circuit types where Baker does not provide numeric targets (comparator, inverter, memory, etc.), the task provides Baker-defined metric names with optimization directions (minimize/maximize).

### Task 4: Full Design (End-to-End)

The hardest task: given only a parameterized topology and PDK info, the LLM must **both** identify all relevant specs **and** choose device sizing. No target specs are provided.

**Example** (same op_amp):

```
Input:  Parameterized netlist + PDK info only (SKY130, VDD=1.8V, tt, 27C)
        No target specifications given.

Output: Part 1 — Identify as op_amp, list 18 metrics
        Part 2 — W, L for all 34 devices

Eval:   (1) Metric identification score vs Baker ground truth
        (2) Simulate proposed sizing, evaluate all identified metrics
```

### Circuit Types Covered

| Type | Circuits | Baker Chapter | Textbook Metrics |
|------|----------|---------------|------------------|
| op_amp | 47 | Ch 24 | 18 (gain, UGBW, PM, GM, CMRR, PSRR, slew rate, ...) |
| op_amp_ii | 25 | Ch 26 | 14 (fully-differential, CMFB) |
| current_mirror | 21 | Ch 20 | 6 (Rout, compliance, accuracy) |
| amplifier | 18 | Ch 21 | 14 (gain, BW, poles/zeros) |
| delta_sigma | 22 | Ch 17 | 8 (SNR, power) |
| inverter | 12 | Ch 11 | 10 (Vm, noise margins, delay) |
| ota | 10 | Ch 24 | 10 (Gm, gain, UGBW) |
| comparator | 9 | Ch 27 | 9 (delay, offset, hysteresis) |
| diff_amp | 9 | Ch 22 | 11 (diff gain, CMRR, ICM range) |
| + 15 more types | 71 | Ch 9-32 | 6-11 each |

## Sources

| Source | Circuits | Description |
|--------|----------|-------------|
| **Baker Textbook** | 246 | Adapted from R. Jacob Baker's *CMOS: Circuit Design, Layout, and Simulation* (3rd/4th Ed.), plus custom OTA/amplifier topologies |
| **RoCktNet** | 851 | Extracted from IEEE paper schematics via [RoCktNet](https://github.com/xz-group/RoCktNet/tree/master), converted to sky130 |

An additional 163 circuits that need fixing are included in `needs_fix/`.

## Quick Start

```bash
# Run Baker textbook circuits
python run_simulation.py --spice-dir ready_circuits/baker_textbook --run-all --timeout 120

# Run RoCktNet circuits
python run_simulation.py --spice-dir ready_circuits/rocktnet --run-all --timeout 120

# Run a single circuit
python run_simulation.py --spice-dir ready_circuits/baker_textbook --run five_trans_ota

# Run with verbose ngspice output
python run_simulation.py --spice-dir ready_circuits/baker_textbook --run five_trans_ota -v

# Custom results directory
python run_simulation.py --spice-dir ready_circuits/rocktnet --results-dir results/rocktnet/ --run-all
```

### Example Output

```
[  1/246] five_trans_ota                                        PASS  (3.5s, 3 metrics: dc_gain_db=17.09, power_dc=5.954e-05, ugbw=2.157e+07)
[  2/246] folded_cascode_ota                                    PASS  (3.2s, 2 metrics: power_dc=0.000445, ugbw_hz=2.57e+07)
```

## Requirements

| Dependency | Version | Notes |
|---|---|---|
| **ngspice** | >= 38 | Tested with ngspice-41 |
| **SkyWater SKY130 PDK** | sky130_fd_pr | Combined models library |
| **Python** | >= 3.7 | Standard library only (no pip packages needed) |

### Environment Setup

**Local install (conda):**

```bash
# Create environment and install ngspice
conda create -n sky130bench python=3.11 -y
conda activate sky130bench
conda install -c conda-forge ngspice -y

# Clone SKY130 PDK
git clone https://github.com/google/skywater-pdk-libs-sky130_fd_pr.git
```

Update paths in `run_simulation.py`:
```python
NGSPICE_BIN  = "<conda_env_path>/bin/ngspice"
PDK_LIB_PATH = "<clone_dir>/combined_models/sky130.lib.spice"
```

Verify:
```bash
ngspice --version
python run_simulation.py --spice-dir ready_circuits/baker_textbook --run five_trans_ota
```

## Directory Structure

```
sky130-circuit-bench/
├── README.md
├── run_simulation.py                  # Simulation runner and metric extraction
├── ready_circuits/                    # 1,097 circuits with 2+ metrics
│   ├── baker_textbook/                #   246 Baker textbook + custom circuits
│   │   ├── five_trans_ota.spice
│   │   ├── Chap20_LTspice_Fig20_29.spice
│   │   └── ...
│   └── rocktnet/                      #   851 RoCktNet IEEE paper circuits
│       ├── rocktnet_tc000001.spice
│       └── ...
├── benchmark/                         # AMS-ReasonBench (980 entries)
│   ├── task1_spec_generation.json     #   246 entries — identify metrics
│   ├── task2_testbench_generation.json #  246 entries — write testbench
│   ├── task3_sizing_optimization.json #   244 entries — choose W/L
│   └── task4_full_design.json         #   244 entries — specs + sizing
├── baker_textbook_specs.json          # Baker ground truth specs (16 circuit types)
├── baker_circuit_specs.json           # Per-circuit spec templates (246 circuits)
├── baker_circuit_metric_mapping.csv   # Circuit-to-metric mapping
├── needs_fix/                         # 163 circuits that need work
│   └── rocktnet/
│       └── ...
├── results/                           # Generated after --run-all
│   └── <spice_dir_name>/
│       └── metrics_summary.csv
└── docs/
    └── index.html                     # Interactive web dashboard
```

## Circuit Inventory

### Baker Textbook (246 circuits)

| Chapter | Topic | Circuits | Analysis Types |
|---|---|---|---|
| Ch 9 | Models for Analog Design | 2 | DC |
| Ch 10 | Models for Digital Design | 2 | Tran |
| Ch 11 | The Inverter | 10 | Tran, DC |
| Ch 12 | Static Logic Gates | 4 | Tran, DC |
| Ch 13 | Clocked Circuits | 10 | Tran, DC |
| Ch 14 | Dynamic Logic Gates | 1 | DC |
| Ch 16 | Memory Circuits | 10 | Tran |
| Ch 17 | Sensing Using Delta-Sigma Modulation | 19 | Tran |
| Ch 18 | Special Purpose CMOS Circuits | 17 | Tran, DC |
| Ch 19 | Digital Phase-Locked Loops | 2 | Tran, DC |
| Ch 20 | Current Mirrors | 22 | DC, Tran |
| Ch 21 | Amplifiers | 16 | AC, Tran, DC |
| Ch 22 | Differential Amplifiers | 9 | AC, Tran, DC |
| Ch 23 | Voltage References | 3 | DC |
| Ch 24 | Operational Amplifiers I | 44 | AC, Tran, DC |
| Ch 25 | Dynamic Analog Circuits | 2 | Tran |
| Ch 26 | Operational Amplifiers II | 25 | Tran, DC |
| Ch 27 | Nonlinear Analog Circuits | 9 | Tran, DC |
| Ch 31 | Feedback Amplifiers | 5 | AC, Tran |
| Ch 32 | Hysteretic Power Converters | 4 | Tran |
| Custom | OTAs, gates, oscillators, LDO, bandgap | 30 | AC, Tran, DC |

### RoCktNet (851 ready + 163 needs_fix)

Circuits extracted from IEEE paper schematics, covering amplifiers, comparators, ADCs, PLLs, mixers, oscillators, and more. Each circuit has been:
- Converted to sky130 device models (nfet_01v8, pfet_01v8)
- Biased at 1.8V VDD
- Equipped with auto-generated testbenches (OP, AC, or both)

## Metrics

### Existing Simulation Metrics

Extracted by `run_simulation.py` from existing testbenches (avg 3.3 per circuit):

| Metric | Unit | Circuits | Description |
|---|---|---|---|
| `power_dc` | W | 660 | DC power consumption |
| `dc_gain_db` | dB | 351 | Low-frequency open-loop voltage gain |
| `avg_power` | W | 114 | Average power (transient) |
| `vout_swing` | V | 118 | Peak-to-peak output voltage swing |
| `ugbw` | Hz | 52 | Unity-gain bandwidth (0 dB crossing) |
| `max_gain_db` | dB | 78 | Maximum gain across frequency |
| `rise_time` / `fall_time` | s | 19-26 | Output transition times |
| `rout_mid` | Ohm | 10 | Output resistance (current mirrors) |

### Baker Textbook Metrics (Ground Truth)

Comprehensive metric definitions from Baker's textbook (6-18 per circuit type):

| Analysis | Example Metrics |
|---|---|
| **AC** | `open_loop_dc_gain_db`, `ugbw`, `phase_margin`, `gain_margin`, `cmrr`, `psrr+`, `psrr-`, `output_resistance`, `closed_loop_bandwidth` |
| **Transient** | `slew_rate`, `settling_time`, `rise_time`, `fall_time`, `propagation_delay` |
| **DC / OP** | `power_dc`, `output_swing`, `input_common_mode_range`, `input_offset`, `bias_current` |
| **Design** | `compensation_capacitor`, `load_capacitance` |

Full metric definitions per circuit type are in `baker_textbook_specs.json`.

## Programmatic Usage

```python
from run_simulation import run_circuit, list_circuits

# Run a single circuit
result = run_circuit("five_trans_ota", timeout=60)
print(result["metrics"])
# {'dc_gain_db': 17.09, 'ugbw': 21571200.0, 'power_dc': 5.95e-05}

# List all circuits
circuits = list_circuits()
for c in circuits:
    print(c["name"], c["chapter"], c["analysis"])
```

## PDK and Process

All circuits use the [SkyWater SKY130](https://github.com/google/skywater-pdk) 130nm CMOS process:

- **NMOS**: `sky130_fd_pr__nfet_01v8` (1.8V, Vth ~ 0.4V)
- **PMOS**: `sky130_fd_pr__pfet_01v8` (1.8V, |Vth| ~ 0.4V)
- **Corner**: `tt` (typical-typical)
- **Supply**: 1.8V
- **Temperature**: 27C

## Citation

If you use this benchmark in your research, please cite:

```bibtex
@book{baker2019cmos,
  title={CMOS: Circuit Design, Layout, and Simulation},
  author={Baker, R. Jacob},
  year={2019},
  publisher={Wiley},
  edition={4th}
}
```

## License

The circuit netlists are derived from educational examples. The SKY130 PDK is available under the Apache 2.0 license.
