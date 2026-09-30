* Testbench for Bipolar Mixer Sub-circuit
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.model npn npn (is=1e-16 bf=100 vaf=50 cjc=1p cje=2p fT=10G)

* DUT with appended resistor values
Q1 n0 label_net_0 n5 npn
Q2 n0 label_net_1 n2 npn
R1 n2 n3 100
R2 n3 n5 100
Q3 label_net_2 n0 n8 npn
Q4 label_net_3 n0 n7 npn
R3 n0 label_net_4 1k
Q5 n1 n1 n6 npn
R4 n0 label_net_5 1k
R5 n7 label_net_6 1k
R6 n1 label_net_7 1k
R7 n8 label_net_8 1k
R8 n4 0 100
R9 n6 0 100
Q6 n3 n1 n4 npn

* Supply and Bias Sources
V_label_net_2 label_net_2 0 dc 1.8
V_label_net_3 label_net_3 0 dc 1.8
V_label_net_4 label_net_4 0 dc 1.8
V_label_net_5 label_net_5 0 dc 1.8
V_label_net_7 label_net_7 0 dc 1.8

V_label_net_6 label_net_6 0 dc 0
V_label_net_8 label_net_8 0 dc 0

* Input Sources (Differential drive for Conversion Gain, Common-mode for AC Bandwidth)
V_label_net_0 label_net_0 0 dc 0.9 ac 1 sin(0.9 0.05 10Meg 0 0 0)
V_label_net_1 label_net_1 0 dc 0.9 ac 1 sin(0.9 0.05 10Meg 0 0 180)

.control
* 1. DC Operating Point & Power
op
let total_current = -(i(V_label_net_2) + i(V_label_net_3) + i(V_label_net_4) + i(V_label_net_5) + i(V_label_net_7))
let Power_Consumption = total_current * 1.8
print Power_Consumption

* 2. AC Analysis for Bandwidth
ac dec 20 1Meg 100Gig
let gain_db = db(v(n8))
meas ac max_gain max gain_db
meas ac bw_3db when gain_db=(max_gain-3) fall=1
let Bandwidth = bw_3db
print Bandwidth

* 3. Transient Analysis for Conversion Gain
tran 0.1n 500n
meas tran ymax max v(n8) from=300n to=500n
meas tran ymin min v(n8) from=300n to=500n
let vout_amp = (ymax - ymin) / 2
let Conversion_Gain = 20 * log10(vout_amp / 0.1)
print Conversion_Gain

quit
.endc
.end