* LC Tank Characterization
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param C1_val=1p
.param C2_val=1p
.param R1_val=10k
.param R2_val=10k
.param L1_val=100p C1_val=10f R1_val=500 R2_val=1k C2_val=150f

* DUT
L1 n0 n1 {L1_val}
C1 n0 n2 {C1_val}
R1 n0 n1 {R1_val}
R2 n1 n2 {R2_val}
C2 n0 n1 {C2_val}

* Ground connection for n2
Vgnd n2 0 DC 0

* Differential AC drive
I1 0 n0 AC 1
I2 0 n1 AC -1

.control
ac dec 1000 1G 100G

let Z_diff = v(n0) - v(n1)
let Z_mag = mag(Z_diff)
let Z_im = im(Z_diff)

meas ac peak_impedance max Z_mag
meas ac resonance_frequency when Z_im=0 fall=1

let Z_3dB = peak_impedance / 1.41421356
meas ac f_low when Z_mag=Z_3dB rise=1
meas ac f_high when Z_mag=Z_3dB fall=1

meas ac quality_factor param='resonance_frequency / (f_high - f_low)'

print resonance_frequency peak_impedance quality_factor
quit
.endc
.end