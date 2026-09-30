* Testbench for Inverters and Dummy Capacitors
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

XM1 N3 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 N1 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N5 N2 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 N6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N4 LABEL_NET_0 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 LABEL_NET_1 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 LABEL_NET_2 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N5 LABEL_NET_3 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}

* Power and Bias Sources
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_2 LABEL_NET_2 0 0.9
VLABEL_NET_3 LABEL_NET_3 0 0.9
VN1 N1 0 0.9
VN2 N2 0 0.9

* Prevent floating nodes on isolated dummy capacitors
R_N4 N4 0 1G
R_N5 N5 0 1G

* Input Signals
VIN1 N7 0 PULSE(0 1.8 1n 0.1n 0.1n 2n 4n)
VIN2 N6 0 PULSE(0 1.8 1n 0.1n 0.1n 2n 4n)

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.control
* Transient Analysis for Delay
tran 10p 10n
meas tran tpd_fall_1 trig v(N7) val=0.9 rise=1 targ v(N3) val=0.9 fall=1
meas tran tpd_rise_1 trig v(N7) val=0.9 fall=1 targ v(N3) val=0.9 rise=1
meas tran tpd_fall_2 trig v(N6) val=0.9 rise=1 targ v(N0) val=0.9 fall=1
meas tran tpd_rise_2 trig v(N6) val=0.9 fall=1 targ v(N0) val=0.9 rise=1

let avg_tpd_1 = (tpd_fall_1 + tpd_rise_1) / 2
let avg_tpd_2 = (tpd_fall_2 + tpd_rise_2) / 2
print avg_tpd_1 avg_tpd_2

* DC Operating Point for Static Power
op
let static_power = -i(VVDD) * 1.8
print static_power

quit
.endc
.end
