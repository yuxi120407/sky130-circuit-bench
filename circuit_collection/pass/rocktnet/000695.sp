* Wideband LC-Ladder Matching Network Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param R_val=50
.param CC_val=1p
.param L1_val=1n
.param L2_val=2n
.param L3_val=1n
.param C2_val=1p
.param L4_val=1n
.param C1_val=0.5p

* DUT
Vs N1 GND dc 0 ac 2
R1 N1 N2 {R_val}
CC N2 N3 CC_val
L1 N3 N4 L1_val
L2 N4 GND L2_val
L3 N4 N5 L3_val
C2 N5 N6 {C2_val}
L4 N6 N7 L4_val
R2 N7 GND {R_val}
C1 N5 GND {C1_val}

.control
ac dec 100 100MEG 20G

* Calculate S21 (Insertion Loss)
* Since Vs=2V and source/load are 50 ohms, V(N7)=1V for 0dB loss.
let s21_db = vdb(N7)

* Calculate S11 (Return Loss)
* V(N2) is the voltage at the input of the matching network.
* If matched (Zin=50), V(N2) = 1V. S11 = (Zin-50)/(Zin+50) = V(N2) - 1
let s11_complex = v(N2) - 1
let s11_db = 20 * log10(mag(s11_complex))

* Measure maximum S21 and bandwidth
meas ac max_s21 max s21_db
meas ac f_low when s21_db=-3 rise=1
meas ac f_high when s21_db=-3 fall=1

* Measure S11 and S21 at 6 GHz (midband)
meas ac s11_6G find s11_db at=6G
meas ac s21_6G find s21_db at=6G

print max_s21 f_low f_high s11_6G s21_6G
quit
.endc
.end