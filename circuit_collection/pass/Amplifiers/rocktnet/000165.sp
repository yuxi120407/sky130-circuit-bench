* Testbench for Capacitive Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Idealized fully differential amplifier macro-model
.subckt amplifier in_p in_n out_n out_p
E1 out_p 0 vol='0.9 + 1000*(v(in_p)-v(in_n))'
E2 out_n 0 vol='0.9 - 1000*(v(in_p)-v(in_n))'
.ends

* DUT (Capacitor values appended to prevent syntax errors)
X1 n2 n3 n0 n1 amplifier
C1 n1 n3 1p
C2 n3 label_net_0 1p
C3 n1 GND 1p
C4 n0 n2 1p
C5 n0 GND 1p
C6 n2 label_net_1 1p

* DC bias resistors to stabilize operating point (1 Gohm)
Rfb1 n1 n3 1G
Rfb2 n0 n2 1G

* Input sources
VLABEL_NET_0 label_net_0 0 dc 0.9 ac 1 sin(0.9 0.1 10Meg)
VLABEL_NET_1 label_net_1 0 dc 0.9 ac -1 sin(0.9 -0.1 10Meg)

* Difference amplifiers for differential measurement
E_out_diff out_diff 0 vol='v(n1)-v(n0)'
E_in_diff in_diff 0 vol='v(label_net_0)-v(label_net_1)'

* Dummy VDD for power measurement
Vdd vdd 0 1.8
Rdummy vdd 0 1k

.control
op
print v(n1) v(n0) v(n2) v(n3)

ac dec 10 1k 1G
let gain_db = vdb(out_diff) - vdb(in_diff)
meas ac midband_gain find gain_db at=1Meg
meas ac bw_3db when gain_db='midband_gain-3' fall=1

tran 1n 200n
meas tran vout_max max v(out_diff)
meas tran vout_min min v(out_diff)

let power = -i(Vdd) * 1.8
print power

quit
.endc
.end