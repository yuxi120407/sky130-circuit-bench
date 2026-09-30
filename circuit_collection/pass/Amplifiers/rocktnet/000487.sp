* Testbench for Limiting Amplifier Stage
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.15
.param L_xm2=0.15
.param L_xm3=0.15
.param L_xm4=0.15
.param L_xm5=0.15
.param L_xm6=0.15
.param L_xm7=0.15
.param L_xm8=0.15

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=1.0
.param W_xm6=1.0
.param W_xm7=5.0
.param W_xm8=5.0

VVDD VDD 0 1.8
VVINp VINp 0 DC 0.9 AC 0.5 SIN(0.9 0.1 100MEG 0 0 0)
VVINn VINn 0 DC 0.9 AC -0.5 SIN(0.9 0.1 100MEG 0 0 180)

* Load resistors and tail current sources (added for biasing)
R1 VDD N1 1000
R2 VDD N2 1000
R3 VDD VOUTp 1000
R4 VDD VOUTn 1000
I3 N3 0 1m
I4 N4 0 1m
I5 N5 0 20u

* DUT
XM1 N1 VINp N3 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 VINn N3 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VOUTp N1 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VOUTn N2 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 VOUTp N5 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 VOUTn N5 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 N2 VINp GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N2 N1 VINn GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

.control
* DC Operating Point & Power
op
let power = -i(VVDD) * 1.8
print power

* AC Analysis for Gain and Bandwidth
ac dec 20 1MEG 100G
let vout_diff = v(VOUTp) - v(VOUTn)
let gain_db = db(vout_diff)
meas ac dc_gain find gain_db at=1MEG
meas ac bw_3db when gain_db='dc_gain - 3' fall=1
print dc_gain
print bw_3db

* Transient Analysis for Output Swing
tran 10p 20n
let vout_diff_tran = v(VOUTp) - v(VOUTn)
meas tran vout_max max vout_diff_tran from=10n to=20n
meas tran vout_min min vout_diff_tran from=10n to=20n
meas tran vswing param='vout_max - vout_min'
print vswing

quit
.endc
.end