* GMSK Modulator Sub-block Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
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

XM1 N13 LABEL_NET_0 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N2 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N12 LABEL_NET_0 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 N11 N12 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N8 LABEL_NET_0 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 N11 N13 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N9 N3 N23 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N10 LABEL_NET_0 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N9 N9 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N6 N11 N10 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N7 LABEL_NET_7 N23 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N7 N11 N8 VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}

VVDD VDD 0 1.8
VN5 N5 0 1.8
VN23 N23 0 0
VGND GND 0 0

VLABEL_NET_0 LABEL_NET_0 0 0.9
VN11 N11 0 0.4

VLABEL_NET_7 LABEL_NET_7 0 dc 0.62 ac 1
VN3 N3 0 0.62

VN1 N1 0 0.9
VN6 N6 0 0.9

R_N7 N7 N7_bias 1Meg
VN7_bias N7_bias 0 0.9

.control
op
let power = -(i(VVDD) + i(VN5)) * 1.8
print power
print v(N7) v(N9)

ac dec 100 1 10G
let gain_db = vdb(N7)
meas ac max_gain MAX gain_db
meas ac bw when gain_db=0 fall=1

tran 1n 1u
quit
.endc
.end
