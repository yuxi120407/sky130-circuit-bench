* Testbench for VCO Sub-circuit
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

XM1 N4 N4 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 N4 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 LABEL_NET_0 N4 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 N4 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 OUT_PLUS N11 N9 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 OUT_PLUS LABEL_NET_2 N9 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 VDD VDD VB1 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 VDD VDD LABEL_NET_3 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

* DC Sources
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VVB1 VB1 0 0.75
VLABEL_NET_2 LABEL_NET_2 0 0.9
VLABEL_NET_3 LABEL_NET_3 0 0.9
VN9 N9 0 0
VN3 N3 0 0
VN5 N5 0 1.8

* Input signal for amplifier
VN11 N11 0 0.9 ac 1 sin(0.9 0.1 100Meg)

* Load for amplifier
RL OUT_PLUS VDD 1k

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.control
* DC Operating Point
op
let power_consumption = -(i(VVDD)*1.8 + i(VN5)*1.8 + i(VLABEL_NET_0)*0.9 + i(VVB1)*0.75 + i(VLABEL_NET_2)*0.9 + i(VLABEL_NET_3)*0.9 + i(VN11)*0.9)
print power_consumption
let bias_voltage_n4 = v(N4)
print bias_voltage_n4

* AC Analysis
ac dec 10 1 100Gig
meas ac amplifier_dc_gain find vdb(OUT_PLUS) at=10
meas ac amplifier_bandwidth when vdb(OUT_PLUS)='amplifier_dc_gain-3' fall=1

quit
.endc
.end