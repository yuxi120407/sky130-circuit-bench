* Testbench for Extracted Passive Network
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param c_val=100f r_val=100 l_val=1n

* DUT
C1 n0 GND {c_val}
R1 n1 n2 {r_val}
C2 n1 n2 {c_val/10}
C3 n1 GND {c_val/2}
C4 n2 GND {c_val/2}
L1 n0 label_net_0 {l_val}
* Modified switch syntax to include control nodes for ngspice compatibility
S1 n1 GND ctrl GND switch_ideal
L2 n1 n2 {l_val}

.model switch_ideal sw vt=0.5 ron=0.1 roff=1G

* Biasing and Sources
VLABEL_NET_0 label_net_0 0 dc 0.9
Vctrl ctrl 0 dc 0
Iac 0 n1 dc 0 ac 1 sin(0 10m 1G)
Rload n2 n2_load 50
Vn2 n2_load 0 dc 0

.control
* AC Analysis
alter Rload 1e-3
ac dec 100 100Meg 100Gig

* Calculate Impedance Z11 (since Iac = 1A, Z11 = V(n1))
let ReZ = real(v(n1))
let ImZ = imag(v(n1))
let Q_factor = ImZ / ReZ
let L_ind = ImZ / (2 * pi * frequency)

* Measure metrics
meas ac max_Q max Q_factor
meas ac SRF when ImZ=0 fall=1
meas ac L_at_1G find L_ind at=1G

* Transient Analysis
alter Rload 50
tran 10p 100n

let p_in_inst = v(n1) * 10m * sin(2*pi*1e9*time)
let p_out_inst = v(n2) * i(Vn2)
let p_dc_inst = -(v(label_net_0)*i(VLABEL_NET_0) + v(ctrl)*i(Vctrl))

meas tran Pin avg p_in_inst from=80n to=100n
meas tran Pout avg p_out_inst from=80n to=100n
meas tran Pdc avg p_dc_inst from=80n to=100n

meas tran PAE param='100 * (Pout - Pin) / (Pdc + 1e-12)'

print max_Q SRF L_at_1G Pin Pout Pdc PAE
quit
.endc
.end