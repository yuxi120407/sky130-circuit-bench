* Testbench for Single-Ended to Differential Converter and Amplifier

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

* DUT
XM1 N1 N2 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N6 N6 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 N7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 LABEL_NET_0 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 N6 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VDD VDD N2 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 LABEL_NET_1 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N2 LABEL_NET_2 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N4 N7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N5 LABEL_NET_4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 VDD VDD N6 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}

* Added Loads for Testing (Missing from extraction)
R1 VDD N1 10k
R2 VDD N0 10k

* Ideal VCVS to measure differential output
E1 out_diff 0 N1 N0 1

* Sources
VVDD VDD 0 1.8
VLABEL_NET_4 LABEL_NET_4 0 0.7
VN7 N7 0 0.7
VLABEL_NET_0 LABEL_NET_0 0 0
VLABEL_NET_1 LABEL_NET_1 0 0
VLABEL_NET_2 LABEL_NET_2 0 1.2 ac 1 sin(1.2 0.01 1.8G)

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

.control
  * DC Operating Point
  op
  print v(N1) v(N0) v(N2) v(N6) v(N5) v(N4)
  let power = -i(VVDD) * 1.8
  print power

  * AC Analysis
  ac dec 100 1M 10G
  let gain_db = vdb(out_diff)
  meas ac max_gain MAX gain_db
  let target_gain = $&max_gain - 3
  meas ac bw_freq when gain_db=target_gain fall=1
  meas ac gain_1_8G find gain_db at=1.8G
  
  let phase_n2 = 180/PI * cph(v(N2))
  let phase_n6 = 180/PI * cph(v(N6))
  let phase_diff = phase_n2 - phase_n6
  meas ac phase_diff_1_8g find phase_diff at=1.8G

  * Transient Analysis
  tran 10p 5n
  meas tran vout_max max v(out_diff)
  meas tran vout_min min v(out_diff)
  let swing = vout_max - vout_min
  print swing
.endc
.end
