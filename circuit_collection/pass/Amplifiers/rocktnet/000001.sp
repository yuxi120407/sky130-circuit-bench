* Testbench for Pseudo-Differential Cascode Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

* DUT
XM1 N5 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 LABEL_NET_1 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N6 N5 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 N1 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 LABEL_NET_3 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

* Sources
VVDD VDD 0 1.8
VN3 N3 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_2 LABEL_NET_2 0 0.9
VLABEL_NET_3 LABEL_NET_3 0 0.9

* Inputs
V_bias N_bias 0 DC 0.9
VINP N5 N_bias DC 0 AC 1 SIN(0 0.01 10MEG)
VINN N1 N_bias DC 0 AC 0 SIN(0 0.0 10MEG)

* Load Capacitance
Cload1 N4 0 20f
Cload2 N0 0 20f

.control
* Find trip point
dc V_bias 0 1.8 0.001
meas dc vtrip find v(N_bias) when v(N4)=0.9

* Set the bias
alter V_bias dc = $&vtrip

* DC Operating Point
op
let power_consumption = -(i(VVDD)*1.8 + i(VN3)*1.8 + i(V_bias)*v(N_bias))
print power_consumption

* AC Analysis
ac dec 100 1k 10G
let gain_db = db(v(N4))
meas ac voltage_gain find gain_db at=10k
meas ac bandwidth_3db when gain_db='voltage_gain - 3' fall=1
print voltage_gain
print bandwidth_3db

* Transient Analysis
tran 1n 200n
meas tran v_max max v(N4)
meas tran v_min min v(N4)
let transient_swing = v_max - v_min
print transient_swing

quit
.endc
.end