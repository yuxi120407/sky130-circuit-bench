* UWB LNA Core Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm1=5.0 L_xm1=0.5

* DUT
XM2 N0 VDD N3 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N6 VB2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VDD N0 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM1 N3 N4 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* Biasing and Sources
VVDD VDD 0 1.8
VVB2 VB2 0 1.0
VIN N4 0 DC 0.65 AC 1 SIN(0.65 0.01 100MEG 0 0)
VN5 N5 0 0
RL N0 VDD 2k
CL N6 0 50f

.control
  * DC Operating Point
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  * AC Analysis
  ac dec 50 10k 100G
  let gain_db = db(v(N6))
  meas ac voltage_gain MAX gain_db
  meas ac bandwidth_3db when gain_db='voltage_gain - 3' fall=1
  print voltage_gain
  print bandwidth_3db

  * Noise Analysis
  noise v(N6) VIN dec 50 10k 100G
  setplot noise1
  let nf_val = 10 * log10(1 + inoise_spectrum / 8.28e-19)
  meas noise noise_figure MIN nf_val
  print noise_figure

  quit
.endc
.end