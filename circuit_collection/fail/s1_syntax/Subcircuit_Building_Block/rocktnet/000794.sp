* Testbench for NMOS Switch Network
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

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5

XM1 N4 LABEL_NET_0 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 LABEL_NET_1 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 LABEL_NET_2 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 LABEL_NET_3 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 LABEL_NET_4 LABEL_NET_5 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N5 LABEL_NET_6 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N3 LABEL_NET_7 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N2 LABEL_NET_8 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N0 LABEL_NET_9 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}

VLABEL_NET_0 LABEL_NET_0 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 1.8
VLABEL_NET_2 LABEL_NET_2 0 1.8
VLABEL_NET_3 LABEL_NET_3 0 1.8
VLABEL_NET_4 LABEL_NET_4 0 1.8
VLABEL_NET_5 LABEL_NET_5 0 1.8
VLABEL_NET_6 LABEL_NET_6 0 1.8
VLABEL_NET_7 LABEL_NET_7 0 1.8
VLABEL_NET_8 LABEL_NET_8 0 1.8
VLABEL_NET_9 LABEL_NET_9 0 1.8

VN0 N0 0 1.8
VN1 N1 0 0
VN4 N4 0 1.8
VN5 N5 0 0

.control
op
let v_n2 = v(N2)
let i_n0 = -i(VN0)
let r_on_xm9 = (v(N0) - v(N2)) / i_n0
print v_n2 i_n0 r_on_xm9

tran 1n 1u
meas tran v_n2_avg avg v(N2)
let power = i_n0 * 1.8
print power
quit
.endc
.end
