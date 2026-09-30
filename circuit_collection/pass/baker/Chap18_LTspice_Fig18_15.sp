* Fig 18.15 Skew in Logic Gates - NAND Gate Input Delay Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

* Sizing parameters
.param W_xm1=2.0 L_xm1=0.15
.param W_xm2=2.0 L_xm2=0.15
.param W_xm3=2.0 L_xm3=0.15
.param W_xm4=2.0 L_xm4=0.15
.param W_xm5=2.0 L_xm5=0.15
.param W_xm6=2.0 L_xm6=0.15
.param W_xm7=2.0 L_xm7=0.15
.param W_xm8=2.0 L_xm8=0.15

* DUT Netlist from prompt
xm1 N001 A 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xm2 Outa A VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xm3 Outa B VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 Outa B N001 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm5 N002 B 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 Outb B VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
xm7 Outb A VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 Outb A N002 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
VB B 0 1.8
C1 Outa 0 5e-14
C2 Outb 0 5e-14

* Input stimulus: step pulse on A starting at 0.5ns with 100ps rise time
VA A 0 pulse(0 1.8 0.5n 100p 100p 2n 4n)

* Control script
.control
tran 10p 1.5n 0 10p

* Propagation delays from 50% Vin (0.9V) to 50% Vout (0.9V)
meas tran tPHL_A trig v(A) val=0.9 rise=1 targ v(Outa) val=0.9 fall=1
meas tran tPHL_B trig v(A) val=0.9 rise=1 targ v(Outb) val=0.9 fall=1

* Input-dependent skew
let skew_tPHL = tPHL_B - tPHL_A
print tPHL_A tPHL_B skew_tPHL

* Fall times (90% to 10% of 1.8V -> 1.62V to 0.18V)
meas tran fall_time_outa trig v(Outa) val=1.62 fall=1 targ v(Outa) val=0.18 fall=1
meas tran fall_time_outb trig v(Outb) val=1.62 fall=1 targ v(Outb) val=0.18 fall=1
print fall_time_outa fall_time_outb

quit
.endc
.end
