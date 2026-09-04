# sky130-circuit-bench

A benchmark suite of **246 simulatable CMOS circuits** built on the SkyWater SKY130 open-source PDK. All circuits run in [ngspice](https://ngspice.sourceforge.io/) and produce extractable performance metrics (gain, power, bandwidth, delay, etc.).

The circuits are adapted from R. Jacob Baker's textbook *CMOS: Circuit Design, Layout, and Simulation* (3rd/4th Edition) and a set of custom OTA/amplifier topologies. Original LTspice netlists were converted to ngspice-compatible format using the `sky130_fd_pr` device models.

## Quick Start

```bash
# List all available circuits
python run_simulation.py

# Run a single circuit and see its metrics
python run_simulation.py --run five_trans_ota

# Run with full ngspice output
python run_simulation.py --run five_trans_ota -v

# Run all 246 circuits (takes ~30 min)
python run_simulation.py --run-all --timeout 120
```

### Example Output

```
Circuit: five_trans_ota
Success: True
Time:    3.49s

Metrics:
  dc_gain_db           = 17.0908
  power_dc             = 5.95423e-05
  ugbw                 = 2.15712e+07
```

## Requirements

| Dependency | Version | Notes |
|---|---|---|
| **ngspice** | >= 38 | Tested with ngspice-41 |
| **SkyWater SKY130 PDK** | sky130_fd_pr | Combined models library |
| **Python** | >= 3.7 | Standard library only (no pip packages needed) |

### Environment Setup

The paths are configured in `run_simulation.py`. Update them for your environment:


**Local install (conda):**

```bash
# Create environment and install ngspice
conda create -n sky130bench python=3.11 -y
conda activate sky130bench
conda install -c conda-forge ngspice -y

# Clone SKY130 PDK
git clone https://github.com/google/skywater-pdk-libs-sky130_fd_pr.git

Update paths in run_simulation.py:
  NGSPICE_BIN  = "<conda_env_path>/bin/ngspice"
  PDK_LIB_PATH = "<clone_dir>/combined_models/sky130.lib.spice"

# Verify
ngspice --version
python run_simulation.py --run five_trans_ota
```

## Directory Structure

```
sky130-circuit-bench/
├── README.md
├── run_simulation.py            # Simulation runner and metric extraction
├── simulatable_spices/          # 246 ngspice-ready .spice files
│   ├── five_trans_ota.spice
│   ├── Chap20_LTspice_Fig20_29.spice
│   ├── ...
│   └── voltage_controlled_osc.spice
└── results/                     # Generated after --run-all
    ├── simulation_report.json
    └── metrics_summary.csv
```

## Circuit Inventory (246 total)

### By Chapter (Baker's CMOS Textbook)

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

### Custom Circuits (24)

| Circuit | Type | Key Metrics |
|---|---|---|
| `five_trans_ota` | 5-transistor OTA | dc_gain_db, ugbw, power_dc |
| `folded_cascode_ota` | Folded-cascode OTA | dc_gain_db, ugbw, power_dc |
| `telescopic_ota` | Telescopic OTA | dc_gain_db, ugbw, power_dc |
| `current_mirror_ota` | Current-mirror OTA | dc_gain_db, ugbw, power_dc |
| `smc` | Single Miller Compensation amp | dc_gain_db, ugbw, power_dc |
| `dfcfc` | Dual Feedforward Compensation amp | dc_gain_db, ugbw, power_dc |
| `azc` | Active Zero Compensation amp | dc_gain_db, ugbw, power_dc |
| `fdgb` | Fully Differential Gain-Boosted amp | dc_gain_db, power_dc |
| `iac` | Indirect Amplifier Compensation | dc_gain_db, power_dc |
| `nmcnr` | Nested Miller w/ Nulling Resistor | dc_gain_db, power_dc |
| `inverter` | CMOS Inverter | delay, power |
| `nand_gate` | NAND Gate | delay, power |
| `buffer` | Buffer | delay, power |
| `ldo_regulator` | LDO Voltage Regulator | vout, power, dropout |
| `diode_load_amp` | Diode-Load Amplifier | gain_db, bandwidth |
| `resistive_load_amp` | Resistive-Load Amplifier | gain_db |
| `bandgap_reference` | Bandgap Voltage Reference | vref |
| `switched_capacitor` | Switched-Capacitor Circuit | gain |
| `3_stage_ring_osc` | 3-Stage Ring Oscillator | period, frequency, power |
| `voltage_controlled_osc` | 5-Stage VCO | period, frequency, power |

### Extra Circuits (6)

Three-stage op-amp (AC + transient), Delta-Sigma memory sensing circuits.

## Metric Types

| Analysis | Metrics Extracted | # Circuits |
|---|---|---|
| **AC** | `dc_gain_db`, `ugbw` (unity-gain bandwidth), `power_dc` | 73 |
| **Transient** | `avg_power`, `vout_swing`, `vout_max`, `vout_min`, `rise_time`, `fall_time` | 118 |
| **DC / OP** | `dc_gain_db`, `power_dc`, `iout_mid`, `rout_mid` | 55 |

### Metric Glossary

| Metric | Unit | Description |
|---|---|---|
| `dc_gain_db` | dB | Low-frequency open-loop voltage gain |
| `ugbw` | Hz | Unity-gain bandwidth (0 dB crossing) |
| `power_dc` | W | DC power consumption |
| `avg_power` | W | Average power (transient) |
| `vout_swing` | V | Peak-to-peak output voltage swing |
| `vout_max` | V | Maximum output voltage |
| `vout_min` | V | Minimum output voltage |
| `rise_time` | s | 10%-to-90% output rise time |
| `fall_time` | s | 90%-to-10% output fall time |
| `iout_mid` | A | Output current at mid-supply (current mirrors) |
| `rout_mid` | Ohm | Output resistance at mid-supply (current mirrors) |
| `tphl_ps` | ps | Propagation delay high-to-low (digital) |
| `tplh_ps` | ps | Propagation delay low-to-high (digital) |
| `avg_delay_ps` | ps | Average propagation delay (digital) |
| `power_total_uw` | uW | Total power dissipation (digital) |
| `freq` | Hz | Oscillation frequency (ring osc / VCO) |
| `vref` | V | Reference voltage (bandgap) |
| `dropout_mv` | mV | Dropout voltage (LDO regulator) |

## Full Circuit-Metric Listing (246 circuits)

<details>
<summary>Click to expand full per-circuit metric table</summary>

#### Chap10 -- Models for Digital Design (2 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap10_LTspice_Fig10_20` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap10_LTspice_Fig10_23` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |

#### Chap11 -- The Inverter (10 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap11_LTspice_Fig11_10` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap11_LTspice_Fig11_11` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap11_LTspice_Fig11_11_varying_Wp` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap11_LTspice_Fig11_14` | DC | `power_dc` |
| `Chap11_LTspice_Fig11_20` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap11_LTspice_Fig11_21` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap11_LTspice_Fig11_4_long` | DC | `dc_gain_db`, `power_dc` |
| `Chap11_LTspice_Fig11_4_short` | DC | `dc_gain_db`, `power_dc` |
| `Chap11_LTspice_Fig11_7` | DC | `dc_gain_db`, `power_dc` |
| `Chap11_LTspice_Fig11_8` | DC | `dc_gain_db`, `power_dc` |

#### Chap12 -- Static Logic Gates (4 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap12_LTspice_Fig12_10` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap12_LTspice_Fig12_12` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap12_LTspice_Fig12_3` | DC | `dc_gain_db`, `power_dc` |
| `Chap12_LTspice_Fig12_5` | DC | `dc_gain_db`, `power_dc` |

#### Chap13 -- Clocked Circuits (10 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap13_LTspice_Fig13_17` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap13_LTspice_Fig13_19` | DC | `power_dc` |
| `Chap13_LTspice_Fig13_21` | DC | `power_dc` |
| `Chap13_LTspice_Fig13_23` | DC | `power_dc` |
| `Chap13_LTspice_Fig13_28` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap13_LTspice_Fig13_3` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap13_LTspice_Fig13_30` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap13_LTspice_Fig13_32` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap13_LTspice_Fig13_34` | DC | `power_dc` |
| `Chap13_LTspice_Fig13_4` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |

#### Chap14 -- Dynamic Logic Gates (1 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap14_LTspice_Fig14_7` | DC | `power_dc` |

#### Chap16 -- Memory Circuits (10 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap16_LTspice_Fig16_11` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap16_LTspice_Fig16_12` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap16_LTspice_Fig16_14` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap16_LTspice_Fig16_27` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap16_LTspice_Fig16_28` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap16_LTspice_Fig16_29` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap16_LTspice_Fig16_36` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap16_LTspice_Fig16_37` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap16_LTspice_Fig16_38` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap16_LTspice_Fig16_8` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |

#### Chap17 -- Sensing (DSM) (19 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap17_LTspice_Fig17_11` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap17_LTspice_Fig17_12` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap17_LTspice_Fig17_13` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap17_LTspice_Fig17_19a` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap17_LTspice_Fig17_19b` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap17_LTspice_Fig17_19c` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap17_LTspice_Fig17_19d` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap17_LTspice_Fig17_22a` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap17_LTspice_Fig17_22b` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap17_LTspice_Fig17_34a` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap17_LTspice_Fig17_34b` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap17_LTspice_Fig17_34c` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap17_LTspice_Fig17_37a` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap17_LTspice_Fig17_37b` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap17_LTspice_Fig17_37c` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap17_LTspice_Fig17_37d` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap17_LTspice_Fig17_37e` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap17_LTspice_Fig17_39` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap17_LTspice_Fig17_6` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |

#### Chap18 -- Special Purpose CMOS (17 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap18_LTspice_Fig18_13` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap18_LTspice_Fig18_14` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap18_LTspice_Fig18_15` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap18_LTspice_Fig18_18` | DC | `power_dc` |
| `Chap18_LTspice_Fig18_19` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap18_LTspice_Fig18_20` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap18_LTspice_Fig18_22` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap18_LTspice_Fig18_24` | DC | `power_dc` |
| `Chap18_LTspice_Fig18_29a` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap18_LTspice_Fig18_29b` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap18_LTspice_Fig18_31` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap18_LTspice_Fig18_34` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap18_LTspice_Fig18_38` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap18_LTspice_Fig18_39` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap18_LTspice_Fig18_40a` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap18_LTspice_Fig18_40b` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap18_LTspice_Fig18_5` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |

#### Chap19 -- Phase-Locked Loops (2 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap19_LTspice_Fig19_59` | DC | `power_dc` |
| `Chap19_LTspice_Fig19_66` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |

#### Chap20 -- Current Mirrors (22 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap20_LTspice_Fig20_10` | DC | `power_dc` |
| `Chap20_LTspice_Fig20_11` | DC | `power_dc` |
| `Chap20_LTspice_Fig20_13` | DC | `power_dc` |
| `Chap20_LTspice_Fig20_16` | DC | `power_dc` |
| `Chap20_LTspice_Fig20_18` | DC | `power_dc` |
| `Chap20_LTspice_Fig20_20` | DC | `power_dc` |
| `Chap20_LTspice_Fig20_23` | DC | `power_dc` |
| `Chap20_LTspice_Fig20_24` | DC | `power_dc` |
| `Chap20_LTspice_Fig20_25` | DC | `power_dc` |
| `Chap20_LTspice_Fig20_26` | DC | `power_dc` |
| `Chap20_LTspice_Fig20_27` | DC | `power_dc` |
| `Chap20_LTspice_Fig20_29` | DC | `iout_mid`, `power_dc`, `rout_mid` |
| `Chap20_LTspice_Fig20_33` | DC | `iout_mid`, `power_dc`, `rout_mid` |
| `Chap20_LTspice_Fig20_36` | DC | `iout_mid`, `power_dc`, `rout_mid` |
| `Chap20_LTspice_Fig20_37` | DC | `iout_mid`, `power_dc`, `rout_mid` |
| `Chap20_LTspice_Fig20_38` | DC | `iout_mid`, `power_dc`, `rout_mid` |
| `Chap20_LTspice_Fig20_39` | DC | `iout_mid`, `power_dc`, `rout_mid` |
| `Chap20_LTspice_Fig20_4` | DC | `iout_mid`, `power_dc`, `rout_mid` |
| `Chap20_LTspice_Fig20_42` | DC | `iout_mid`, `power_dc`, `rout_mid` |
| `Chap20_LTspice_Fig20_44` | DC | `iout_mid`, `power_dc`, `rout_mid` |
| `Chap20_LTspice_Fig20_48` | DC | `iout_mid`, `power_dc`, `rout_mid` |
| `Chap20_LTspice_Fig20_50` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |

#### Chap21 -- Amplifiers (16 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap21_LTspice_Fig21_10` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap21_LTspice_Fig21_17` | DC | `dc_gain_db`, `power_dc` |
| `Chap21_LTspice_Fig21_19` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap21_LTspice_Fig21_22` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap21_LTspice_Fig21_23` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap21_LTspice_Fig21_27` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap21_LTspice_Fig21_29` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap21_LTspice_Fig21_32` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap21_LTspice_Fig21_34` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap21_LTspice_Fig21_36` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap21_LTspice_Fig21_42` | DC | `dc_gain_db`, `power_dc` |
| `Chap21_LTspice_Fig21_46` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap21_LTspice_Fig21_51` | DC | `dc_gain_db`, `power_dc` |
| `Chap21_LTspice_Fig21_52` | DC | `dc_gain_db`, `power_dc` |
| `Chap21_LTspice_Fig21_56` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap21_LTspice_Fig21_9` | AC | `dc_gain_db`, `power_dc`, `ugbw` |

#### Chap22 -- Differential Amplifiers (9 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap22_LTspice_Fig22_10` | DC | `power_dc` |
| `Chap22_LTspice_Fig22_13` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap22_LTspice_Fig22_14` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap22_LTspice_Fig22_16` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap22_LTspice_Fig22_17` | DC | `power_dc` |
| `Chap22_LTspice_Fig22_23` | DC | `power_dc` |
| `Chap22_LTspice_Fig22_24` | DC | `power_dc` |
| `Chap22_LTspice_Fig22_3` | DC | `power_dc` |
| `Chap22_LTspice_Fig22_7` | DC | `power_dc` |

#### Chap23 -- Voltage References (3 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap23_LTspice_Fig23_10` | DC | `power_dc` |
| `Chap23_LTspice_Fig23_12` | DC | `power_dc` |
| `Chap23_LTspice_Fig23_14` | DC | `power_dc` |

#### Chap24 -- Op-Amps I (44 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap24_LTspice_Fig24_10` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_11` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_12` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_13` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_14` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_19` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_20` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_21_AC_response` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_22` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_23` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_24` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_25_CMRR` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_27_PSRR_minus` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_27_PSRR_plus` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_3` | DC | `dc_gain_db`, `power_dc` |
| `Chap24_LTspice_Fig24_30` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_31` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_31_no_load` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_31_varying_ccomp` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_31_varying_cload` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_32` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_32_no_load` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_34` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_36` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_38` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_39` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_4` | DC | `dc_gain_db`, `power_dc` |
| `Chap24_LTspice_Fig24_41` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_43` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_45` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_46` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_47_AC` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_47_tran` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_49` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_52_AC` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_52_tran` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_53_AC` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_53_tran` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_62_AC` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_62_pulse` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_63_AC` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_63_AC_Cc2=2400f` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap24_LTspice_Fig24_63_pulse` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap24_LTspice_Fig24_63_pulse_Cc2=2400f` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |

#### Chap25 -- Dynamic Analog (2 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap25_LTspice_Fig25_20` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap25_LTspice_Fig25_20_better_convergence` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |

#### Chap26 -- Op-Amps II (25 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap26_LTspice_Fig26_17` | DC | `power_dc` |
| `Chap26_LTspice_Fig26_20` | DC | `power_dc` |
| `Chap26_LTspice_Fig26_21` | DC | `power_dc` |
| `Chap26_LTspice_Fig26_23` | DC | `power_dc` |
| `Chap26_LTspice_Fig26_24_large` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap26_LTspice_Fig26_24_small` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap26_LTspice_Fig26_25` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap26_LTspice_Fig26_27` | DC | `power_dc` |
| `Chap26_LTspice_Fig26_28` | DC | `power_dc` |
| `Chap26_LTspice_Fig26_30` | DC | `power_dc` |
| `Chap26_LTspice_Fig26_34` | DC | `power_dc` |
| `Chap26_LTspice_Fig26_35_large` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap26_LTspice_Fig26_35_small` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap26_LTspice_Fig26_36` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap26_LTspice_Fig26_4` | DC | `power_dc` |
| `Chap26_LTspice_Fig26_44_DC` | DC | `dc_gain_db`, `power_dc` |
| `Chap26_LTspice_Fig26_44_large` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap26_LTspice_Fig26_44_small` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap26_LTspice_Fig26_45_25fF` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap26_LTspice_Fig26_45_50fF` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap26_LTspice_Fig26_48` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap26_LTspice_Fig26_55` | DC | `power_dc` |
| `Chap26_LTspice_Fig26_57` | DC | `power_dc` |
| `Chap26_LTspice_Fig26_59` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap26_LTspice_Fig26_60` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |

#### Chap27 -- Nonlinear Analog (9 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap27_LTspice_Fig27_10` | DC | `dc_gain_db`, `power_dc` |
| `Chap27_LTspice_Fig27_11` | DC | `dc_gain_db`, `power_dc` |
| `Chap27_LTspice_Fig27_12` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap27_LTspice_Fig27_13` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap27_LTspice_Fig27_27` | DC | `power_dc` |
| `Chap27_LTspice_Fig27_6a` | DC | `power_dc` |
| `Chap27_LTspice_Fig27_6b` | DC | `power_dc` |
| `Chap27_LTspice_Fig27_7a` | DC | `power_dc` |
| `Chap27_LTspice_Fig27_7b` | DC | `power_dc` |

#### Chap31 -- Feedback Amplifiers (5 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap31_LTspice_Fig31_46` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap31_LTspice_Fig31_47` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap31_LTspice_Fig31_49` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `Chap31_LTspice_Fig31_52` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap31_LTspice_Fig31_53` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |

#### Chap32 -- Power Converters (4 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap32_LTspice_Fig32_20` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap32_LTspice_Fig32_21` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap32_LTspice_Fig32_24` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `Chap32_LTspice_Fig32_9` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |

#### Chap9 -- Models for Analog Design (2 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `Chap9_LTspice_Fig9_19` | DC | `power_dc` |
| `Chap9_LTspice_Fig9_20` | DC | `power_dc` |

#### Custom -- Custom (24 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `3_stage_ring_osc` | Tran | `i_avg`, `power_avg`, `v_first`, `v_second` |
| `azc` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `bandgap_reference` | AC | `line_regulation_percent`, `power_uw`, `psrr_100hz_db`, `vref` |
| `buffer` | Tran | `average_delay`, `dc_gain_db`, `dynamic_power`, `static_i`, `t_in_f`, `t_in_r`, `t_out_f`, `t_out_r` |
| `current_mirror_ota` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `dfcfc` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `diode_load_amp` | AC | `bandwidth_mhz`, `bw`, `dc_gain_db`, `output_swing_v`, `power_uw` |
| `fdgb` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `five_trans_ota` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `folded_cascode_ota` | AC | `power_dc`, `ugbw_hz` |
| `folded_cascode_ota_bandp` | AC | `power_dc`, `ugbw_hz` |
| `folded_cascode_ota_hp` | AC | `power_dc`, `ugbw_hz` |
| `folded_cascode_ota_lp` | AC | `power_dc`, `ugbw_hz` |
| `iac` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `inverter` | Tran | `average_delay`, `dc_gain_db`, `dynamic_power`, `static_current`, `t_in_50_fall`, `t_in_50_rise`, `t_out_50_fall`, `t_out_50_rise` |
| `ldo_regulator` | DC | `dropout_mv`, `power_uw`, `vout` |
| `nand_gate` | Tran | `avg_delay_ps`, `power_total_uw`, `tphl`, `tphl_ps`, `tplh`, `tplh_ps`, `vout_max`, `vout_min` |
| `nmcnr` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `resistive_load_amp` | AC | `bandwidth_mhz`, `bw`, `dc_gain_db`, `output_swing_v`, `power_uw` |
| `smc` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `switched_capacitor` | Tran | `power_uw` |
| `telescopic_ota` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `voltage_controlled_osc` | Tran | `freq`, `i_avg`, `power_avg`, `v_first`, `v_second` |
| `xor_gate` | Tran | `avg_delay_ps`, `power_total_uw`, `tphl`, `tphl_ps`, `tplh`, `tplh_ps`, `vout_max`, `vout_min` |

#### _Extras -- _Extras (6 circuits)

| Circuit | Analysis | Metrics |
|---|---|---|
| `_Extras_LTspice_Analog_3_stage_opamp_AC` | AC | `dc_gain_db`, `power_dc`, `ugbw` |
| `_Extras_LTspice_Analog_3_stage_opamp_tran` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `_Extras_LTspice_Analog_3_stage_opamp_tran2` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `_Extras_LTspice_Memory_DSM_sensing_Flash_simple` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `_Extras_LTspice_Memory_DSM_sensing_Flash_wcount` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |
| `_Extras_LTspice_Memory_DSM_sensing_Flash_wcount_5bit` | Tran | `avg_power`, `fall_time`, `rise_time`, `vout_max`, `vout_min`, `vout_swing` |


</details>



## Programmatic Usage

```python
from run_simulation import run_circuit, list_circuits

# Run a single circuit
result = run_circuit("folded_cascode_ota", timeout=60)
print(result["metrics"])
# {'dc_gain_db': 9.21, 'ugbw': 25700000.0, 'power_dc': 0.000445}

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
- **Supply**: 1.0V or 1.8V depending on circuit
- **Temperature**: 27C

## Citation

If you use this benchmark in your research, please cite:

```
Baker, R. Jacob. "CMOS: Circuit Design, Layout, and Simulation."
IEEE Press Series on Microelectronic Systems, Wiley, 3rd/4th Edition.
```

## License

The circuit netlists are derived from educational examples. The SKY130 PDK is available under the Apache 2.0 license.
