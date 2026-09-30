* Fully Differential Folded Cascode OTA Testbench

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

* DUT
XM1 N1 LABEL_NET_0 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N5 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N6 LABEL_NET_2 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N6 LABEL_NET_3 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 N7 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 N7 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N8 LABEL_NET_4 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 LABEL_NET_5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N4 LABEL_NET_6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N0 LABEL_NET_7 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N8 LABEL_NET_8 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}

* Fix floating nodes (N2 is PMOS source, N7 is PMOS bias)
V_N2 N2 0 1.8
V_N7 N7 0 1.1

* Power supply
VVDD VDD 0 1.8

* Bias voltages
VLABEL_NET_2 LABEL_NET_2 0 1.0
VLABEL_NET_3 LABEL_NET_3 0 0.8
VLABEL_NET_4 LABEL_NET_4 0 0.8
VLABEL_NET_5 LABEL_NET_5 0 0.6
VLABEL_NET_8 LABEL_NET_8 0 1.0

* Ideal CMFB to set output common-mode to 0.9V
B_LABEL_NET_1 LABEL_NET_1 0 V='0.6 + ((v(N6)+v(N8))/2 - 0.9)*10'
B_LABEL_NET_6 LABEL_NET_6 0 V='0.6 + ((v(N6)+v(N8))/2 - 0.9)*10'

* Input signals (AC for frequency response, PULSE for slew rate)
V_INP LABEL_NET_0 0 DC 0.9 AC 0.5 PULSE(0.8 1.0 1n 10p 10p 20n 40n)
V_INM LABEL_NET_7 0 DC 0.9 AC -0.5 PULSE(1.0 0.8 1n 10p 10p 20n 40n)

* Load capacitance (1pF as reported in paper)
CL1 N6 0 1p
CL2 N8 0 1p

* Differential output for measurement
E_diff OUT_DIFF 0 vol='v(N8) - v(N6)'

.control
  * DC Operating Point
  op
  let power = -i(VVDD) * 1.8
  print power

  * AC Analysis
  ac dec 100 1k 10G
  let gain_db = vdb(OUT_DIFF)
  let phase = 180/PI * cph(v(OUT_DIFF))
  
  meas ac dc_gain find gain_db at=1k
  meas ac gbw when gain_db=0 fall=1
  meas ac phase_margin find phase when gain_db=0 fall=1

  * Transient Analysis
  tran 10p 40n
  meas tran t_rise trig v(OUT_DIFF) val=-0.5 rise=1 targ v(OUT_DIFF) val=0.5 rise=1
  let sr_rise_V_us = 1.0 / t_rise / 1e6
  print sr_rise_V_us
  
  quit
.endc
.end