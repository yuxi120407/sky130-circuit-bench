* Subcircuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5

XM1 N2 LABEL_NET_1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 LABEL_NET_3 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 LABEL_NET_4 LABEL_NET_5 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 LABEL_NET_6 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N6 LABEL_NET_7 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 LABEL_NET_8 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 LABEL_NET_10 LABEL_NET_9 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}

* Power Supply
VVDD VDD 0 1.8

* DC Biases and Inputs
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_3 LABEL_NET_3 0 0.9
VLABEL_NET_4 LABEL_NET_4 0 1.8
VLABEL_NET_5 LABEL_NET_5 0 0.9
VLABEL_NET_6 LABEL_NET_6 0 0.9 AC 1
VLABEL_NET_7 LABEL_NET_7 0 0.9
VLABEL_NET_8 LABEL_NET_8 0 0.9
VLABEL_NET_10 LABEL_NET_10 0 0.9
VLABEL_NET_9 LABEL_NET_9 0 0

* Tie floating nodes to reasonable DC levels
VN0 N0 VDD 0
VN4 N4 VDD 0
VN5 N5 0 0

.control
* Find the correct DC bias for high gain
dc VLABEL_NET_6 0 1.8 0.001
meas dc vtrip WHEN v(N3)=0.9
alter VLABEL_NET_6 dc = $&vtrip
alter VLABEL_NET_6 ac = 1

* DC Operating Point and Power
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

* AC Analysis for Gain
ac dec 100 1 1G
let gain_db = vdb(N3)
meas ac dc_gain MAX gain_db
print dc_gain

quit
.endc
.end