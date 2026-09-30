* Testbench for Video Line Driver
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.15
.param L_xm10=0.15
.param L_xm2=0.15
.param L_xm3=0.15
.param L_xm4=0.15
.param L_xm5=0.15
.param L_xm6=0.15
.param L_xm7=0.15
.param L_xm8=0.15
.param L_xm9=0.15

.param W_xm1=500.0
.param W_xm2=500.0
.param W_xm3=100.0
.param W_xm4=500.0
.param W_xm5=100.0
.param W_xm6=100.0
.param W_xm7=500.0
.param W_xm8=100.0
.param W_xm9=500.0
.param W_xm10=100.0

XM1 N7 LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N4 N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VDD N0 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 GND N5 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N4 LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 VDD N5 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N6 LABEL_NET_3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}

VVDD VDD 0 1.8

IBIAS_P N1 0 100u
IBIAS_N VDD N2 100u

VLABEL_NET_0 LABEL_NET_0 N7 0
VLABEL_NET_1 LABEL_NET_1 N1 0
VLABEL_NET_2 LABEL_NET_2 N2 0
VLABEL_NET_3 LABEL_NET_3 N2 0

* Input signal at N5
VIN N5 0 DC 0.9 AC 1 SIN(0.9 0.2 5Meg)

* 75-ohm loads for video line driver
R1 N6 0 75
R2 N3 0 75

.control
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  ac dec 20 10k 100G
  let gain_n6_db = db(v(N6))
  let gain_n3_db = db(v(N3))
  meas ac voltage_gain_non_inverting find gain_n6_db at=100k
  meas ac voltage_gain_inverting find gain_n3_db at=100k
  print voltage_gain_non_inverting
  print voltage_gain_inverting
  
  let target_n6 = voltage_gain_non_inverting - 3
  meas ac bandwidth when gain_n6_db="$&target_n6" fall=1
  print bandwidth

  tran 1n 1u
  meas tran v_max_n6 max v(N6) from=0.5u to=1u
  meas tran v_min_n6 min v(N6) from=0.5u to=1u
  let output_swing = v_max_n6 - v_min_n6
  print output_swing
  
  quit
.endc
.end