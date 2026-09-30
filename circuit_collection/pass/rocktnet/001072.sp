* LNA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Generic NPN model for simulation since netlist uses 'npn'
.model npn npn (is=1e-16 bf=100 tf=10p cje=50f cjc=50f)

* DUT (with component values added for simulation)
C1 n10 n14 10p
L1 n4 n13 5n
R1 n9 n12 200
C2 n4 n13 1.5p
R2 n6 n9 200
Q1 n6 n3 n8 npn
R3 n1 n11 10k
C3 n11 n13 10p
C4 n1 n13 10p
Q2 n12 n3 n0 npn
Q3 n0 n11 n2 npn
Q4 n8 n10 n7 npn
R4 n1 n10 10k
Q5 n6 n5 n0 npn
Q6 n12 n5 n8 npn
L2 n14 label_net_0 10n
L3 n4 n7 1n
L4 n2 n4 1n

* DC Sources
Vvdd n9 0 1.8
Vgnd n13 0 0
Vbias_base n1 0 0.9
Vbias_casc1 n3 0 1.8
Vbias_casc2 n5 0 0
VLABEL_NET_0 label_net_0 0 0.9

* RF Input
Vac n14_src 0 dc 0 ac 1
Rsrc n14_src n14 50

.control
op
let power_w = -i(Vvdd) * 1.8
print power_w

ac dec 50 100MEG 10G
let vout_diff = v(n6) - v(n12)
let gain_db = 20*log10(mag(vout_diff))
meas ac gain_1p8G find gain_db at=1.8G
meas ac max_gain max gain_db
print gain_1p8G max_gain
.endc
.end
