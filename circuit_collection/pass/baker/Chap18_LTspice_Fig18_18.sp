* Self-biased diff-amp input buffer testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.15
.param W_xm1=1.5
.param L_xm2=0.15
.param W_xm2=1.5
.param L_xm3=0.15
.param W_xm3=3.0
.param L_xm4=0.15
.param W_xm4=3.0
.param L_xm5=0.15
.param W_xm5=3.0
.param L_xm6=0.15
.param W_xm6=1.5
.param L_xm7=0.15
.param W_xm7=1.5

* DUT Netlist
xm1 N001 Vinm N003 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
Vinp Vinp 0 dc 0.9 pulse(0 1.8 1n 0.1n 0.1n 4n 10n)
VDD VDD 0 1.8
xm3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm2 N002 Vinp N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
Vinm Vinm 0 0.9
xm6 N003 N001 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm5 Vout N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
xm7 Vout N002 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}

* Load capacitance (50fF from Fig 18.19)
Cload Vout 0 50f

.control
* 1. DC Analysis for Offset (Fig 18.18)
dc Vinp 0 1.8 0.001
meas dc logic_high_threshold find v(Vinp) when v(Vout)=0.9
meas dc logic_low_threshold find v(Vinp) when v(Vout)=0.9
let input_offset_voltage = logic_high_threshold - 0.9
print logic_high_threshold logic_low_threshold input_offset_voltage

* 2. Transient Analysis for Delays (Fig 18.19)
tran 10p 10n
meas tran tPLH trig v(Vinp) val=0.9 rise=1 targ v(Vout) val=0.9 rise=1
meas tran tPHL trig v(Vinp) val=0.9 fall=1 targ v(Vout) val=0.9 fall=1
print tPLH tPHL

quit
.endc
.end