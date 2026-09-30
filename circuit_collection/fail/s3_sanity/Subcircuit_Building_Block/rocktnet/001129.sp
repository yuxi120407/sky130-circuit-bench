* Testbench for Supply-Noise-Insensitive V-to-I Converter

.param W_xm8=5.0 L_xm8=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm13=5.0 L_xm13=0.5

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Power supply
VVDD VDD 0 dc 1.8 ac 0

* Inputs
VVP1 VP1 0 dc 0.9 ac 1 pulse(0.4 1.4 1n 100p 100p 5n 10n)
VVN1 VN1 0 dc 0.9

* Biases for floating/mirror nodes
I_N1 N1 0 10u
I_N5 N5 0 10u
I_N3 VDD N3 10u

* Output current measurement load (AC short, DC open)
C_meas ICO_CONTROL_CURRENT AC_GND 1
V_meas AC_GND 0 dc 0 ac 0

* DUT
XM8 N4 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM12 N3 VN1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM3 ICO_CONTROL_CURRENT N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 ICO_CONTROL_CURRENT ICO_CONTROL_CURRENT GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 GND N3 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 ICO_CONTROL_CURRENT N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N4 N3 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM1 ICO_CONTROL_CURRENT N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM9 N5 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N0 VP1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 VDD N3 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM2 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM13 N5 N3 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}

.control
  * 1. DC Sweep & Power
  dc VVP1 0.9 0.9 1
  let pwr = -i(VVDD) * 1.8
  meas dc pwr_meas max pwr

  * 2. AC Analysis for Gain and Bandwidth
  ac dec 10 1 10000G
  let gain_db = db(i(V_meas))
  meas ac dc_gain_meas find gain_db at=1
  meas ac gain_1mhz_meas find gain_db at=1Meg
  
  let target_gain_vec = $&dc_gain_meas - 3
  set target_gain = $&target_gain_vec
  meas ac bw_meas when gain_db=$target_gain fall=1

  * 3. AC Analysis for PSRR
  alter VVP1 ac=0
  alter VVDD ac=1
  ac dec 10 1 10000G
  let supply_gain_db = db(i(V_meas))
  meas ac supply_gain_1mhz_meas find supply_gain_db at=1Meg
  
  * Define all metrics in the current plot so print works
  let power_consumption = $&pwr_meas
  let dc_gain = $&dc_gain_meas
  let bandwidth = $&bw_meas
  let psrr = $&gain_1mhz_meas - $&supply_gain_1mhz_meas

  print power_consumption dc_gain bandwidth psrr
  quit
.endc
.end