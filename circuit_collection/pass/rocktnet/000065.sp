* Testbench for Receiver Sub-circuit
.param W_xm1=5.0 L_xm1=0.15
.param W_xm2=5.0 L_xm2=0.15
.param W_xm3=5.0 L_xm3=0.15
.param W_xm4=5.0 L_xm4=0.15
.param W_xm5=5.0 L_xm5=0.15

* Supply and Inputs
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 dc 0.9 ac 0.5
VLABEL_NET_1 LABEL_NET_1 0 dc 0.9 ac -0.5
VN0 N0 0 dc 0.9

* Biasing and loads to prevent floating nodes
R_N2 VDD N2 2k
R_N8 VDD N8 2k
I_tail N7 0 0.5m

R_N5 VDD N5 2k
R_N6 VDD N6 2k
I_N3 N3 0 0.2m
I_N1 N1 0 0.2m

* DUT
XM1 N2 LABEL_NET_0 N7 0 sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 N0 N3 0 sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N5 VDD N4 0 sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N6 N5 N1 0 sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N8 LABEL_NET_1 N7 0 sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.control
* DC Operating Point
op
let power_consumption = -i(VVDD)*1.8
print power_consumption

* AC Analysis
ac dec 40 1M 100G
let vout_diff = v(N2) - v(N8)
let gain_db = 20*log10(mag(vout_diff))

meas ac voltage_gain MAX gain_db
let target_gain = voltage_gain - 3
meas ac bandwidth WHEN gain_db=target_gain FALL=1

print voltage_gain bandwidth
quit
.endc
.end