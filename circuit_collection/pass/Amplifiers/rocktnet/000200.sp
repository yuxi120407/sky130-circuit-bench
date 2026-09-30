* Testbench for Summing Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0

XM2 VOUT VB A GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VOUT VB B GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VOUT VIN2 B GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM1 VOUT VIN1 A GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* Ground connections for source nodes
VA A 0 0
VB_node B 0 0

* Load resistor
RLOAD VDD VOUT 3k

* DC and AC Sources
VVDD VDD 0 1.8
VVB VB 0 0.54
VVIN2 VIN2 0 DC 0.9 AC 0
VVIN1 VIN1 0 DC 0.9 AC 1 SIN(0.9 0.1 100MEG 0 0)

.control
* DC Analysis
dc VVIN1 0 1.8 0.01
meas dc dc_output_voltage find v(VOUT) at=0.9
let pwr = -i(VVDD) * 1.8
meas dc power_consumption find pwr at=0.9
print dc_output_voltage
print power_consumption

* AC Analysis
ac dec 100 1MEG 100G
let gain_db = db(v(VOUT))
meas ac voltage_gain max gain_db
meas ac bandwidth_3db when gain_db="voltage_gain - 3" fall=1
print voltage_gain
print bandwidth_3db

quit
.endc
.end