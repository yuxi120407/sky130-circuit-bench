* Differential Cascode Amplifier Testbench

.param W_xm1=5.0 L_xm1=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm2=5.0 L_xm2=0.5

* DUT
XM1 N3 VIN_PLUS N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM3 VOUT_PLUS VDD N3 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VOUT_MINUS VDD N4 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM2 N4 VIN_MINUS N5 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Power Supply
VVDD VDD 0 1.8

* Input Signals (DC=0.9V, AC=2V differential, Tran=200mVpp differential at 1MHz)
VVIN_PLUS VIN_PLUS 0 DC 0.9 AC 1 SIN(0.9 0.1 1MEG 0 0 0)
VVIN_MINUS VIN_MINUS 0 DC 0.9 AC -1 SIN(0.9 0.1 1MEG 0 0 180)

* Grounding the sources of the input pair (Pseudo-differential configuration)
VN2 N2 0 0
VN5 N5 0 0

* Load resistors
RL1 VDD VOUT_PLUS 10k
RL2 VDD VOUT_MINUS 10k

* Ideal balun/VCVS to extract differential output
Ediff VOUT_DIFF 0 VOUT_PLUS VOUT_MINUS 1.0

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.control
* 1. DC Operating Point & Power
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

* 2. AC Analysis for Gain and Bandwidth
ac dec 100 1k 100G
* Input is 2V differential (1V - (-1V)), so subtract 20*log10(2) = 6.0206 dB
let gain_db = db(v(VOUT_DIFF)) - 6.0206
meas ac voltage_gain MAX gain_db
let gain_3db = voltage_gain - 3
meas ac bandwidth when gain_db=gain_3db fall=1
print voltage_gain
print bandwidth

* 3. Transient Analysis
tran 1n 5u
meas tran vout_diff_pp PP v(VOUT_DIFF)

quit
.endc
.end