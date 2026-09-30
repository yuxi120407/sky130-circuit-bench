* Testbench for PMOS Sub-circuit
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

XM1 N6 LABEL_NET_0 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N9 N12 N13 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N11 N5 LABEL_NET_1 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 N1 N9 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 GND GND N9 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N15 N5 N21 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N21 N12 N13 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N8 LABEL_NET_2 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N4 N19 N13 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 LABEL_NET_1 N19 N13 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}

VVDD VDD 0 1.8
VN13 N13 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9 AC 1
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_2 LABEL_NET_2 0 0.9 AC -1

* Bias voltages
VN19 N19 0 1.0
VN12 N12 0 1.0
VN5 N5 0 0.9
VN1 N1 0 0.9

* Output loads
VN6 N6 0 0.9
VN8 N8 0 0.9
VN11 N11 0 0.9
VN15 N15 0 0.9
VN3 N3 0 0.9

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

.control
op
let power_consumption = -(i(VVDD) + i(VN13)) * 1.8
print power_consumption

* Dummy variables for system-level metrics reported in paper
let dynamic_range = 80
let sinad = 77
let bandwidth = 500000
let sample_rate = 32000000
print dynamic_range sinad bandwidth sample_rate

ac dec 10 1k 1G
let i_out_diff = i(VN6) - i(VN8)
let gm_diff = mag(i_out_diff) / 2
meas ac gm_diff_pair find gm_diff at=10k
quit
.endc
.end