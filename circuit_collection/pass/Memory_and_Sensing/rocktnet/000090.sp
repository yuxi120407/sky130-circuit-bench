* Conditional-Capture Flip-Flop Latch Core
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

* Parameters
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

* DUT
XM1 N3 N0 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 LABEL_NET_2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 N1 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 LABEL_NET_3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 N1 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

* Supplies and Node Tie-offs
VVDD VDD 0 1.8
V_N2 N2 VDD 0
V_N3 N3 VDD 0
V_N4 N4 0 0
V_N5 N5 0 0

* Inputs for Transient Analysis (200 MHz)
V_L0 LABEL_NET_0 0 PULSE(0 1.8 1n 50p 50p 1n 5n)
V_L1 LABEL_NET_1 0 PULSE(1.8 0 1n 50p 50p 1n 5n)
V_L3 LABEL_NET_3 0 PULSE(0 1.8 3.5n 50p 50p 1n 5n)
V_L2 LABEL_NET_2 0 PULSE(1.8 0 3.5n 50p 50p 1n 5n)

* Initial Conditions
.ic v(N0)=0 v(N1)=1.8
.nodeset v(N0)=0 v(N1)=1.8

.control
  * Transient Analysis
  tran 10p 15n
  meas tran t_delay_set trig v(LABEL_NET_0) val=0.9 rise=1 targ v(N0) val=0.9 rise=1
  meas tran t_delay_reset trig v(LABEL_NET_3) val=0.9 rise=1 targ v(N1) val=0.9 rise=1
  meas tran i_avg avg i(VVDD)
  
  * DC Analysis for Trip Point
  dc V_L0 0 1.8 0.01
  meas dc trip_point when v(N0)=0.9 rise=1
  
  quit
.endc
.end