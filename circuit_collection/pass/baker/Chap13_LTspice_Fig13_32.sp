* Testbench for Fig 13.31
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0

.param W_xm1=1 W_xm3=1 W_xm5=1
.param L_xm1=0.15 L_xm3=0.15 L_xm5=0.15
.param W_xm2=2 W_xm4=2 W_xm6=2
.param L_xm2=0.15 L_xm4=0.15 L_xm6=0.15

Vin Vin 0 pulse(0 1.8 0.5n 50p 50p 1n 2.5n)

* DUT
xm1 N001 Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xm2 N001 Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xm3 Vout N001 N002 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 Vout N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
Cload Vout 0 5e-14
xm5 N002 VDD 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 Vout VDD VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}

.control
tran 10p 3n
meas tran tPLH trig v(Vin) val=0.9 rise=1 targ v(Vout) val=0.9 rise=1
meas tran tPHL trig v(Vin) val=0.9 fall=1 targ v(Vout) val=0.9 fall=1
print tPLH tPHL
quit
.endc
.end
