* Bandpass Filter Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Parameterized passive values to approximate 2.14 GHz resonance
.param L_val=5.53n
.param C_val=1p
.param R_val=50

* Input Source
V1 N0_in GND dc 0 ac 1
Rin N0_in N0 50

* DUT: Passive Filter Network
L1 N0 N1 {L_val}
L2 N4 N5 {L_val}
L3 N3 N6 {L_val}
R1 N3 GND {R_val}
C1 N2 GND {C_val}
C2 N5 GND {C_val}
C3 N0 GND {C_val}
C4 N3 GND {C_val}
C5 N5 N6 {C_val}
C6 N1 N2 {C_val}
R2 N2 GND {R_val}
C7 N0 N4 {C_val}

* Load
Rload N5 GND 50

.ac dec 1000 100Meg 10Gig

.control
run

* Calculate Gain in dB
let gain_db = vdb(N5)

* Measure peak gain and Center Frequency
meas ac max_gain MAX gain_db
meas ac center_frequency MAX_AT gain_db

* Measure bandwidth
let gain_3db = max_gain - 3
meas ac f_low WHEN gain_db=gain_3db CROSS=1
meas ac f_high WHEN gain_db=gain_3db CROSS=LAST
let bandwidth = f_high - f_low

* Calculate insertion loss (positive value for loss)
let insertion_loss = -max_gain

* Print results
print center_frequency insertion_loss bandwidth

.endc
.end