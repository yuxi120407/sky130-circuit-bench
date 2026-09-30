* Passive RC Filter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Parameterized component values
.param C1_val=1p
.param C2_val=1p
.param R2_val=1k

* Input Voltage Source
Vin NET1 GND DC 0 AC 1

* DUT (Device Under Test)
C1 NET1 GND {C1_val}
C2 NET1 NET2 {C2_val}
R2 NET2 GND {R2_val}

.control
* AC Analysis from 1 MHz to 10 GHz
ac dec 100 1Meg 10G

* Calculate Gain in dB and Phase in degrees
let gain_db = vdb(NET2)
let phase_deg = 180/PI * cph(v(NET2))

* Measure Maximum Gain
meas ac max_gain max gain_db

* Measure -3dB Cutoff Frequency
let cutoff_target = max_gain - 3
meas ac f3db when gain_db=cutoff_target

* Measure Phase at Cutoff Frequency
meas ac phase_at_f3db find phase_deg when gain_db=cutoff_target

* Print results
print max_gain f3db phase_at_f3db

quit
.endc
.end