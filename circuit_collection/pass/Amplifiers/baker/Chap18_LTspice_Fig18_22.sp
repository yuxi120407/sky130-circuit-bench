* Testbench for PMOS Input Buffer (Fig 18.21)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

* Define parameters for the parameterized netlist
.param W_xm1=2.0 L_xm1=0.15
.param W_xm2=2.0 L_xm2=0.15
.param W_xm3=4.0 L_xm3=0.15
.param W_xm4=4.0 L_xm4=0.15
.param W_xm5=4.0 L_xm5=0.15
.param W_xm6=8.0 L_xm6=0.15
.param W_xm7=2.0 L_xm7=0.15

* --- DUT Netlist ---
xm1 N003 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xm3 N003 Vinm N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 N002 Vinp N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm2 N002 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
Vinm Vinm 0 200m
xm5 Vout N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
xm7 Vout N002 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
Cload Vout 0 5e-14
xm6 N001 N003 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
* -------------------

* Input stimulus for transient analysis
Vinp Vinp 0 PULSE(0.0 0.4 2n 0.1n 0.1n 4n 10n)

.control
* 1. DC Analysis for Logic Levels and Offset
dc Vinp 0 0.4 0.001
meas dc logic_low min v(Vout)
meas dc logic_high max v(Vout)
* Find switching threshold (Vout = VDD/2 = 0.9V)
meas dc vswitch find v(Vinp) when v(Vout)=0.9
* Calculate offset relative to Vinm (200mV)
let dc_offset = vswitch - 0.2
print logic_low logic_high dc_offset

* 2. Transient Analysis for Propagation Delays
tran 10p 10n
* Measure tPLH: Vinp goes high (crossing 200mV), Vout goes high (crossing 0.9V)
meas tran tplh trig v(Vinp) val=0.2 rise=1 targ v(Vout) val=0.9 rise=1
* Measure tPHL: Vinp goes low (crossing 200mV), Vout goes low (crossing 0.9V)
meas tran tphl trig v(Vinp) val=0.2 fall=1 targ v(Vout) val=0.9 fall=1
print tplh tphl

quit
.endc
.end