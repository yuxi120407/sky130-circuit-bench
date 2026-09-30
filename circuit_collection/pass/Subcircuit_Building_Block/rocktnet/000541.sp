* RF CMOS Fragment Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

* DUT
XM2 N4 LABEL_NET_2 LABEL_NET_1 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 LABEL_NET_3 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N5 LABEL_NET_4 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

* Power Supplies and Biasing
VVDD VDD 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 1.8
VN3 N3 0 0
VN2 N2 0 1.8

* Self-biasing for the inverter (XM2, XM3)
Rbias N4 VIN 1Meg
Cin VIN_AC VIN 1m
VAC VIN_AC 0 DC 0 AC 1
V_in2 LABEL_NET_2 VIN 0
V_in3 LABEL_NET_3 VIN 0

* Dummy load for N5 and bias for XM4
VLABEL_NET_4 LABEL_NET_4 0 0.9
VN5 N5 0 0.9

.control
* 1. DC Operating Point
op
let dc_output_voltage = v(N4)
let dc_power = -i(VVDD)*1.8 - i(VLABEL_NET_1)*1.8 - i(VN2)*1.8
print dc_output_voltage
print dc_power

* 2. AC Analysis
ac dec 50 10 100G
let gain_db = vdb(N4)
meas ac voltage_gain find gain_db at=100
let target_gain = voltage_gain - 3
meas ac bandwidth when gain_db=target_gain fall=1

print voltage_gain
print bandwidth

quit
.endc
.end