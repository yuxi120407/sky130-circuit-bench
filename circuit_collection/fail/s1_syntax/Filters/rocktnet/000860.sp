* Q-Enhanced LC Filter - Passive Tank Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param c_val=1p
.param l_val=0.5

.param rs_val=1 rl_val=1.5 l_val=0.001 c_val=2p

* DUT
RS IN N1 rs_val
RL1 N1 N2 rl_val
L1 N2 VPLUS {l_val}
C1 VPLUS VMINUS {c_val}
RL2 GND N3 rl_val
L2 N3 VMINUS {l_val}

* Stimulus
VIN IN 0 DC 0 AC 1

.control
ac dec 100 100MEG 10G

* Differential output voltage across C1
let vout = v(VPLUS) - v(VMINUS)
let vout_db = 20*log10(mag(vout))

* Input current to find resonance (phase = 0)
let i_in = (v(IN) - v(N1)) / rs_val
let phase_i = 180/PI * cph(i_in)

* Measure resonant frequency where input current phase is 0
meas ac f0 WHEN phase_i=0 FALL=1

* Measure peak gain
meas ac max_gain MAX vout_db

print f0 max_gain
quit
.endc
.end