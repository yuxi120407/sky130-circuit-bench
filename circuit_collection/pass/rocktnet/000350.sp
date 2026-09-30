* Op-Amp Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm12=10.0 L_xm12=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm1=40.0 L_xm1=0.5
.param W_xmc=5.0 L_xmc=0.5

* DUT
XM12 N4 N6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM2 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N6 VIN_PLUS N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N6 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 VOUT N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N2 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N2 VIN_MINUS N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM1 GND N4 VOUT VOUT sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
* MOScap compensation
XMC N9 N0 N6 GND sky130_fd_pr__nfet_01v8 l={L_xmc} w={W_xmc}

* Prevent floating node error on XMC drain
R_N9 N9 0 1G

* Biasing and Supplies
VVDD VDD 0 1.8
Ibias N1 0 20u
Vtie N7 N1 0

* Load
CL VOUT 0 1p

* Feedback network for DC operating point and AC open-loop
* Vshift bridges the gap between input CM (0.6V) and output CM (1.2V)
Vshift VOUT VFB DC 0.6
L1 VFB VIN_MINUS 1G
C1 0 VIN_MINUS 1G

* Input source
VVIN_PLUS VIN_PLUS 0 DC 0.6 AC 1 PULSE(0.5 0.7 10n 1n 1n 40n 100n)

.control
  * 1. DC Operating Point
  op
  let dc_power = -i(VVDD) * 1.8
  print dc_power

  * 2. AC Analysis (Open Loop)
  ac dec 100 1 10G
  let vout_ph_deg = cph(v(vout)) * 180 / 3.141592653589793
  meas ac dc_gain find vdb(vout) at=10
  meas ac unity_gain_frequency when vdb(vout)=0 fall=1
  meas ac phase_at_ugf find vout_ph_deg when vdb(vout)=0 fall=1
  let phase_margin = 180 + phase_at_ugf
  print dc_gain
  print unity_gain_frequency
  print phase_margin

  * 3. Transient Analysis (Closed Loop)
  * Alter L and C to close the loop for transient
  alter L1 1p
  alter C1 1a
  tran 0.1n 100n
  
  meas tran t_rise trig v(vout) val=1.12 rise=1 targ v(vout) val=1.28 rise=1
  meas tran t_fall trig v(vout) val=1.28 fall=1 targ v(vout) val=1.12 fall=1
  
  let sr_rise = 0.16 / t_rise / 1e6
  let sr_fall = 0.16 / t_fall / 1e6
  let slew_rate = (sr_rise + sr_fall) / 2
  
  print slew_rate
  quit
.endc
.end