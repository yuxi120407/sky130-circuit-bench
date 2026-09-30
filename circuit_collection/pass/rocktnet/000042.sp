* LNA Testbench
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

* DUT
XM1 N0 LABEL_NET_1 N15 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N12 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N10 LABEL_NET_2 N11 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 N4 N14 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 N6 N14 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N13 N8 N10 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N7 N8 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

* Sources and Biasing
VVDD VDD 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 DC 0.9 AC 1 SIN(0.9 0.01 20Meg)
VLABEL_NET_2 LABEL_NET_2 0 DC 0.9 AC 0 SIN(0.9 0 20Meg)
V_N8 N8 0 DC 1.2
V_N4 N4 0 DC 0.9
V_N6 N6 0 DC 0.9
V_N1 N1 0 DC 0.9
V_N15 N15 0 0
V_N11 N11 0 0
V_N14 N14 0 0

* LNA Loads (Tuned to ~20MHz)
L1 VDD N7 10u
R1 VDD N7 5k
C1 N7 0 6.3p

L2 VDD N13 10u
R2 VDD N13 5k
C2 N13 0 6.3p

* Buffer/Mixer Loads
R3 VDD N3 1k
R4 VDD N2 1k
R5 VDD N12 1k

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.control
* DC Operating Point
op
let power = -i(VVDD) * 1.8
print power

* AC Analysis
ac dec 50 1Meg 100Meg
let gain_db = vdb(N7)
meas ac max_gain max gain_db
meas ac peak_freq max_at gain_db

* Transient Analysis
tran 1n 200n
meas tran v_max max v(N7)
meas tran v_min min v(N7)
let v_pp = v_max - v_min
print v_pp

quit
.endc
.end