* High-Frequency CML Clock Divider Testbench
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

* DUT Params
.param W_xm1=5.0 L_xm1=0.5
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
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5

* DUT Netlist
XM1 N3 N9 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 LABEL_NET_0 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N7 LABEL_NET_1 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N11 LABEL_NET_2 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N11 LABEL_NET_3 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 LABEL_NET_4 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N12 LABEL_NET_5 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N11 LABEL_NET_6 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N9 LABEL_NET_7 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N6 LABEL_NET_8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N8 LABEL_NET_9 GND GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}

* Testbench Wiring & Sources
V_VDD VDD 0 1.8

* Bias for tails
V_L8 LABEL_NET_8 0 1.8
V_L9 LABEL_NET_9 0 1.8

* Clock Inputs (34 GHz)
V_L0 LABEL_NET_0 0 dc 1.3 sin(1.3 0.5 34G 0 0 0)
V_L1 LABEL_NET_1 0 dc 1.3 sin(1.3 0.5 34G 0 0 180)

* Mixer LO inputs (Feedback from Amp 2)
V_L3 LABEL_NET_3 N3 0
V_L5 LABEL_NET_5 N4 0

* Amp 1 inputs (From Mixer)
V_L7 LABEL_NET_7 N11 0
V_L4 LABEL_NET_4 N12 0

* Cascodes for Mixer (Turned off to balance DC offset)
V_L2 LABEL_NET_2 0 0
V_L6 LABEL_NET_6 0 0

* Fix for XM9 (tail of buffer) which has gate tied to GND in extracted netlist
I_tail3 N1 0 2m

* Load Resistors (Pull-ups to VDD)
R1 N11 VDD 500
R2 N12 VDD 500
R3 N9 VDD 500
R4 N0 VDD 500
R5 N3 VDD 500
R6 N4 VDD 500

* Differential signals for measurement
B_in_diff in_diff 0 V=v(LABEL_NET_0)-v(LABEL_NET_1)
B_out_diff out_diff 0 V=v(N3)-v(N4)

* Initial condition to kickstart oscillation
.ic v(N3)=1.8 v(N4)=0.8

* Control Block
.control
  tran 1p 10n
  
  * Power Measurement
  meas tran avg_current avg i(V_VDD) from=6n to=10n
  let power_consumption = -avg_current * 1.8
  
  * Input frequency
  meas tran t_in_start trig v(in_diff) val=0 rise=1 td=6n
  meas tran t_in_end trig v(in_diff) val=0 rise=21 td=6n
  let operating_frequency = 20 / (t_in_end - t_in_start)
  
  * Output frequency
  meas tran t_out_start trig v(out_diff) val=0 rise=1 td=6n
  meas tran t_out_end trig v(out_diff) val=0 rise=21 td=6n
  let f_out = 20 / (t_out_end - t_out_start)
  
  * Divide Ratio
  let divide_ratio = operating_frequency / f_out
  
  * Output swing
  meas tran v_max max v(N3) from=6n to=10n
  meas tran v_min min v(N3) from=6n to=10n
  let output_swing = v_max - v_min
  
  print operating_frequency power_consumption divide_ratio output_swing
  
  quit
.endc
.end