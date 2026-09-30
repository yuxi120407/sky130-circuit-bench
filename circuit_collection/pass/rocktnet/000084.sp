* LNA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Generic NPN model since SKY130 doesn't have a simple 'npn' device
.model npn npn (bf=100 is=1e-14 vaf=50 cjc=10f cje=20f)

* DUT
Q1 n4 n0 n3 npn
Q2 n1 n1 n4 npn
Q3 n2 n1 n0 npn
Q4 n0 n4 0 npn
R1 n3 0 50
R2 n1 n2 1k
I1 label_net_0 n2 5m

* Biasing and Supplies
V_vdd label_net_0 0 1.8

* RF Input (AC and Transient)
V_in in_src 0 dc 0 ac 1 sin(0 10m 900Meg)
R_in in_src in_ac 50
C_in in_ac n4 10p

* RF Output
C_out n2 out_ac 10p
R_load out_ac 0 50

.control
* DC Analysis
op
let power_dc = -i(V_vdd) * 1.8
print power_dc

* AC Analysis
ac dec 50 100Meg 10Gig
let gain_db = db(v(out_ac))
meas ac gain_900m find gain_db at=900Meg
meas ac gain_1_9g find gain_db at=1.9Gig
print gain_900m gain_1_9g

* Noise Analysis
noise v(out_ac, 0) V_in dec 50 100Meg 10Gig
setplot noise1
* Calculate NF in dB (8e-19 is 4*k*T*50 at 290K)
let nf_db = 10 * log10((inoise_spectrum^2) / 8e-19)

* Switch to AC plot to measure noise vectors safely
setplot ac1
let nf_db = noise1.nf_db
meas ac nf_900m find nf_db at=900Meg
meas ac nf_1_9g find nf_db at=1.9Gig
print nf_900m nf_1_9g

quit
.endc
.end