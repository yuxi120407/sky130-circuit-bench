* Receiver Pre-amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
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
.param W_xm13=5.0 L_xm13=0.5

VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0
VN5 N5 0 1.8
VN4 N4 0 0.65
VN7 N7 0 0.65
VN6 N6 0 0.65 ac 1 sin(0.65 0.1 500MEG)

* DUT
XM1 N1 N1 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N1 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 N4 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 N4 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 N6 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N3 N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N0 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N1 N7 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N1 LABEL_NET_0 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}

.control
* DC Operating Point & Power
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption
print v(N1)

* AC Analysis for Gain and Bandwidth
ac dec 50 1Meg 100G
let gain_db = db(v(N1))
meas ac ac_gain max gain_db
meas ac bandwidth_3db when gain_db='ac_gain - 3' fall=1
print ac_gain bandwidth_3db

* Transient Analysis for Output Swing
tran 10p 20n
meas tran v_max max v(N1) from=10n to=20n
meas tran v_min min v(N1) from=10n to=20n
meas tran transient_vpp param='v_max - v_min'
print transient_vpp

quit
.endc
.end