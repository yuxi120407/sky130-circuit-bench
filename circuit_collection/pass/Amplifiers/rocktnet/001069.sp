* Common-Source Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

.param W_xm1=5.0 L_xm1=0.5

* DUT
XM1 N2 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* Biasing and Loads
VDD VDD 0 1.8
RL VDD N2 2k
CL N2 0 100f

* Input Signal (DC bias + AC perturbation)
VIN N0 0 dc 0.9 ac 1

.control
* 1. DC Operating Point & Power
op
let id = -i(VDD)
let dc_power = id * 1.8
print id dc_power

* 2. AC Analysis for Gain and Bandwidth
ac dec 100 1Meg 10Gig
let gain_db = vdb(N2)

* Measure low frequency gain
meas ac max_gain_db max gain_db

* Calculate 3dB drop point and measure bandwidth
let gain_3db = max_gain_db - 3
meas ac f_3db when gain_db="$&gain_3db" fall=1

print max_gain_db f_3db

quit
.endc
.end