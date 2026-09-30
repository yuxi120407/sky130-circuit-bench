* Cascode LNA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

* Parameter definitions from extracted netlist
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

* DUT
XM1 N2 INPUT N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 VDD N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Ground connections
VN0 N0 0 DC 0

* Input Bias Tee and RF Source (50 ohm system)
VINPUT INPUT_SRC 0 DC 0 AC 1 SIN(0 0.01 7G 0 0)
RS INPUT_SRC INPUT_RF 50
CB INPUT_RF INPUT 10p
RBIAS VBIAS INPUT 10k
VBIAS VBIAS 0 DC 0.9

* Output Load (Resistive load for generic gain measurement)
RL VDD N1 2k
CL N1 0 10f

* Power Supply
VVDD VDD 0 DC 1.8

.control
  * 1. DC Operating Point
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  * 2. AC Analysis for Gain and Bandwidth
  ac dec 50 100MEG 20G
  let gain_db = db(v(N1))
  meas ac voltage_gain max gain_db
  meas ac bandwidth when gain_db='voltage_gain-3' fall=1
  print voltage_gain bandwidth

  * 3. Noise Analysis
  * Refers noise to VINPUT. RS thermal noise is included.
  noise v(N1) VINPUT dec 10 1G 10G
  setplot noise1
  * Calculate Noise Figure (NF) in dB
  * Vn_rs = sqrt(4 * k * T * Rs) = sqrt(4 * 1.38e-23 * 300 * 50) = 9.1e-10 V/sqrt(Hz)
  * NF = 20 * log10(inoise_spectrum / Vn_rs)
  let nf_db = 20*log10(inoise_spectrum / 9.1e-10)
  meas noise noise_figure find nf_db at=7G
  print noise_figure

  * 4. Transient Analysis
  tran 5p 2n
  meas tran vout_pp pp v(N1)
.endc
.end