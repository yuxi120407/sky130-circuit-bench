* LC Tank Impedance Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_val=1n
.param C_val=7.4p
.param RL_val=1.16
.param RC_val=0.1
.param R_val=10k

* DUT
C N1 N3 {C_val}
R_C N3 N2 RC_val
L N1 N4 {L_val}
R_L N4 N2 RL_val
R N1 N2 {R_val}

* Stimulus
V_N2 N2 0 dc 0
I_test 0 N1 dc 0 ac 1

.control
ac dec 1000 100Meg 10G

let z_mag = mag(v(N1))
let z_phase = 180/PI * cph(v(N1))

* Measure maximum impedance (Parallel Equivalent Resistance Rp)
meas ac Rp max z_mag

* Measure resonant frequency (where phase crosses 0)
meas ac f_res when z_phase=0 fall=1

* Measure -3dB bandwidth using +/- 45 degree phase points
meas ac f_low when z_phase=45 fall=1
meas ac f_high when z_phase=-45 fall=1

* Calculate Quality Factor (Q)
let bw = f_high - f_low
let Q = f_res / bw

* Dummy values for metrics not applicable to a passive tank
let phase_noise = 0
let power_consumption = 0

print f_res Q Rp phase_noise power_consumption
quit
.endc
.end