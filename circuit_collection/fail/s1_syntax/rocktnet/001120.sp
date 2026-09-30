* CML AND Gate Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param R_load=400
.param R_deg=200
.param W=5.0
.param L=0.15
.param W_tail=10.0

* DUT (Adapted to standard MOSFET syntax for SKY130)
R1 Q VCC {R_load}
R3 Q_BAR VCC {R_load}
R2 N1 GND {R_deg}
M1 Q_BAR A N4 GND sky130_fd_pr__nfet_01v8 w=W l=L
M2 Q A_BAR N4 GND sky130_fd_pr__nfet_01v8 w=W l=L
M3 Q B_BAR N3 GND sky130_fd_pr__nfet_01v8 w=W l=L
M4 N3 Bias N1 GND sky130_fd_pr__nfet_01v8 w={W_tail} l=L
M5 N4 B N3 GND sky130_fd_pr__nfet_01v8 w=W l=L

* Sources
VCC VCC 0 1.8
VBias Bias 0 0.8

* Inputs (B is the lower pair, A is the upper pair)
V_B B 0 pulse(0.6 1.2 0 20p 20p 980p 2n)
V_B_BAR B_BAR 0 pulse(1.2 0.6 0 20p 20p 980p 2n)

V_A A 0 pulse(1.2 1.8 250p 20p 20p 480p 1n)
V_A_BAR A_BAR 0 pulse(1.8 1.2 250p 20p 20p 480p 1n)

.control
op
let power = -i(VCC) * 1.8
print power

tran 5p 3n
* Measure delay when B is high (Q follows A)
meas tran delay_rise trig v(A) val=1.5 rise=1 targ v(Q) val=1.5 rise=1
meas tran delay_fall trig v(A) val=1.5 fall=1 targ v(Q) val=1.5 fall=1

* Measure voltage swing
meas tran swing_max max v(Q)
meas tran swing_min min v(Q)
let swing = swing_max - swing_min
print swing
quit
.endc
.end
