* RF Switch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

.param W_xm1=5.0 L_xm1=0.5

* DUT
XM1 N1 LABEL_NET_0 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* Biasing and RF sources
Vsrc N1_ac 0 dc 0 ac 1
Rsrc N1_ac N1 50
Rload N2 0 50

* Gate Control
Vgate LABEL_NET_0 0 1.8

.control
* 1. Measure Ron (DC)
alter @Vgate[dc] = 1.8
alter @Vsrc[dc] = 0.1
op
let id = (v(N1_ac) - v(N1))/50
let ron = (v(N1) - v(N2)) / id
print ron

* 2. Measure Insertion Loss (AC ON State)
alter @Vsrc[dc] = 0
ac dec 50 100Meg 10Gig
let s21_on_db = vdb(N2) + 6.0206
meas ac insertion_loss_900mhz find s21_on_db at=900Meg

* 3. Measure Isolation and OFF Capacitance (AC OFF State)
alter @Vgate[dc] = 0
ac dec 50 100Meg 10Gig
let s21_off_db = vdb(N2) + 6.0206
meas ac isolation_900mhz find s21_off_db at=900Meg

let I_in = (v(N1_ac) - v(N1))/50
let Y_in = I_in / v(N1)
let C_off = imag(Y_in) / (2 * 3.14159265 * frequency)
meas ac off_cap_900mhz find C_off at=900Meg

print insertion_loss_900mhz isolation_900mhz off_cap_900mhz
quit
.endc
.end