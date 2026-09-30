* LC Tank Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param C_val=7.8p
.param L_val=0.001
.param R_val=1.13

* DUT
C NET1 NET2 {C_val}
L1 NET2 NET3 {L_val}
R1 NET3 NET1 {R_val}

* Stimulus
Vgnd NET1 0 0
I1 0 NET2 AC 1

.control
ac lin 10000 1G 3G
let z_mag = mag(v(NET2))
let z_phase = 180/PI * cph(v(NET2))

* Find resonant frequency (phase = 0)
meas ac f0 when z_phase=0 fall=1

* Find max impedance (Rp)
meas ac z_max max z_mag

* Find 3dB frequencies for Q calculation
let z_3db = z_max / 1.41421356
meas ac f1 when z_mag=z_3db rise=1
meas ac f2 when z_mag=z_3db fall=1

* Calculate Q
let q_factor = f0 / (f2 - f1)
print f0 z_max q_factor
quit
.endc
.end