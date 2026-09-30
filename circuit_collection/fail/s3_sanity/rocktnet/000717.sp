* SiGe Bipolar LNA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param W_xm1=1 L_xm1=1

* Generic BJT models for simulation
.model npn npn (is=1e-16 bf=100 tf=1p cje=10f cjc=10f)
.model pnp pnp (is=1e-16 bf=50 tf=2p cje=10f cjc=10f)

* DUT (with assumed component values for missing parameters)
R1 n3 label_net_0 1k
R2 n2 label_net_1 1k
Q1 n5 n2 n12 npn
R3 n3 label_net_2 1k
R4 n1 n7 1k
Q2 n2 n2 n1 npn
R5 n0 label_net_3 1k
Q3 n1 label_net_4 n1 npn
C1 n8 n9 1p
C2 n0 label_net_5 1p
R6 n6 label_net_6 100
C3 n3 label_net_7 1p
C4 n10 n2 1p
Q4 n12 n9 n6 npn
C5 n2 n12 1p
C6 n1 label_net_8 1p
R7 n5 n10 500
L1 n8 n11 1n
R8 n0 n8 1k
Q5 n11 n3 n13 pnp
R9 n4 label_net_9 1k
R10 n1 label_net_4 1k
R11 n0 n10 500
R12 n4 n13 1k

* Fix floating nodes from extraction
Rfix_n9 n9 label_net_1 100k
Rfix_n7 n7 0 1G

* VDD
Vvdd0 n0 0 1.8
Vvdd4 n4 0 1.8

* Bias
VLABEL_NET_0 label_net_0 0 0.9
VLABEL_NET_1 label_net_1 0 0.9
VLABEL_NET_2 label_net_2 0 0.9
VLABEL_NET_3 label_net_3 0 0.9
VLABEL_NET_4 label_net_4 0 0.9
VLABEL_NET_5 label_net_5 0 0.9
VLABEL_NET_6 label_net_6 0 0
VLABEL_NET_7 label_net_7 0 0.9
VLABEL_NET_8 label_net_8 0 0.9
VLABEL_NET_9 label_net_9 0 0.9

* Input
Vin in_src 0 dc 0 ac 1 sin(0 10m 60G)
Rsrc in_src in 50
Cin in n8 1p

* Load
Cload n5 0 10f

.control
op
let power_consumption = -(i(Vvdd0) + i(Vvdd4)) * 1.8
print power_consumption

ac dec 20 1G 100G
let gain_db = vdb(n5) - vdb(in_src)
meas ac voltage_gain find gain_db at=60G
print voltage_gain

noise v(n5) Vin dec 20 1G 100G
setplot noise1
let nf_db = 10 * log10((inoise_spectrum * inoise_spectrum) / 8.288e-19)
meas noise noise_figure find nf_db at=60G
print noise_figure

quit
.endc
.end