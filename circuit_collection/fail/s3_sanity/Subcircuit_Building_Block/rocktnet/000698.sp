* Summing Transconductor Testbench
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

XM1 N1 N4 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N4 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 LABEL_NET_0 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 N5 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 N5 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 LABEL_NET_2 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 LABEL_NET_3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

* Supply and Biases
VVDD VDD 0 1.8
VN2 N2 0 1.8
VN4 N4 N1 0 ; Diode-connect PMOS load for stable DC operating point

VLABEL_NET_1 LABEL_NET_1 0 0.7
VLABEL_NET_3 LABEL_NET_3 0 0.7

* Inputs
VLABEL_NET_0 LABEL_NET_0 0 0.9 ac 1
VLABEL_NET_2 LABEL_NET_2 0 0.9
VN5 N5 0 0.9

* Load
Cload N1 0 50f

.control
* DC Operating Point
op
let power = -(i(VVDD) + i(VN2)) * 1.8
print power

* AC Analysis
ac dec 100 10 100G
meas ac dc_gain_mag find vmag(N1) at=10
let dc_gain = 20*log10(dc_gain_mag)
let gain_3db_mag = dc_gain_mag / 1.41421356
meas ac bw_3db when vmag(N1)=gain_3db_mag fall=1
print dc_gain bw_3db
.endc
.end