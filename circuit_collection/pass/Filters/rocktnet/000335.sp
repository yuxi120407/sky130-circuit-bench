* Passive RC Lead-Lag Filter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Define parameters based on expected values
.param R=1k
.param Cp=2.5p
.param Q=5

* DUT (Syntax corrected from extracted netlist to be valid SPICE)
R2 Vi Vo R
C2 Vi Vo {Cp/(Q-1)}
R1 Vo GND R
C1 Vo GND Cp

* Stimulus
Vin Vi GND dc 1 ac 1

* Control block
.control
* Run AC analysis from 1 Hz to 100 GHz
ac dec 100 1 100G

* Calculate gain in dB
let gain_db = db(v(Vo))

* Measure DC gain at 10 Hz
meas ac dc_gain find gain_db at=10

* Measure High Frequency gain at 10 GHz
meas ac hf_gain find gain_db at=10G

* Calculate midpoint gain and find corresponding frequency
let mid_g = ($&dc_gain + $&hf_gain) / 2
meas ac mid_freq when gain_db=$&mid_g

* Print results
print dc_gain hf_gain mid_freq

.endc
.end