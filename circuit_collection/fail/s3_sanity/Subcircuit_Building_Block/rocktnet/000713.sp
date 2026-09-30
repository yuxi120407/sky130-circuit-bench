* Testbench for Pseudo-Differential Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5

* DUT
XM2 LABEL_NET_0 Y GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM1 X VIN GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* Power Supply
VVDD VDD 0 1.8

* Inputs (Differential)
VVIN VIN 0 DC 0.9 AC 0.5 180
VY Y 0 DC 0.9 AC 0.5 0

* Differential Output Calculation
Ediff vout_diff 0 LABEL_NET_0 X 1

* Load Resistors
R1 X VDD 1k
R2 LABEL_NET_0 VDD 1k

.control
* 1. DC Operating Point for Power Consumption
op
let total_current = -i(VVDD)
let power_consumption = total_current * 1.8
print power_consumption

* 2. AC Analysis for Gain and Bandwidth
ac dec 100 1k 10000G
meas ac voltage_gain FIND vdb(vout_diff) AT=1k
let gain_3db = voltage_gain - 3
meas ac bandwidth_3db WHEN vdb(vout_diff)=gain_3db FALL=1
print voltage_gain
print bandwidth_3db

quit
.endc
.end