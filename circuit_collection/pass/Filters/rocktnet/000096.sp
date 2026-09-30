* Passive Matching Network Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param C1_val=100f
.param C2_val=100f
.param C3_val=100f
.param R1_val=10
.param R2_val=10
.param L1_val=100p
.param L2_val=100p

* DUT
C1 n1 GND {C1_val}
L1 n0 label_net_0 {L1_val}
C2 n1 n3 {C2_val}
R1 n0 n2 {R1_val}
R2 n1 label_net_1 {R2_val}
C3 n0 GND {C3_val}
L2 n2 n3 {L2_val}

* Sources and Terminations (50 ohm system)
V_in label_net_0_src 0 dc 0.9 ac 2
R_S label_net_0_src label_net_0 50
V_out label_net_1_src 0 dc 0.9
R_L label_net_1 label_net_1_src 50

.control
ac dec 100 1G 200G

let vout_db = db(v(label_net_1))
meas ac peak_gain MAX vout_db
meas ac center_frequency MAX_AT vout_db

let target_gain = peak_gain - 3 + 0*vout_db

meas ac f1 WHEN vout_db=target_gain RISE=1
meas ac f2 WHEN vout_db=target_gain FALL=1

let bandwidth = f2 - f1
let insertion_loss = -peak_gain

print center_frequency insertion_loss bandwidth
.endc
.end