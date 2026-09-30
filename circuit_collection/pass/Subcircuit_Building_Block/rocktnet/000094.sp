* Passive Bias and Coupling Network Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* DUT (Values added for simulation)
R1 n0 label_net_0 10k
C1 n0 0 1p
C2 n0 label_net_1 10n
C3 n1 label_net_2 10n
R2 n1 0 10k
R3 n0 0 10k

* Sources
Vbias label_net_0 0 1.8
Vin label_net_1 0 dc 0 ac 1
Vtest n1 0 dc 0 ac 1
Rload label_net_2 0 50

.control
* DC Operating Point
op
print v(n0)
let v_bias_n0 = v(n0)

* AC Analysis
ac dec 20 1k 1G
let gain_in_db = vdb(n0)
let gain_out_db = vdb(label_net_2)

* Input Network Metrics
meas ac midband_gain_in find gain_in_db at=1MEG
let target_hp_in = midband_gain_in - 3
meas ac f3db_hp_in when gain_in_db=target_hp_in rise=1
let target_lp_in = midband_gain_in - 3
meas ac f3db_lp_in when gain_in_db=target_lp_in fall=1

* Output Network Metrics
meas ac midband_gain_out find gain_out_db at=10MEG
let target_hp_out = midband_gain_out - 3
meas ac f3db_hp_out when gain_out_db=target_hp_out rise=1

quit
.endc
.end