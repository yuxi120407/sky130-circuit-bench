* Fully Differential Summing Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param R_val=10k

.subckt amplifier out_minus out_plus in_plus in_minus
* Ideal fully differential amplifier with 1MHz GBW
G1 0 int_plus in_plus in_minus 0.01
R1 int_plus 0 1Meg
C1 int_plus 0 1.59n
E1 out_plus 0 vol='0.9 + 0.5*v(int_plus)'
E2 out_minus 0 vol='0.9 - 0.5*v(int_plus)'
.ends

* DUT (Changed A1 to X1 for subcircuit compatibility)
X1 VOUT_MINUS VOUT_PLUS N0 N1 amplifier
R1 N1 VOFFSET_PLUS {R_val}
R2 N1 VOUT_PLUS {R_val}
R3 N0 VOFFSET_MINUS {R_val}
R4 N0 VSCAN_PLUS {R_val}
R5 N0 VOUT_MINUS {R_val}
R6 N1 VSCAN_MINUS {R_val}

* Sources
VDD vdd 0 1.8
VCM vcm 0 0.9

* VSCAN sources (AC for bandwidth, SIN for transient)
VSCAN_P VSCAN_PLUS vcm dc 0 ac 0.5 sin(0 0.1 10k)
VSCAN_M VSCAN_MINUS vcm dc 0 ac -0.5 sin(0 -0.1 10k)

* VOFFSET sources (DC offset)
VOFFSET_P VOFFSET_PLUS vcm dc 0.1
VOFFSET_M VOFFSET_MINUS vcm dc -0.1

.control
* AC Analysis
ac dec 10 1 10Meg
let vout_diff = v(VOUT_PLUS) - v(VOUT_MINUS)
let gain_db = 20*log10(mag(vout_diff))
meas ac dc_gain_scan find gain_db at=10
meas ac bw_3db when gain_db='dc_gain_scan - 3' fall=1

* Transient Analysis
tran 1u 200u
let vout_diff_tran = v(VOUT_PLUS) - v(VOUT_MINUS)
meas tran vout_offset_dc avg vout_diff_tran
meas tran vout_diff_max max vout_diff_tran
meas tran vout_diff_min min vout_diff_tran
let vout_swing_pkpk = vout_diff_max - vout_diff_min
print vout_swing_pkpk

quit
.endc
.end
