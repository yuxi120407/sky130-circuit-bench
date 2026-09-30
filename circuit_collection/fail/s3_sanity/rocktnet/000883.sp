* Testbench for OTA/Comparator
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Parameters
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
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5

* DUT
XM1 N3 N9 LABEL_NET_1 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N6 LABEL_NET_2 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N7 LABEL_NET_3 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N6 N6 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 N9 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N7 LABEL_NET_4 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N7 N7 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N6 LABEL_NET_5 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N0 N8 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N5 LABEL_NET_6 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N5 N0 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N2 N10 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N0 LABEL_NET_7 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 N1 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}
XM16 N1 N10 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}

* Sources
VVDD VDD 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 1.8

* Inputs with AC and Tran
VLABEL_NET_2 LABEL_NET_2 0 dc 0.9 ac 0.5 sin(0.9 0.1 10k)
VLABEL_NET_3 LABEL_NET_3 0 dc 0.9 ac -0.5 sin(0.9 -0.1 10k)
VLABEL_NET_4 LABEL_NET_4 0 0.9
VLABEL_NET_5 LABEL_NET_5 0 0.9
VLABEL_NET_6 LABEL_NET_6 0 0.9
VLABEL_NET_7 LABEL_NET_7 0 0

* Biases and missing connections
VN9 N9 0 0.5
VN10 N10 0 1.0
VN8 N8 0 0

* Load capacitors
C1 N1 0 1p
C2 N2 0 1p
C6 N6 0 1p
C7 N7 0 1p

.control
* DC Operating Point
op
let Power_Consumption = (-i(VVDD) - i(VLABEL_NET_1)) * 1.8
print Power_Consumption

* AC Analysis
ac dec 100 1 10G
let vout_diff = v(N7) - v(N6)
let gain_mag = mag(vout_diff)
let gain_db = 20*log10(gain_mag)
let phase = 180/PI * cph(vout_diff)

meas ac DC_Gain find gain_db at=10
print DC_Gain

meas ac dc_gain_mag find gain_mag at=10

let gain_shifted = gain_db - $&DC_Gain + 3
meas ac f3db when gain_shifted=0 fall=1

let GBW = $&dc_gain_mag * $&f3db
print GBW

meas ac phase_at_GBW find phase at=$&GBW
let Phase_Margin = 180 + $&phase_at_GBW
print Phase_Margin

* Transient Analysis
tran 1u 500u
meas tran v_max max v(N6)
meas tran v_min min v(N6)
let swing = $&v_max - $&v_min
print swing

quit
.endc
.end