* Derivative Superposition LNA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

* Power Supply and Biases
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.5
VN3 N3 0 1.8

* RF Inputs (Differential 1V AC for easy gain calculation, 20mV for Tran)
VIN_P IN_P 0 DC 0 AC 0.5 SIN(0 10m 2.4G 0 0 0)
VIN_N IN_N 0 DC 0 AC -0.5 SIN(0 10m 2.4G 0 0 180)

* AC Coupling and Gate Biasing for Main Pair (Strong Inversion)
C1 IN_P N1 10p
C2 IN_N N2 10p
R1 VBIAS_MAIN N1 10k
R2 VBIAS_MAIN N2 10k
VBIAS_MAIN VBIAS_MAIN 0 0.9

* AC Coupling and Gate Biasing for Aux Pair (Weak Inversion)
C3 IN_P N4 10p
C4 IN_N N0 10p
R3 VBIAS_AUX N4 10k
R4 VBIAS_AUX N0 10k
VBIAS_AUX VBIAS_AUX 0 0.5

* DUT
XM1 N5 N1 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N7 N2 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VDD N3 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N6 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VDD N3 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N7 N0 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N8 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N5 N4 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

* Load Capacitance
CL1 N5 0 50f
CL2 N7 0 50f

.control
  * 1. DC Operating Point & Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. AC Analysis for Gain and Bandwidth
  ac dec 100 10M 10G
  let vout_diff = v(N5) - v(N7)
  let gain_mag = mag(vout_diff)
  let gain_db = 20 * log10(gain_mag)
  
  meas ac gain_2_4G find gain_db at=2.4G
  meas ac max_gain max gain_db
  
  let gain_3db = max_gain - 3
  meas ac bw_3db when gain_db=gain_3db fall=1
  
  * 3. Transient Analysis
  tran 10p 5n
  let vout_diff_tran = v(N5) - v(N7)
  meas tran vmax max vout_diff_tran
  meas tran vmin min vout_diff_tran
  let vout_ptp = vmax - vmin
  print vout_ptp
  
  quit
.endc
.end