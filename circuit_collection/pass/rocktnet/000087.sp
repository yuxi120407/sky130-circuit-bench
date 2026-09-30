* Passive RC Network Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param c2_val=1p
.param c3_val=1p
.param r1_val=10k
.param r2_val=10k
.param r3_val=10k
.param r4_val=10k

* Parameterized passive values (defaults provided for simulation)
.param c1_val=1p c2_val=1p c3_val=1p r1_val=50 r2_val=50 r3_val=50 r4_val=50

* DUT
C1 n0 n3 {c1_val}
C2 n0 label_net_0 {c2_val}
C3 n1 n2 {c3_val}
R1 n3 0 {r1_val}
R2 n0 n1 {r2_val}
R3 n3 0 {r3_val}
R4 n2 0 {r4_val}

* DC Bias
VLABEL_NET_0 label_net_0 0 0.9

* AC Source and Load (50 ohm system)
* Vac=2V with 50 ohm source and 50 ohm load gives 0dB (1V) at load if perfectly matched/lossless
Vac n0_src 0 dc 0 ac 2
Rsrc n0_src n0 50
Rload n1 0 50

.control
ac dec 100 100M 10G

* Calculate S21 (Insertion Loss)
let s21_db = vdb(n1)

* Calculate S11 (Return Loss)
* V(n0) = Vsrc * Zin / (Zin + 50) = 2 * Zin / (Zin + 50)
* S11 = (Zin - 50) / (Zin + 50) = V(n0) - 1
let s11_vec = v(n0) - 1
let s11_mag = mag(s11_vec)
let s11_db = 20 * log10(s11_mag + 1e-12)

* Measure at 2.4 GHz
meas ac s21_2_4G find s21_db at=2.4G
meas ac s11_2_4G find s11_db at=2.4G

print s21_2_4G s11_2_4G
quit
.endc
.end
