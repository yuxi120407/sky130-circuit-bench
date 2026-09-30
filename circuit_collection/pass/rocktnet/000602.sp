* Testbench for Bulk Input Scheme Circuit
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

VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 PULSE(1.8 0 200p 10p 10p 200p 1n)
VLABEL_NET_1 LABEL_NET_1 0 DC 0
VLABEL_NET_3 LABEL_NET_3 0 DC 1.8
VN0 N0 0 PULSE(1.8 0 200p 10p 10p 300p 1n)
VLABEL_NET_4 LABEL_NET_4 0 PULSE(0 1.8 600p 1p 1p 100p 1n)
VLABEL_NET_5 LABEL_NET_5 0 PULSE(0 1.8 600p 1p 1p 100p 1n)
VLABEL_NET_6 LABEL_NET_6 0 PULSE(0 1.8 600p 1p 1p 100p 1n)

XM1 N2 LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 GND LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 LABEL_NET_2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 N0 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 LABEL_NET_3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 VDD GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 N2 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 VDD GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N1 LABEL_NET_4 N1 N1 sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N1 N1 GND N1 sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N1 LABEL_NET_5 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N1 LABEL_NET_6 N1 N1 sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}

.control
tran 1p 4n

meas tran v_max_n2 max v(N2)
meas tran v_min_n2 min v(N2)
meas tran v_max_n1 max v(N1)
meas tran v_min_n1 min v(N1)
meas tran v_max_n0 max v(N0)
meas tran v_min_n0 min v(N0)

let boost_voltage_swing = v_max_n1 - v_min_n1
print boost_voltage_swing

meas tran t_precharge trig v(LABEL_NET_0) val=0.9 fall=1 targ v(N2) val=1.6 rise=1
meas tran t_evaluate trig v(N0) val=0.9 rise=1 targ v(N2) val=0.2 fall=1
let operating_frequency = 1 / (t_precharge + t_evaluate)
print operating_frequency

meas tran avg_current avg i(VVDD)
let power_consumption = -avg_current * 1.8
print power_consumption

quit
.endc
.end