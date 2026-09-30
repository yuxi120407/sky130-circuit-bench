* PMOS Source Follower Testbench
.param W_xm1=50.0 L_xm1=0.5

* DUT
XM1 N0 N1 VOUT VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}

* Sources and Biasing
VN0 N0 0 0
VVDD VDD 0 1.8
* DC bias of 0.5V ensures PMOS stays in saturation
VVIN N1 0 DC 0.5 AC 1 SIN(0.5 0.1 1MEG 0 0)
IBIAS VDD VOUT 100u
CLOAD VOUT 0 1p

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.control
* 1. DC Operating Point & Power
op
let dc_power = -i(VVDD)*1.8
print dc_power

* 2. AC Analysis for Gain and Bandwidth
ac dec 10 1k 10G
let gain_db = db(v(VOUT))
meas ac voltage_gain find gain_db at=10k
let target_gain = voltage_gain - 3
meas ac bandwidth when gain_db=target_gain fall=1
print voltage_gain
print bandwidth

quit
.endc
.end