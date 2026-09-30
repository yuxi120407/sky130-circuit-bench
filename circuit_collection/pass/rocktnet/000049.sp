* Testbench for extracted differential pair
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

* DUT
XM1 N1 GND N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 LABEL_NET_0 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

* Sources and Loads (Resistors added to replace missing inductors)
VVDD VDD 0 1.8
R1 VDD N1 1k
R2 VDD N2 1k

* Bias and Input
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_0 LABEL_NET_0 0 dc 0.9 ac 1 sin(0.9 0.1 1Meg)

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

.control
op
let id_tail = -i(VVDD)
let v_n2 = v(N2)
let v_n0 = v(N0)
let power = -i(VVDD) * 1.8
print id_tail v_n2 v_n0 power

ac dec 10 1k 1G
let gain_db = vdb(N2)
meas ac midband_gain find gain_db at=1Meg

tran 10n 5u
meas tran v_max max v(N2)
meas tran v_min min v(N2)
quit
.endc
.end