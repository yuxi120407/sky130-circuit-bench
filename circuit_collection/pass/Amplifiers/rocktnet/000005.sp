* Common-Source Amplifiers Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5

XM1 N6 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N6 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}

VVDD VDD 0 1.8
Ibias VDD N1 10u
Vbias3 N3 0 1.18

* Self-biasing resistors for DC operating point
R1 N6 N0 100Meg
R2 N4 N5 100Meg

* AC coupling capacitors
C1 in1 N0 1
C2 in2 N5 1

* Input sources (DC=0, AC=1, Sine for Tran)
V1 in1 0 dc 0 ac 1 sin(0 1m 1Meg)
V2 in2 0 dc 0 ac 1 sin(0 1m 1Meg)

* Load capacitors
CL1 N6 0 10f
CL2 N4 0 10f

.control
op
let power = -i(VVDD) * 1.8
print power
print v(N6) v(N4) v(N0) v(N5) v(N1) v(N3)

ac dec 100 1k 10G
let gain1_db = vdb(N6)
let gain2_db = vdb(N4)

meas ac dc_gain1 find gain1_db at=10k
meas ac dc_gain2 find gain2_db at=10k

meas ac ugf1 when gain1_db=0 fall=1
meas ac ugf2 when gain2_db=0 fall=1

tran 10n 5u
meas tran out1_pp pp v(N6) from=2u to=5u
meas tran out2_pp pp v(N4) from=2u to=5u

quit
.endc
.end
