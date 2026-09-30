* Testbench for Dynamic DCVSL Gate
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
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

* DUT
XM1 N1 LABEL_NET_0 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 LABEL_NET_1 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N6 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 LABEL_NET_2 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 LABEL_NET_3 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 LABEL_NET_4 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N4 LABEL_NET_5 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 LABEL_NET_6 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N4 LABEL_NET_7 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N5 LABEL_NET_8 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N2 LABEL_NET_9 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N0 LABEL_NET_10 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}

* Power Supply
VVDD VDD 0 1.8

* Clock / Request Signal (250MHz)
VCLK CLK 0 PULSE(0 1.8 1n 50p 50p 1.9n 4n)

* Connect all precharge/evaluate control nodes to CLK
V_N7 N7 CLK 0
V_L8 LABEL_NET_8 CLK 0
V_L4 LABEL_NET_4 CLK 0
V_L7 LABEL_NET_7 CLK 0
V_L10 LABEL_NET_10 CLK 0

* Data Inputs (Return-to-Zero signaling)
V_L0 LABEL_NET_0 0 0
V_L1 LABEL_NET_1 0 0
* Toggle C (LABEL_NET_2) to evaluate N2 during cycle 1
V_L2 LABEL_NET_2 0 PWL(0 0 0.8n 0 0.9n 1.8 2.8n 1.8 2.9n 0)
V_L3 LABEL_NET_3 0 0
* Toggle E (LABEL_NET_5) to evaluate N4 during cycle 2
V_L5 LABEL_NET_5 0 PWL(0 0 4.8n 0 4.9n 1.8 6.8n 1.8 6.9n 0)
V_L6 LABEL_NET_6 0 0
V_L9 LABEL_NET_9 0 0

* Load Capacitors
C_N2 N2 0 10f
C_N4 N4 0 10f

.control
tran 10p 8n

* Measure N2 delays (Cycle 1)
meas tran t_eval_n2 trig v(CLK) val=0.9 rise=1 targ v(N2) val=0.9 fall=1
meas tran t_pre_n2 trig v(CLK) val=0.9 fall=1 targ v(N2) val=0.9 rise=1

* Measure N4 delays (Cycle 2)
meas tran t_eval_n4 trig v(CLK) val=0.9 rise=2 targ v(N4) val=0.9 fall=1
meas tran t_pre_n4 trig v(CLK) val=0.9 fall=2 targ v(N4) val=0.9 rise=1

* Measure Average Power
meas tran avg_current avg i(VVDD) from=0 to=8n
let avg_power = -avg_current * 1.8
print avg_power

quit
.endc
.end
