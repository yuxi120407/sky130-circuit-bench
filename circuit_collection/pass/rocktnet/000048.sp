* Cascode Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

* DUT
XM1 N1 LABEL_NET_0 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 LABEL_NET_1 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Sources and Load
VVDD VDD 0 1.8
VN0 N0 0 0
Vbias LABEL_NET_0 0 1.2
Vin LABEL_NET_1 0 dc 0.7 ac 1

* Load Resistor
RL N1 VDD 20k

.control
* DC Operating Point
op
let dc_current = -i(VVDD)
print dc_current

* AC Analysis for Gain and Bandwidth
ac dec 20 1k 100G
let gain_db = db(v(N1))

* Measure midband gain
meas ac voltage_gain MAX gain_db

* Measure bandwidth
let target_gain = voltage_gain - 3
meas ac bandwidth when gain_db=target_gain fall=1

print voltage_gain
print bandwidth
quit
.endc
.end