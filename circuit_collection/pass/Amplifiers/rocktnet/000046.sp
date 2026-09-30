* Secure Contactless Smartcard ASIC OTA Testbench
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

* DUT
XM1 N7 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N7 N6 N2 0 sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N6 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N5 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N9 LABEL_NET_2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 N5 N2 0 sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N0 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}

* Power supply and Ground
VVDD VDD 0 DC 1.8
VN2 N2 0 DC 0

* Biases for auxiliary PMOS current sources
VLABEL_NET_0 LABEL_NET_0 0 DC 0.9
VLABEL_NET_2 LABEL_NET_2 0 DC 0.9

* Dummy loads to keep auxiliary current sources in saturation
V_N1 N1 0 DC 0.9
V_N4 N4 0 DC 0.9
V_N9 N9 0 DC 0.9
V_N0 N0 0 DC 0.9

* OTA Biasing and AC input
* N6 is the Non-Inverting input (+)
V_N6 N6 0 DC 0.8 AC 1

* N5 is the Inverting input (-)
* Close the loop for DC to stabilize the high-gain node (N3), open for AC
L1 N3 N5 1Meg
C1 N5 0 1Meg

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.control
* DC Operating Point and Power
op
let power = -VVDD#branch * 1.8
print power
print v(N3) v(N7) v(N6) v(N5)

* AC Analysis for Gain and Phase Margin
ac dec 100 1 10G
let gain_db = db(v(N3))
let phase_deg = ph(v(N3)) * 180 / 3.1415926535
meas ac dc_gain find gain_db at=1
meas ac ugbw when gain_db=0 fall=1
meas ac phase_at_ugbw find phase_deg when gain_db=0 fall=1
let phase_margin = phase_at_ugbw + 180
print dc_gain ugbw phase_margin

quit
.endc
.end