* Testbench for Nauta Transconductor

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

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

XM1 N0 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 N0 LABEL_NET_0 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N0 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N1 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}

* Sources
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9

* Input signals
VCM VCM 0 0.9
Vinp N2 VCM dc 0 ac 0.5 sin(0 0.05 1Meg)
Vinn N3 VCM dc 0 ac -0.5 sin(0 -0.05 1Meg)

* Load capacitors
C1 N0 0 1p
C2 N1 0 1p

* Differential output
E1 out_diff 0 N0 N1 1

.control
  * DC Operating Point
  op
  let power = -i(VVDD) * 1.8
  print power
  let vout_cm = (v(N0) + v(N1)) / 2
  print vout_cm
  print v(N0) v(N1)

  * AC Analysis
  ac dec 100 1 10G
  let gain_db = vdb(out_diff)
  meas ac dc_gain_db find gain_db at=10
  let target_gain = dc_gain_db - 3
  meas ac bw when gain_db=target_gain fall=1

  * Transient Analysis
  tran 1n 5u
  meas tran vout_diff_pp pp v(out_diff)
  
  quit
.endc
.end