* IF Amplifier / Mixer Fragment Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0

* DUT
XM1 N0 N26 N26 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N25 N26 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N16 N2 N27 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 N27 N16 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N14 LABEL_NET_3 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 LABEL_NET_5 N16 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N4 LABEL_NET_6 N14 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N11 LABEL_NET_7 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

* Supplies and Biasing
VVDD VDD 0 1.8
VLABEL_NET_3 LABEL_NET_3 0 DC 0.9 AC 1 SIN(0.9 0.01 10Meg)
VLABEL_NET_5 LABEL_NET_5 0 DC 0.9
VLABEL_NET_6 LABEL_NET_6 0 DC 1.2
VLABEL_NET_7 LABEL_NET_7 0 DC 0.4

* Bias for floating gates
VN26 N26 0 DC 0.9
VN27 N27 0 DC 0.9

* Tail current sources
IN0 N0 0 200u
IN16 VDD N16 200u

* Load resistors
RN25 N25 VDD 10k
RN3 N3 GND 5k
RN4 N4 VDD 5k
RN11 N11 GND 5k

* Load capacitor to ensure UGF is reached
CLOAD N25 0 10f

.control
* 1. DC Operating Point & Power
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

* 2. AC Analysis for Gain and Bandwidth
ac dec 100 1k 10G
let gain_db = db(v(N25))
meas ac voltage_gain find gain_db at=100k
print voltage_gain
meas ac unity_gain_frequency when gain_db=0 fall=1
print unity_gain_frequency

* 3. Transient Analysis for Output Swing
tran 1n 500n
meas tran vout_max max v(N25)
meas tran vout_min min v(N25)
let transient_vpp = vout_max - vout_min
print transient_vpp

quit
.endc
.end