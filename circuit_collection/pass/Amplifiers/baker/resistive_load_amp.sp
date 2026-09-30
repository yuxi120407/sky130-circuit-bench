* CS Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Define parameters for the DUT
.param W_XM1=5
.param L_XM1=1

* DUT Netlist
XM1 VOUT VIN GND GND sky130_fd_pr__nfet_01v8 l={L_XM1} w={W_XM1}
RL VDD VOUT 50e3
CL VOUT GND 10e-15
* Modified VIN to include AC source for AC analysis
VIN VIN GND DC 0.6 AC 1
VDD VDD GND DC 1.8

.control
* 1. DC Operating Point & Power
op
let vout_dc = v(VOUT)
let id_dc = -i(VDD)
let power_dc = id_dc * 1.8
print vout_dc id_dc power_dc

* 2. AC Analysis for Gain and Bandwidth
ac dec 100 1k 10G
let gain_db = vdb(VOUT)
meas ac dc_gain_db find gain_db at=1k
let gain_3db = dc_gain_db - 3
meas ac f_3db when gain_db=gain_3db fall=1

* 3. DC Sweep for VTC
dc VIN 0 1.8 0.01
meas dc vout_at_bias find v(VOUT) when v(VIN)=0.6

quit
.endc
.end