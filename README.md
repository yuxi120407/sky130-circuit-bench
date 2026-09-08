# sky130-circuit-bench

A benchmark suite of **1,097 simulatable CMOS circuits** built on the SkyWater SKY130 open-source PDK. All circuits run in [ngspice](https://ngspice.sourceforge.io/) and produce extractable performance metrics (gain, power, bandwidth, etc.).

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
│       ├── rocktnet_tc000002.spice
│       └── ...
├── needs_fix/                         # 163 circuits that need work
│   └── rocktnet/                      #   All RoCktNet (no Baker failures)
│       └── ...
└── results/                           # Generated after --run-all
    └── <spice_dir_name>/
        └── metrics_summary.csv
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

## Metric Types

### Metrics by Analysis

| Analysis | Metrics Extracted | Description |
|---|---|---|
| **AC** | `dc_gain_db`, `ugbw` | Low-frequency gain and unity-gain bandwidth |
| **Transient** | `avg_power`, `vout_swing`, `vout_max`, `vout_min` | Power and output swing |
| **DC / OP** | `power_dc`, `vout_dc`, `iout_mid`, `rout_mid` | Operating point metrics |

### Metric Glossary

| Metric | Unit | Description |
|---|---|---|
| `dc_gain_db` | dB | Low-frequency open-loop voltage gain |
| `ugbw` | Hz | Unity-gain bandwidth (0 dB crossing) |
| `power_dc` | W | DC power consumption |
| `vout_dc` | V | DC output voltage (operating point) |
| `avg_power` | W | Average power (transient) |
| `vout_swing` | V | Peak-to-peak output voltage swing |
| `vout_max` | V | Maximum output voltage |
| `vout_min` | V | Minimum output voltage |
| `iout_mid` | A | Output current at mid-supply (current mirrors) |
| `rout_mid` | Ohm | Output resistance at mid-supply (current mirrors) |
| `vref` | V | Reference voltage (bandgap) |
| `psrr_100hz_db` | dB | Power supply rejection ratio at 100 Hz |

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
