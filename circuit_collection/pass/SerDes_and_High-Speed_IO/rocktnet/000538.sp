* 4-PAM Transmitter Driver Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.15
.param L_xm10=0.15
.param L_xm11=0.15
.param L_xm12=0.15
.param L_xm13=0.15
.param L_xm14=0.15
.param L_xm2=0.15
.param L_xm3=0.15
.param L_xm4=0.15
.param L_xm5=0.15
.param L_xm6=0.15
.param L_xm7=0.15
.param L_xm8=0.15
.param L_xm9=0.15

.param W_xm1=5.0
.param W_xm2=25.0
.param W_xm3=5.0
.param W_xm4=25.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm9=5.0
.param W_xm10=5.0
.param W_xm11=25.0
.param W_xm12=5.0
.param W_xm13=5.0
.param W_xm14=5.0

* DUT
XM1 N1 LABEL_NET_0 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N6 LABEL_NET_1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N5 LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 LABEL_NET_3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 LABEL_NET_5 LABEL_NET_4 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 LABEL_NET_6 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 LABEL_NET_8 LABEL_NET_7 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N4 LABEL_NET_9 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 LABEL_NET_10 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N7 LABEL_NET_11 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N3 LABEL_NET_12 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N4 LABEL_NET_13 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N6 LABEL_NET_14 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 N7 LABEL_NET_15 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}

* 50-Ohm Output Terminations (Standard for high-speed CML)
R1 N3 VDD 50
R2 N6 VDD 50
R3 N4 VDD 50
R4 N7 VDD 50

* Power Supplies
VVDD VDD 0 1.8
V_L4 LABEL_NET_4 0 1.8
V_L7 LABEL_NET_7 0 1.8

* Tail Current Biases
V_L2 LABEL_NET_2 0 0
V_L3 LABEL_NET_3 0 1.8
V_L11 LABEL_NET_11 0 0

* PMOS Biases / Switches (Set to OFF for testing basic CML)
V_L5 LABEL_NET_5 0 1.8
V_L8 LABEL_NET_8 0 1.8
V_L0 LABEL_NET_0 0 1.8
V_L6 LABEL_NET_6 0 1.8

* High-Speed Differential Inputs (10 Gb/s -> 200ps period)
V_L1 LABEL_NET_1 0 PULSE(0.6 1.2 10p 20p 20p 80p 200p)
V_L12 LABEL_NET_12 0 PULSE(1.2 0.6 10p 20p 20p 80p 200p)

* Look-ahead / Control Signals (Static for basic characterization)
V_L9 LABEL_NET_9 0 1.8
V_L10 LABEL_NET_10 0 1.8
V_L13 LABEL_NET_13 0 0
V_L14 LABEL_NET_14 0 1.8
V_L15 LABEL_NET_15 0 1.8

.control
tran 2p 2n

* Measure Power
let power = -i(VVDD)*1.8
meas tran power_consumption avg power from=0 to=2n
print power_consumption

* Measure Output Swing
meas tran v_max max v(N6) from=1n to=2n
meas tran v_min min v(N6) from=1n to=2n
let output_swing = v_max - v_min
print output_swing

* Measure Propagation Delay (Input crossing 0.9V to Output crossing ~1.7V)
meas tran propagation_delay trig v(LABEL_NET_1) val=0.9 rise=4 targ v(N6) val=1.7 fall=4
print propagation_delay

quit
.endc
.end