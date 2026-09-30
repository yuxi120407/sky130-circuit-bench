* DAC Cell Testbench
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

VVDD VDD 0 1.8
VGND GND 0 0
VN10 N10 0 0
VN7 N7 0 0

* Biases
VN0 N0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.5
VLABEL_NET_4 LABEL_NET_4 0 0.9
VN6 N6 0 0.6

* Input signal (Data)
VLABEL_NET_6 LABEL_NET_6 0 PULSE(1.8 0 1n 0.1n 0.1n 10n 20n)

* DUT
XM1 N11 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 LABEL_NET_1 N11 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N5 N5 N9 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 LABEL_NET_4 N9 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 N6 N10 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N5 N6 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N5 LABEL_NET_6 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 VDD N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N9 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}

.control
* DC Operating Point
op
let power = -i(VVDD) * 1.8
print power
print v(N5) v(N1)

* Transient Analysis
tran 0.1n 40n
meas tran v_max max v(N5)
meas tran v_min min v(N5)
quit
.endc
.end
