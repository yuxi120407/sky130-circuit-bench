* RLC Tank / PDN Impedance Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param R_val=50
.param L_val=0.002533u
.param C_val=10p

* DUT Netlist
Isupply VSS VDD dc 0 ac 1
RP VSS VDD {R_val}
LP VSS VDD {L_val}
CP VSS VDD {C_val}

* Stimulus & Biasing
VVSS VSS 0 0

.control
ac dec 1000 10Meg 10Gig

* Calculate impedance magnitude
let z_mag = abs(v(VDD))

* Measure peak impedance and resonance frequency
meas ac peak_impedance max z_mag
meas ac resonance_frequency max_at z_mag

* Calculate -3dB bandwidth and Q factor
let z_3db = peak_impedance / 1.41421356
meas ac f_low when z_mag=$&z_3db rise=1
meas ac f_high when z_mag=$&z_3db fall=1
let bw = f_high - f_low
let quality_factor = resonance_frequency / bw

print resonance_frequency peak_impedance quality_factor
quit
.endc
.end