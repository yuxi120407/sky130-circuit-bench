* Integrated Inductor Pi-Model Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Parameters to match paper's 2.7nH inductance and typical parasitics
.param L_s=2.7n R_s=2.5 C_f=50f C_ox=100f R_sub=50

* DUT
C1 n0 n1 {C_ox}
L1 n3 n4 {L_s}
C2 n2 n3 {C_ox}
C3 n0 n3 {C_f}
R1 n1 0 {R_sub}
R2 n2 0 {R_sub}
R3 n0 n4 {R_s}

* Stimulus: 1A AC current source at port 1, port 2 grounded
I1 0 n0 AC 1
V1 n3 0 DC 0

.control
* AC sweep from 100 MHz to 20 GHz
ac dec 100 100Meg 20Gig

* Calculate Impedance, Resistance, Reactance, Inductance, and Q
let Z = v(n0)
let R = real(Z)
let X = imag(Z)
let L_eff_v = X / (2 * 3.14159265359 * frequency)
let Q_factor_v = X / R

* Measure metrics at 2.4 GHz
meas ac L_eff find L_eff_v at=2.4G
meas ac Q_factor find Q_factor_v at=2.4G

* Measure Self-Resonant Frequency (where reactance crosses 0)
meas ac SRF when X=0 fall=1

print L_eff Q_factor SRF
.endc
.end