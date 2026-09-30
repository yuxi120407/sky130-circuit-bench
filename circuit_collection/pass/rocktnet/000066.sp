* Testbench for Receiver Sub-block
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

XM1 N2 N3 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 LABEL_NET_1 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N4 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 VDD N8 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N8 N9 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 LABEL_NET_2 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N6 VDD LABEL_NET_3 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 N4 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

VVDD VDD 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 dc 0.9 ac 1
VLABEL_NET_2 LABEL_NET_2 0 dc 0.9
VLABEL_NET_3 LABEL_NET_3 0 dc 0.9
VN9 N9 0 dc 0.9

* Load resistors to prevent floating nodes and provide gain
R0 VDD N0 1k
R1 VDD N1 1k
R3 VDD N3 1k
R6 VDD N6 1k

* Grounding resistors for bottom nodes
R5 N5 0 10
R7 N7 0 10
R4 N4 0 10

.control
op
let power = -i(VVDD)*1.8
print power

ac dec 10 1M 10G
let gain_db = vdb(N0)
meas ac gain_10m find gain_db at=10M
meas ac gain_1g find gain_db at=1G
quit
.endc
.end