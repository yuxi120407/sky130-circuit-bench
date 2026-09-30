* LC Matching Network Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Component values chosen for ~3.5GHz resonance
.param R_val=50 L_val=1.5n C1_val=1.5p C2_val=1.5p

* DUT
R1 n0 0 {R_val}
C1 n1 0 {C1_val}
L1 n0 n1 {L_val}
C2 n1 label_net_0 {C2_val}

* AC Input Source
Vac label_net_0 0 dc 0 ac 1

.control
* AC Analysis from 100MHz to 10GHz
ac dec 100 100Meg 10Gig

* Calculate Voltage Gain in dB
let gain_db = vdb(n0)

* Measure Peak Gain (Insertion Loss) and Resonance Frequency
meas ac insertion_loss max gain_db
meas ac resonance_frequency max_at gain_db

* Measure 3dB Bandwidth
meas ac f_low when gain_db='insertion_loss - 3' rise=1
meas ac f_high when gain_db='insertion_loss - 3' fall=1
meas ac bandwidth_3db param='f_high - f_low'

print insertion_loss resonance_frequency bandwidth_3db

quit
.endc
.end