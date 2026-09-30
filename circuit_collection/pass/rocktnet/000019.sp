* LC Tank Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_val=100p C_val=50f C_gnd=20f R_gnd=1k C_tune=20f

* DUT
L1 n2 n1 {L_val}
C1 n1 n2 {C_val}
C2 n0 n2 {C_gnd}
R1 n0 n2 {R_gnd}
C3 n1 label_net_0 {C_tune}

* Biasing and Ground
Vn0 n0 0 0
VLABEL_NET_0 label_net_0 0 0.9

* AC Current Source for Impedance Measurement
Iac n2 n1 DC 0 AC 1

.ac dec 1000 1G 100G

.control
run
let Z = v(n2) - v(n1)
let Z_mag = mag(Z)

meas ac Z_max MAX Z_mag
meas ac f_res MAX_AT Z_mag

let Z_3db = Z_max / 1.414213562
meas ac f_low WHEN Z_mag=Z_3db RISE=1
meas ac f_high WHEN Z_mag=Z_3db FALL=1

let Q_factor = f_res / (f_high - f_low)

print f_res Q_factor Z_max
quit
.endc
.end