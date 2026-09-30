* OTA Testbench
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

XM1 N2 LABEL_NET_0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 LABEL_NET_1 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 LABEL_NET_2 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 LABEL_NET_3 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 N5 LABEL_NET_4 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 LABEL_NET_5 N4 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N2 N2 LABEL_NET_6 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N1 N4 LABEL_NET_7 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

VVDD VDD 0 1.8
* Override dummy 0.9V sources with proper supply/ground
VLABEL_NET_4 LABEL_NET_4 0 1.8
VLABEL_NET_6 LABEL_NET_6 0 1.8
VLABEL_NET_5 LABEL_NET_5 0 0
VLABEL_NET_7 LABEL_NET_7 0 0

* Bias voltages for tail current and PMOS loads
VN4 N4 0 0.7
VN5 N5 0 1.1

* Inputs
VLABEL_NET_0 LABEL_NET_0 0 dc 0.9 ac 1
VLABEL_NET_3 LABEL_NET_3 0 dc 0.9 ac 0
VLABEL_NET_2 LABEL_NET_2 0 dc 0.9
VLABEL_NET_1 LABEL_NET_1 0 dc 0.9

* Load capacitance
C1 N2 0 10f
C2 N3 0 10f

.control
op
let Power_Consumption = (-i(VVDD) - i(VLABEL_NET_4) - i(VLABEL_NET_6)) * 1.8
print Power_Consumption

ac dec 100 1k 10G
let vout_diff = v(N3) - v(N2)
let gain_db = db(vout_diff)
meas ac DC_Gain max gain_db
let target_gain = DC_Gain - 3
meas ac Bandwidth_3dB when gain_db=target_gain fall=1
print DC_Gain
print Bandwidth_3dB
quit
.endc
.end