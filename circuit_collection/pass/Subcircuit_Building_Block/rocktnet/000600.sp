* Testbench for Passive Matching Network

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param C_pd=0.5p
.param L_2=10n
.param C_3=0.1p
.param R_2=500

* Dummy VDD to satisfy requirements
Vdd VDD GND 1.8

* DUT
IIn N1 GND AC 1
CPD N1 GND {C_pd}
L2 N1 N2 {L_2}
C3 N2 GND {C_3}
R2 N2 GND {R_2}

.control
ac dec 100 1M 100G

let tz_db = vdb(N2)

* Measure low frequency gain (at 1 MHz)
meas ac transimpedance_gain find tz_db at=1M

* Measure maximum gain for peaking
meas ac tz_max max tz_db
let gain_peaking = tz_max - transimpedance_gain

* Measure 3-dB bandwidth
let tz_shifted = tz_db - transimpedance_gain + 3
meas ac bandwidth_3dB when tz_shifted=0 fall=1

print transimpedance_gain
print bandwidth_3dB
print gain_peaking

quit
.endc
.end