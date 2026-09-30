* Fully Integrated CMOS Receiver Front-End Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xm10=0.5
.param L_xm11=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm9=5.0
.param W_xm10=5.0
.param W_xm11=5.0

XM1 N9 LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N11 N10 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N6 N9 N9 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 LABEL_NET_3 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N4 N10 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 LABEL_NET_4 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 LABEL_NET_5 N9 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N7 LABEL_NET_6 N11 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 LABEL_NET_7 N8 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N3 N6 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N1 N0 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}

* Power Supplies and Bias
VVDD VDD 0 1.8
V_N3 N3 0 1.8
R_N0 VDD N0 10k
R_N6 VDD N6 10k
R_N7 VDD N7 10k

V_N10 N10 0 0.6
V_N8 N8 0 0.9
V_N5 N5 0 0.9
V_L7 LABEL_NET_7 0 1.8
V_L5 LABEL_NET_5 0 1.2
V_L6 LABEL_NET_6 0 1.2

* Feedback bias for N1 to keep it in high-gain region
B_fb fb_node 0 V='0.64 + (0.9 - V(N1))*5'
R_fb fb_node LABEL_NET_2 1Meg
C_fb LABEL_NET_2 0 1

.nodeset V(N1)=0.9
.nodeset V(fb_node)=0.64
.nodeset V(LABEL_NET_2)=0.64
.nodeset V(N9)=0.6
.nodeset V(N0)=0.89

* Differential AC and Transient Inputs
VINP LABEL_NET_3 0 0.9 AC 0.5 SIN(0.9 0.01 10Meg)
VINN LABEL_NET_4 0 0.9 AC -0.5 SIN(0.9 -0.01 10Meg)

.control
* DC Operating Point & Power
op
let power_consumption = -(i(VVDD) + i(V_N3))*1.8
print power_consumption

* AC Analysis for Gain and Bandwidth
ac dec 20 10k 100G
let gain_db = vdb(N1)
meas ac voltage_gain MAX gain_db
let gain_3db = voltage_gain - 3
meas ac bandwidth when gain_db=gain_3db fall=1
print voltage_gain
print bandwidth

* Transient Analysis
tran 1n 200n
meas tran vout_max max v(N1)
meas tran vout_min min v(N1)
let vpp = vout_max - vout_min
print vpp

quit
.endc
.end