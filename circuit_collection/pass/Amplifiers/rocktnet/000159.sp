* Testbench for CMOS Transconductance Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm17=0.5
.param L_xm18=0.5
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
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm18=5.0 L_xm18=0.5

XM1 N14 N14 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N7 N4 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N7 LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N6 LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 N3 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N9 N14 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N5 LABEL_NET_2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N8 LABEL_NET_3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N5 N3 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N2 N12 N8 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N4 N4 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N2 N11 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 N4 N12 N8 VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 N2 N4 N9 VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM15 N3 N11 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}
XM16 N2 N3 N9 VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}
XM17 N4 N3 N9 VDD sky130_fd_pr__pfet_01v8 l={L_xm17} w={W_xm17}
XM18 N3 N4 N9 VDD sky130_fd_pr__pfet_01v8 l={L_xm18} w={W_xm18}

* Ground N2
VN2 N2 0 0

* Power and Bias
VVDD VDD 0 1.8
B_CMFB_0 LABEL_NET_0 0 V='max(0, min(1.8, 0.9 + 10*(v(N5)+v(N7)-1.8)))'
B_CMFB_2 LABEL_NET_2 0 V='max(0, min(1.8, 0.9 + 10*(v(N5)+v(N7)-1.8)))'
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_3 LABEL_NET_3 0 0.9
Ibias N14 0 1u

* Input Common Mode and Differential
Vincm INCM 0 DC 0.9
Vind IN_DIFF 0 DC 0 AC 1
E1 N11 INCM IN_DIFF 0 0.5
E2 N12 INCM IN_DIFF 0 -0.5

* Load Capacitance (from paper)
C1 N7 0 180p
C2 N5 0 180p

* Differential Output
Eout OUT_DIFF 0 N5 N7 1

.control
  * DC Operating Point & Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * AC Analysis for Gain, GBW, and Phase Margin
  ac dec 20 0.001 1Meg
  let gain_db = db(v(OUT_DIFF))
  let phase_margin = 180 + 180/PI * ph(v(OUT_DIFF))
  
  meas ac dc_gain MAX gain_db
  meas ac gbw when gain_db=0 fall=1
  meas ac pm find phase_margin when gain_db=0 fall=1
  print dc_gain gbw pm

  * DC Sweep for Output Swing
  dc Vind -0.5 0.5 0.01
  meas dc vout_max max v(OUT_DIFF)
  meas dc vout_min min v(OUT_DIFF)
  meas dc out_swing param='vout_max - vout_min'
  print out_swing
  
  quit
.endc
.end