* RLC Filter Prototype Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* DUT Netlist
V0 V0 GND
R1 V0 N1 1
L1 N1 V2 2.2160
C2 V2 GND 1.0883
L3 V2 V4 2.2160
R4 V4 GND 1

.control
* Set V0 as AC source for frequency response analysis
alter V0 ac=1

* Run AC analysis from 0.001 Hz to 10 Hz
ac dec 100 0.001 10

* Calculate gain in dB
let gain_db = vdb(V4)

* Measure DC gain (at very low frequency)
meas ac dc_gain find gain_db at=0.001

* Measure -3dB cutoff frequency
let target_gain = dc_gain - 3
meas ac cutoff_freq when gain_db=target_gain fall=1

* Measure passband ripple
meas ac max_gain max gain_db from=0.001 to=0.15
let passband_ripple = max_gain - dc_gain

print dc_gain cutoff_freq passband_ripple
quit
.endc
.end