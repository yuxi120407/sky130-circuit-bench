* 3-input NOR gate testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.15
.param L_xm2=0.15
.param L_xm3=0.15
.param L_xm4=0.15
.param L_xm5=0.15
.param L_xm6=0.15

.param W_xm1=1
.param W_xm2=1
.param W_xm3=1
.param W_xm4=1
.param W_xm5=1
.param W_xm6=1

* DUT Netlist
Vin Vin 0 pulse(0 1.8 1n 0.1n 0.1n 2n 4n)
VDD VDD 0 1.8
xm6 P001 Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
xm1 Vout Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 Vout Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 Vout Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm5 P002 Vin P001 VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
xm4 Vout Vin P002 VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}

* Load capacitance (50fF as used in textbook examples)
Cload Vout 0 50f

.control
* DC Analysis for V_SP
dc Vin 0 1.8 0.01
meas dc switching_point_voltage when v(Vout)=v(Vin)
print switching_point_voltage

* Transient Analysis for delays
tran 10p 10n
meas tran t_PHL trig v(Vin) val=0.9 rise=1 targ v(Vout) val=0.9 fall=1
meas tran t_PLH trig v(Vin) val=0.9 fall=1 targ v(Vout) val=0.9 rise=1
print t_PHL t_PLH

quit
.endc
.end