* AC-Coupled Hybrid Envelope Modulator Filter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param VDD=1.8
.param RVAL=10k
.param CVAL=1p

* Power Supplies and Bias
Vvdd vdd 0 dc {VDD}
VLABEL_NET_0 label_net_0 0 dc 0.9
VLABEL_NET_1 label_net_1 0 dc 0.9

* Dummy load to ensure non-zero power consumption for ideal macro-models
R_dummy vdd 0 1k

* Inputs
Vin1 n11 0 dc 0.9 ac 0
Vin2 n4 0 dc 0.9 ac 0
Vin3 n8 0 dc 0.9 ac 0
Vin4 n6 0 dc 0.9 ac 1

* Amplifier Macro-model
.subckt amplifier out in_minus in_plus
E1 out 0 in_plus in_minus 100k
.ends

* DUT (Netlist with added values for R and C)
X1 n10 n1 n7 amplifier
X2 n3 label_net_0 n0 amplifier
X3 n9 n5 n3 amplifier
R1 n6 n7 {RVAL}
R2 n2 n4 {RVAL}
R3 n1 n1 {RVAL}
R4 n7 n8 {RVAL}
R5 n0 n3 {RVAL}
R6 n10 n11 {RVAL}
C1 n8 n10 {CVAL}
R7 n5 n5 {RVAL}
R8 n6 n9 {RVAL}
R9 n3 n3 {RVAL}
R10 n0 label_net_1 {RVAL}
C2 n10 0 {CVAL}
R11 n1 n2 {RVAL}
R12 n5 0 {RVAL}
C3 n1 0 {CVAL}
C4 n0 n3 {CVAL}
C5 n11 0 {CVAL}
C6 n7 n10 {CVAL}
C7 n4 0 {CVAL}
* Replaced ideal switch with a resistor for linear analysis
R_S1 n6 n7 1k

.control
* DC Operating Point
op
let power_consumption = -i(Vvdd) * 1.8
print power_consumption

* AC Analysis
ac dec 20 0.1 100Meg
let gain_db = db(v(n10))
meas ac dc_gain find gain_db at=0.1
meas ac max_gain max gain_db
let gain_3db = $&max_gain - 3
meas ac bandwidth when gain_db="$&gain_3db" fall=1
print dc_gain bandwidth

quit
.endc
.end