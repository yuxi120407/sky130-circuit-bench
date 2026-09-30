* Testbench for Folded Cascode OTA

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

* DUT
XM1 N6 LABEL_NET_0 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 LABEL_NET_1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N6 LABEL_NET_2 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LABEL_NET_3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 LABEL_NET_4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 LABEL_NET_5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N4 LABEL_NET_6 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 LABEL_NET_7 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N2 LABEL_NET_8 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N1 LABEL_NET_9 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N5 LABEL_NET_10 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}

* Biases
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.8
VLABEL_NET_1 LABEL_NET_1 0 1.0
VLABEL_NET_2 LABEL_NET_2 0 1.0
VLABEL_NET_4 LABEL_NET_4 0 1.0
VLABEL_NET_6 LABEL_NET_6 0 0.8
VLABEL_NET_9 LABEL_NET_9 0 1.0
VLABEL_NET_10 LABEL_NET_10 0 1.0

* Ideal CMFB for NMOS current sinks (stabilizes output CM to 0.9V)
B_BIAS_N LABEL_NET_3 0 V=0.62+(v(N4)+v(N6)-1.8)*10
B_BIAS_N2 LABEL_NET_5 0 V=0.62+(v(N4)+v(N6)-1.8)*10

* Inputs (AC for frequency response, Pulse for slew rate)
V_INM LABEL_NET_7 0 DC 0.9 AC -0.5 PULSE(0.9 0.4 10n 0.1n 0.1n 2u 4u)
V_INP LABEL_NET_8 0 DC 0.9 AC 0.5 PULSE(0.9 1.4 10n 0.1n 0.1n 2u 4u)

* Load Capacitors
CL1 N4 0 1p
CL2 N6 0 1p

.control
  * DC Operating Point & Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * AC Analysis
  ac dec 100 1 1G
  let vout_diff = v(N6) - v(N4)
  let gain_db = db(vout_diff)
  let phase = 180/PI * ph(vout_diff)
  let pm_vec = 180 + phase
  
  meas ac dc_gain find gain_db at=10
  meas ac gbw when gain_db=0 fall=1
  meas ac phase_margin find pm_vec when gain_db=0 fall=1
  print dc_gain gbw phase_margin

  * Transient Analysis for Slew Rate
  tran 1n 2u
  let vout_diff_tran = v(N6) - v(N4)
  meas tran t_rise trig vout_diff_tran val=0.1 rise=1 targ vout_diff_tran val=0.6 rise=1
  let slew_rate = 0.5 / $&t_rise / 1e6
  print slew_rate
  
  quit
.endc
.end