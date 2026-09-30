* FMCML Gate Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.15
.param L_xm10=0.15
.param L_xm11=0.15
.param L_xm2=0.15
.param L_xm3=0.15
.param L_xm4=0.15
.param L_xm5=0.15
.param L_xm6=0.15
.param L_xm7=0.15
.param L_xm8=0.15
.param L_xm9=0.15

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm9=5.0
.param W_xm10=5.0
.param W_xm11=5.0

* DUT
XM1 N1 GND VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N6 GND N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 GND N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 GND VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N5 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N5 LABEL_NET_0 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N5 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N3 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N2 LABEL_NET_2 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}

* Prevent floating node errors
R_N0 N0 0 1G
R_N6 N6 0 1G

* Differential output for measurement
E1 diff_out 0 N2 N5 1.0

* Sources
VVDD VDD 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_0 LABEL_NET_0 0 0.9 AC 0.5 SIN(0.9 0.2 1G)
VLABEL_NET_2 LABEL_NET_2 0 0.9 AC -0.5 SIN(0.9 -0.2 1G)

.control
  * 1. DC Operating Point & Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. AC Analysis for Bandwidth
  ac dec 10 1Meg 100G
  let gain_db = db(v(diff_out))
  meas ac max_gain max gain_db
  let gain_3db = max_gain - 3
  meas ac bw when gain_db=gain_3db fall=1
  print bw

  * 3. Transient Analysis for Swing and Delay
  tran 10p 5n
  meas tran v_max max v(diff_out)
  meas tran v_min min v(diff_out)
  let v_swing = v_max - v_min
  print v_swing
  
  * Measure propagation delay
  meas tran delay trig v(LABEL_NET_0) val=0.9 td=2.5n rise=1 targ v(diff_out) val=0 td=2.5n rise=1
  print delay
  
  quit
.endc
.end