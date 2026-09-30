* Passive RLC Filter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* DUT with representative values for 1.92MHz cutoff
R1 IIN GND 1k
C1 IIN GND 80p
L2 IIN N1 100u
C3 N1 GND 150p
C4 N1 VOUT 20p
L4 N1 VOUT 100u
C5 VOUT GND 80p
R5 VOUT GND 1k

* Stimulus
I1 GND IIN DC 0 AC 2m

.control
ac dec 100 1k 100Meg
let gain_db = db(v(VOUT))

* Measure DC Gain (at 1kHz)
meas ac dc_gain find gain_db at=1k

* Measure -3dB Cutoff Frequency
let target_gain = dc_gain - 3
meas ac cutoff_frequency when gain_db=target_gain fall=1

* Measure Stopband Suppression at 30.72 MHz
meas ac gain_at_fs find gain_db at=30.72Meg
let stopband_suppression = dc_gain - gain_at_fs

print dc_gain cutoff_frequency stopband_suppression
quit
.endc
.end