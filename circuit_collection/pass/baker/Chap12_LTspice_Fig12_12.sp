* 3-input NAND testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm5=5.0
.param W_xm6=5.0

* Define parameters for W and L to resolve netlist variables
.param W_xm4=1 W_xm5=1 W_xm6=1 W_xm1=1 W_xm2=1 W_xm3=1
.param L_xm4=0.15 L_xm5=0.15 L_xm6=0.15 L_xm1=0.15 L_xm2=0.15 L_xm3=0.15

* DUT
VDD VDD 0 1.8
xm4 Vout Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm1 P001 Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 P002 Vin P001 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 Vout Vin P002 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm5 Vout Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
xm6 Vout Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
Cload Vout 0 5e-14

* Stimulus
Vin Vin 0 PULSE(0 1.8 0.5n 50p 50p 2n 4n)

* Dummy source to calculate Vout - Vin for exact V_SP measurement
B1 diff 0 V=v(Vout)-v(Vin)

.control
  * DC Analysis for V_SP
  dc Vin 0 1.8 0.01
  meas dc vsp find v(Vin) when v(diff)=0
  print vsp

  * Transient Analysis for delays
  tran 10p 5n
  meas tran t_phl trig v(Vin) val=0.9 rise=1 targ v(Vout) val=0.9 fall=1
  meas tran t_plh trig v(Vin) val=0.9 fall=1 targ v(Vout) val=0.9 rise=1
  print t_phl t_plh
  quit
.endc
.end