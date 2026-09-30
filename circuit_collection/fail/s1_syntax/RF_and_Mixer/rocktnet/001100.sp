* Dual-Band LNA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=100.0 L_xm1=0.15
.param W_xm2=200.0 L_xm2=0.15

* DUT (Adapted for SKY130 CMOS)
M1 n0 label_net_0 n2 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
M2 n4 n1 label_net_1 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
R1 n2 n4 20
R2 n1 n4 500
C1 n3 n5 10p
C2 n2 n4 2p
C3 n0 n5 1p
R3 n0 n3 100

* Biasing and Supplies
Vdd n3 0 1.8
Vss n5 0 0
Vss2 label_net_1 0 0
Vbias label_net_0 0 1.2

* RF Input (AC coupled, 50 ohm source)
Vac in 0 dc 0 ac 2
Rsrc in n1_ac 50
Cin n1_ac n1 10p

* RF Output (AC coupled, 50 ohm load)
Cout n0 out_ac 10p
Rload out_ac 0 50

.control
* DC Operating Point for Power
op
let power = -i(Vdd) * 1.8
print power

* AC Analysis for Gain and S11
ac dec 50 100MEG 10G
let gain_db = vdb(out_ac)
meas ac max_gain max gain_db
meas ac gain_900m find gain_db at=900MEG
meas ac gain_1900m find gain_db at=1.9G

* S11 approximation: V(n1_ac) should be 1V if perfectly matched (since Vac=2V and Rsrc=50).
* Reflection coefficient Gamma = (Zin - 50)/(Zin + 50) = V(n1_ac) - 1
let s11_mag = mag(v(n1_ac) - 1)
let s11_db = 20 * log10(s11_mag)
meas ac s11_900m find s11_db at=900MEG
meas ac s11_1900m find s11_db at=1.9G

* Noise Analysis
noise v(out_ac) Vac dec 10 100MEG 10G
setplot noise1
* Calculate Noise Figure in dB (4*k*T*50 at 298.15K is ~8.23e-19)
let nf_db = 10 * log10(inoise_spectrum^2 / 8.23e-19)
meas noise nf_900m find nf_db at=900MEG
meas noise nf_1900m find nf_db at=1.9G

quit
.endc
.end
