# sky130-circuit-bench

A benchmark suite of **989 verified CMOS circuits** on the SkyWater SKY130 open-source PDK, with automated testbench generation, verification, and repair — plus **AMS-ReasonBench**, a multi-task benchmark evaluating LLM understanding of analog/mixed-signal circuit design.

All circuits run in [ngspice](https://ngspice.sourceforge.io/) and produce extractable performance metrics (gain, power, bandwidth, etc.).

## Circuit Collection

**989 circuits** organized by verification status across 13 circuit categories:

| Status | Baker | RoCktNet | Total |
|--------|-------|----------|-------|
| **Pass** (S1+S2+S3) | 139 | 513 | **652** |
| **Fail — S1 syntax** | 65 | 143 | 208 |
| **Fail — S2 convergence** | 2 | 4 | 6 |
| **Fail — S3 sanity** | 39 | 84 | 123 |
| **Total** | **245** | **744** | **989** |

### Circuit Categories

| Category | Count | Description |
|----------|-------|-------------|
| Amplifiers | 303 | OTA, Op-Amp, Diff-Amp, Cascode, VGA, Buffer |
| Subcircuit / Building Block | 258 | Current mirrors, bias circuits, basic cells |
| Digital & Logic | 73 | Inverter, NAND, NOR, Flip-flop, Latch, Mux |
| Clock & Frequency Generation | 68 | Ring Osc, VCO, PLL, CDR |
| Memory & Sensing | 56 | SRAM, Flash, Sense amp |
| RF & Mixer | 53 | Mixer, LNA, PA, Balun |
| Comparators | 43 | StrongARM, dynamic, clocked |
| Filters | 40 | Low-pass, High-pass, Gm-C, Switched-cap |
| References & Regulators | 29 | Bandgap, LDO, Voltage ref, Current ref |
| Data Converters | 22 | ADC, DAC, S/H |
| Power Management | 22 | Charge pump, DC-DC, Level shifter |
| SerDes & High-Speed I/O | 16 | Equalizer, CML driver, LVDS |
| Other | 8 | Miscellaneous |

## Pipeline

The benchmark is built through a 4-stage automated pipeline:

```
Stage 1: Extract        Stage 2: Verify         Stage 3: Repair         Stage 4: Classify
─────────────────       ───────────────────      ───────────────────     ─────────────────
extract_baker_           verify_testbenches.py    verify_and_repair.py    classify_circuits.py
  metrics.py             (S1 syntax,              (Gemini-assisted        (13 categories)
extract_rocktnet_         S2 convergence,          multi-round repair)
  metrics.py              S3 sanity check)

     │                        │                        │                       │
     ▼                        ▼                        ▼                       ▼
extracted_metrics/       verification_spice/     verification_spice_fixed/  circuit_collection/
extracted_metrics_       verification_results/   verification_results/      circuit_index.json
  rocktnet/
```

### Stage 1: Metric Extraction

Sends each circuit + reference material to Gemini, which returns circuit type, performance metrics, and an ngspice testbench.

```bash
python extract_baker_metrics.py              # Baker circuits (uses textbook PDFs)
python extract_rocktnet_metrics.py           # RoCktNet circuits (uses CIS metadata)
```

### Stage 2: Verification

Resolves testbench placeholders, runs through ngspice, checks syntax (S1), convergence (S2), and measurement sanity (S3).

```bash
python verify_testbenches.py --source baker
python verify_testbenches.py --source rocktnet
```

### Stage 3: Verify & Repair

All-in-one pipeline: runs S1→S2→S3 with Gemini-assisted repair at each failing step (up to N retries).

```bash
python verify_and_repair.py --source baker --max-retries 3
python verify_and_repair.py --source rocktnet --max-retries 3
python verify_and_repair.py --source baker --resume          # skip already-done
python verify_and_repair.py --source baker --retry-failures  # re-try FAILs only
```

### Stage 4: Classification

Classifies circuits into 13 functional categories.

```bash
python classify_circuits.py --source baker
python classify_circuits.py --source rocktnet
```

## AMS-ReasonBench: Benchmark Tasks

**980 total benchmark entries** across 246 Baker textbook circuits and 24 circuit types.

| Task | File | Entries | Input | Expected Output |
|------|------|---------|-------|-----------------|
| **1. Spec Generation** | `task1_spec_generation.json` | 246 | Circuit netlist | List of performance metrics |
| **2. Testbench Generation** | `task2_testbench_generation.json` | 246 | Netlist + metrics + PDK | ngspice testbench code |
| **3. Target Spec Prediction** | `task3_target_spec_prediction.json` | 244 | Netlist + metrics | Expected spec ranges |
| **4. Sizing Optimization** | `task4_sizing_optimization.json` | 244 | Parameterized netlist + specs | W/L per transistor |
| **5. Full Design** | `task5_full_design.json` | 244 | Parameterized netlist + PDK only | Specs + W/L sizing |

All benchmark files are in `benchmark/`.

## Directory Structure

```
sky130-circuit-bench/
├── README.md
│
├── # ── Pipeline Scripts ──
├── extract_baker_metrics.py           # Stage 1: extract metrics (Baker)
├── extract_rocktnet_metrics.py        # Stage 1: extract metrics (RoCktNet)
├── verify_testbenches.py              # Stage 2: verify in ngspice
├── verify_and_repair.py               # Stage 3: verify + Gemini repair
├── classify_circuits.py               # Stage 4: classify circuit types
├── test/
│   └── gemini_call_v2.py              # Gemini API helper (used by all scripts)
│
├── # ── Circuit Data ──
├── ready_circuits/                    # 1,097 input circuits (sky130 SPICE)
│   ├── baker_textbook/                #   246 Baker textbook circuits
│   └── rocktnet/                      #   851 RoCktNet IEEE paper circuits
│
├── circuit_collection/                # 989 circuits organized by status
│   ├── circuit_index.json             #   Master index (type, category, status)
│   ├── pass/                          #   652 passing circuits
│   │   ├── baker/                     #     139
│   │   └── rocktnet/                  #     513
│   └── fail/                          #   337 failing circuits
│       ├── s1_syntax/                 #     208 (ngspice parse errors)
│       ├── s2_convergence/            #       6 (no convergence)
│       └── s3_sanity/                 #     123 (incorrect measurements)
│
├── # ── Extraction Results ──
├── extracted_metrics/                 # 252 Baker extraction JSONs
├── extracted_metrics_rocktnet/        # 754 RoCktNet extraction JSONs
├── verification_results/              # Summary JSONs + classification
│   ├── verify_and_repair_baker.json
│   ├── verify_and_repair_rocktnet.json
│   └── circuit_classification.json
│
├── # ── Benchmark Tasks ──
├── benchmark/                         # AMS-ReasonBench
│   ├── task1_spec_generation.json
│   ├── task2_testbench_generation.json
│   ├── task3_target_spec_prediction.json
│   ├── task4_sizing_optimization.json
│   └── task5_full_design.json
│
├── baker_circuit_specs.json           # Per-circuit spec templates
├── needs_fix/                         # 163 circuits needing work
└── docs/
    └── index.html                     # GitHub Pages dashboard
```

## Sources

| Source | Circuits | Description |
|--------|----------|-------------|
| **Baker Textbook** | 246 | From R. Jacob Baker's *CMOS: Circuit Design, Layout, and Simulation* (3rd/4th Ed.) |
| **RoCktNet** | 851 | From IEEE paper schematics via [RoCktNet](https://github.com/xz-group/RoCktNet/tree/master), converted to sky130 |

## Requirements

| Dependency | Version | Notes |
|---|---|---|
| **ngspice** | >= 38 | Tested with ngspice-41 |
| **SkyWater SKY130 PDK** | sky130_fd_pr | Combined models library |
| **Python** | >= 3.7 | Standard library only for simulation |
| **Gemini API** | gemini-3.1-pro | For extraction and repair (Stages 1, 3, 4) |

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
