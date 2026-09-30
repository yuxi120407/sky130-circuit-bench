* Envelope Detector / Bias Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

VVDD VDD 0 1.8
VVIN N2 0 DC 0.9 AC 1 SIN(0.9 0.1 1MEG 0 0)
VBIAS N12 0 DC 0.9

* DUT
XM1 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N12 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N5 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUT N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 VDD N2 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VDD N3 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

* Loads to prevent floating nodes and set bias currents
R1 N1 0 10k
R3 N3 0 10k
R5 N5 0 10k
R7 N7 0 10k
R8 N8 0 10k
ROUT OUT 0 10k

.control
* DC Operating Point
op
let power = -i(VVDD) * 1.8
print power

* AC Analysis
ac dec 10 1k 1G
let gain_db = vdb(N7)
meas ac gain_100k find gain_db at=100k
meas ac gain_10M find gain_db at=10Meg

* Transient Analysis
tran 10n 5u
meas tran v_max max v(N7)
meas tran v_min min v(N7)

quit
.endc
.end