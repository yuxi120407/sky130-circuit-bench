* Testbench for Bias Network / Cascode Stage
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm1c=0.5
.param L_xm2=0.5
.param L_xm2c=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xmbc=0.5

.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xmbc=5.0 L_xmbc=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm1c=5.0 L_xm1c=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm2c=5.0 L_xm2c=0.5
.param W_xm1=5.0 L_xm1=0.5

* DUT
XM4 N5 N5 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 N6 LABEL_NET_0 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XMBC N2 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xmbc} w={W_xmbc}
XM3 VBN N5 LABEL_NET_1 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM1C VGS2 N3 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm1c} w={W_xm1c}
XM2 N7 LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM2C N5 N3 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm2c} w={W_xm2c}
XM1 N4 VBN GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* DC Sources
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 1.8
VN6 N6 0 1.4
VN3 N3 0 1.0
VLABEL_NET_2 LABEL_NET_2 0 0.6
VVBN VBN 0 dc 0.6 ac 1 sin(0.6 1m 1Meg)

* Load
LL VDD VGS2 1e9
CL VGS2 0 1p

.control
* DC Operating Point & Power
op
let power = -(i(VVDD)*1.8 + i(VLABEL_NET_0)*1.8 + i(VLABEL_NET_1)*1.8 + i(VN6)*1.4 + i(VN3)*1.0 + i(VLABEL_NET_2)*0.6 + i(VVBN)*0.6)
print power

* AC Analysis for Gain and Bandwidth
ac dec 100 1 1G
let gain_db = vdb(VGS2)
meas ac dc_gain find gain_db at=10
let gain_db_3db = dc_gain - 3
meas ac bw when gain_db=gain_db_3db fall=1

* Transient Analysis
tran 1n 2u
meas tran v_max max v(VGS2)
meas tran v_min min v(VGS2)

quit
.endc
.end