* Balun AC Characterization Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.options rshunt=1e12

* Component parameters (estimated for ~2GHz operation since values were not extracted)
.param c_val=1p r_val=50 l_val=2n

* Input Source
V1 label_net_0 0 DC 0 AC 1

* DUT: Extracted Balun Netlist
C1 n10 n13 {c_val}
R1 n2 n2 {r_val}
C2 n9 n11 {c_val}
R2 n10 0 {r_val}
R3 n1 0 {r_val}
R4 n7 n7 {r_val}
C3 n4 n14 {c_val}
C4 n0 n1 {c_val}
C5 n5 n12 {c_val}
R5 n11 n12 {r_val}
R6 n5 label_net_0 {r_val}
R7 n4 n12 {r_val}
R8 n3 n3 {r_val}
C6 n6 n7 {c_val}
L1 n8 n14 {l_val}
C7 n3 n6 {c_val}
C8 n2 n12 {c_val}
R9 n0 n14 {r_val}
R10 n8 n9 {r_val}
L2 n9 n13 {l_val}
L3 n6 n11 {l_val}
L4 n4 n6 {l_val}

* AC Analysis from 100 MHz to 10 GHz
.ac dec 100 100MEG 10G

.control
run

* Calculate magnitudes in dB
let mag1 = db(v(n10))
let mag2 = db(v(n1))

* Calculate phases in degrees
let phase1 = 180/3.141592653589793 * ph(v(n10))
let phase2 = 180/3.141592653589793 * ph(v(n1))

* Calculate metrics (Loss and imbalances are typically positive)
let ins_loss = -mag1
let amp_imb = abs(mag1 - mag2)
let phase_diff = abs(phase1 - phase2)

* Measure metrics at 2 GHz (W-CDMA band)
meas ac Insertion_Loss find ins_loss at=2G
meas ac Amplitude_Imbalance find amp_imb at=2G
meas ac Phase_Difference find phase_diff at=2G

print Insertion_Loss Amplitude_Imbalance Phase_Difference
.endc
.end