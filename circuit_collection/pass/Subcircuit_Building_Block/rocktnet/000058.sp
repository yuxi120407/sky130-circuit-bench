* Testbench for Extracted Circuit
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* DUT
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5

XM1 N1 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 LABEL_NET_1 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 LABEL_NET_2 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 N1 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N4 N1 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N4 N1 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}

* Sources
VVDD VDD 0 dc 1.8
V_N2 N2 VDD dc 0
V_N4 N4 VDD dc 0

VLABEL_NET_1 LABEL_NET_1 0 dc 0.9 ac 1 sin(0.9 0.1 100Meg)
VLABEL_NET_2 LABEL_NET_2 0 dc 0.9

.control
  * DC Operating Point
  op
  let dc_power = -i(VVDD) * 1.8
  print dc_power
  print v(N1) v(N0)

  * AC Analysis
  ac dec 20 1Meg 10G
  let gain_db = vdb(N1)
  meas ac dc_gain find gain_db at=1Meg
  meas ac bw_3db when gain_db=(dc_gain-3) fall=1

  * Transient Analysis
  tran 100p 50n
  meas tran vout_pp pp v(N1)
  meas tran vout_max max v(N1)
  meas tran vout_min min v(N1)
  
  quit
.endc
.end