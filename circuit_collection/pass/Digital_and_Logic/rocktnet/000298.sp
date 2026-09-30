* Dynamic Latch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.15
.param L_xm2=0.15
.param L_xm3=0.15
.param L_xm4=0.15
.param L_xm5=0.15

.param W_xm2=5.0
.param W_xm5=2.0
.param W_xm3=5.0
.param W_xm4=2.0
.param W_xm1=5.0

VVDD VDD 0 1.8
VCK CK 0 PULSE(0 1.8 0 20p 20p 292.5p 625p)
VD D 0 PULSE(0 1.8 500p 20p 20p 605p 1250p)
VDBAR D_BAR 0 PULSE(1.8 0 500p 20p 20p 605p 1250p)

XM2 Q_BAR D N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM5 Q Q_BAR VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM3 Q D_BAR N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 Q_BAR Q VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM1 N1 CK GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

C1 Q 0 10f
C2 Q_BAR 0 10f

.ic v(Q)=0 v(Q_BAR)=1.8 v(N1)=0

.control
tran 5p 3n
let pwr = -i(VVDD)*1.8
meas tran avg_pwr avg pwr from=0.6n to=3n
meas tran delay_ck_q trig v(CK) val=0.9 rise=2 targ v(Q) val=0.9 rise=1
meas tran q_max max v(Q) from=0.6n to=3n
meas tran q_min min v(Q) from=0.6n to=3n
print avg_pwr delay_ck_q q_max q_min
quit
.endc
.end