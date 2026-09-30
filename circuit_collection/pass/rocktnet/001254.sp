* Common-Source Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

.param W_xm1=5.0 L_xm1=0.5

* DUT
XM1 LABEL_NET_1 LABEL_NET_3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* Sources and Load
VVDD VDD 0 1.8
RL VDD LABEL_NET_1 20k
V_in LABEL_NET_3 0 DC 0.75 AC 1

.control
* DC Operating Point
op
let dc_current = -i(VVDD)
let power_consumption = -i(VVDD) * 1.8
print dc_current power_consumption

* AC Analysis
ac dec 100 10 100G
let gain_db = vdb(LABEL_NET_1)
meas ac voltage_gain find gain_db at=100
let target_gain = voltage_gain - 3
meas ac bandwidth when gain_db=target_gain fall=1

quit
.endc
.end