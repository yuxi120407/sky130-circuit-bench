* Dynamic Comparator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5 W_xm1=5.0
.param L_xm2=0.5 W_xm2=5.0
.param L_xm3=0.5 W_xm3=5.0
.param L_xm4=0.5 W_xm4=5.0
.param L_xm5=0.5 W_xm5=5.0
.param L_xm6=0.5 W_xm6=5.0
.param L_xm7=0.5 W_xm7=5.0
.param L_xm8=0.5 W_xm8=5.0
.param L_xm9=0.5 W_xm9=5.0
.param L_xm10=0.5 W_xm10=5.0
.param L_xm11=0.5 W_xm11=5.0
.param L_xm12=0.5 W_xm12=5.0

* DUT
XM1 N2 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 LABEL_NET_2 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N5 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N2 LABEL_NET_3 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N1 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N3 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}

* Sources
VVDD VDD 0 1.8
Ibias N3 0 20u

* Clock: 10 MHz -> 100 ns period. Active low for evaluation.
VCLK_0 LABEL_NET_0 0 PULSE(1.8 0 5n 1n 1n 43n 100n)
VCLK_1 LABEL_NET_1 0 PULSE(1.8 0 5n 1n 1n 43n 100n)

* Inputs: Common mode 0.2V, diff sweeps from -40mV to +40mV
VINP LABEL_NET_2 0 PWL(0 0.18 10u 0.22)
VINN LABEL_NET_3 0 PWL(0 0.22 10u 0.18)

* Load Capacitance
C1 N1 0 10f
C2 N4 0 10f

.control
  tran 0.1n 10u
  
  * Decision threshold
  meas tran v_inp_flip find v(LABEL_NET_2) when v(N4)=0.9 fall=1
  meas tran v_inn_flip find v(LABEL_NET_3) when v(N4)=0.9 fall=1
  let decision_threshold = v_inp_flip - v_inn_flip
  print decision_threshold
  
  * Propagation delay
  meas tran propagation_delay trig v(LABEL_NET_0) val=0.9 fall=1 td=9u targ v(N4) val=0.9 fall=1 td=9u
  print propagation_delay
  
  * Average power
  meas tran pwr_avg avg i(VVDD) from=0 to=10u
  let average_power = -pwr_avg * 1.8
  print average_power
  
  quit
.endc
.end