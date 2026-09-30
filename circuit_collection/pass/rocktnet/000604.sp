* Testbench for Bulk Input Boost Circuit
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

XM1 N3 LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 GND LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 LABEL_NET_2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 N1 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 GND VDD GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N2 LABEL_NET_3 GND N0 sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 N3 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N0 N0 GND N0 sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N0 LABEL_NET_4 N0 N0 sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N0 LABEL_NET_5 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N0 LABEL_NET_6 N0 N0 sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}

VVDD VDD 0 1.8
V_L0 LABEL_NET_0 0 0
V_L1 LABEL_NET_1 0 0
V_L3 LABEL_NET_3 0 PULSE(0 1.8 1n 50p 50p 2n 4n)

* CLK: Precharge (0) and Evaluate (1.8)
V_CLK LABEL_NET_2 0 PULSE(0 1.8 1n 50p 50p 2n 4n)

* Boost inputs: Active during second cycle
V_BOOST4 LABEL_NET_4 0 PULSE(0 1.8 4.9n 50p 50p 2n 8n)
V_BOOST5 LABEL_NET_5 0 PULSE(0 1.8 4.9n 50p 50p 2n 8n)
V_BOOST6 LABEL_NET_6 0 PULSE(0 1.8 4.9n 50p 50p 2n 8n)

.control
tran 10p 8n
meas tran delay_unboosted trig v(LABEL_NET_2) val=0.9 rise=1 targ v(N1) val=0.9 fall=1
meas tran delay_boosted trig v(LABEL_NET_2) val=0.9 rise=2 targ v(N1) val=0.9 fall=2
meas tran vbulk_max max v(N0) from=4.9n to=7n
let power = -i(VVDD) * 1.8
meas tran avg_power avg power from=0 to=8n
print delay_unboosted delay_boosted vbulk_max avg_power
quit
.endc
.end