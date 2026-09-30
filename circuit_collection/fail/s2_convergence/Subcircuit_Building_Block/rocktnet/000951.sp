* Resonant Tank Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_val=1.0
.param C_val=551p

* DUT (Values appended to generic netlist for simulation)
LRS N0 GND {L_val}
C1 VXH GND 1n
CRS N0 GND {C_val}
* CLM GND GND (Shorted component commented out)
* SW (GND GND) switch_ideal (Invalid/shorted switch commented out)

* Excitation and Parasitics
Iac GND N0 AC 1
Rloss N0 GND 1k

.control
ac dec 100 1Meg 20Meg

* Calculate impedance magnitude
let z_mag = abs(v(N0))

* Measure peak impedance and resonant frequency
meas ac z_max MAX z_mag
meas ac f_res MAX_AT z_mag

print f_res
print z_max

quit
.endc
.end