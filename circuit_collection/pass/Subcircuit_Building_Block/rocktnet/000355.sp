* PMOS Current Mirror Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm2_2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm6=0.5

.param W_xm4=5.0 L_xm4=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm2_2=5.0 L_xm2_2=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm6=5.0 L_xm6=0.5

* DUT
XM4 GND N5 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM2 N4 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM2_2 N4 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2_2} w={W_xm2_2}
XM1 N3 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM3 N5 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM6 LABEL_NET_3 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}

* Sources
VVDD VDD 0 1.8
Iref N4 0 10u
V_N3 N3 0 0.9
V_LABEL_NET_3 LABEL_NET_3 0 0.9
R_N5 N5 0 1G

.control
  * 1. Operating Point for Mirror Ratios and Power
  op
  let I_in = 10u
  let I_out_n3 = -i(V_N3)
  let I_out_label = -i(V_LABEL_NET_3)
  let mirror_ratio_n3 = I_out_n3 / I_in
  let mirror_ratio_label = I_out_label / I_in
  
  print I_out_n3 I_out_label
  print mirror_ratio_n3 mirror_ratio_label
  
  let power = -i(VVDD) * 1.8
  print power

  * 2. DC Sweep for Output Resistance
  dc V_N3 0 1.8 0.01
  let I_out = -i(V_N3)
  
  * Measure currents at different voltages to calculate Rout
  meas dc I_0v8 find I_out at=0.8
  meas dc I_1v0 find I_out at=1.0
  let Rout = 0.2 / (I_1v0 - I_0v8)
  print Rout
  
  * Measure current near VDD to observe compliance drop
  meas dc I_1v6 find I_out at=1.6
  meas dc I_1v7 find I_out at=1.7
  
  quit
.endc
.end
