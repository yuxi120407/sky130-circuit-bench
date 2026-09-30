* Testbench for Self-Biased Differential Input Buffer
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

* Define parameters based on text (NMOS 10/1, PMOS 20/1, L=0.15)
.param W_xm1=1.5 L_xm1=0.15
.param W_xm2=1.5 L_xm2=0.15
.param W_xm3=3.0 L_xm3=0.15
.param W_xm4=3.0 L_xm4=0.15
.param W_xm6=1.5 L_xm6=0.15
.param W_xm5=3.0 L_xm5=0.15
.param W_xm7=1.5 L_xm7=0.15

* DUT Netlist
xm1 N001 Vinm N003 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xm3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm2 N002 Vinp N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
Vinm Vinm 0 0.9
xm6 N003 N001 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm5 Vout N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
xm7 Vout N002 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
Cload Vout 0 5e-14

* Stimulus for Vinp (DC for sweep, Pulse for transient)
Vinp Vinp 0 dc 0.9 pulse(0 1.8 1n 50p 50p 2n 4n)

.control
* 1. DC Analysis for Offset Voltage and Logic States
dc Vinp 0 1.8 0.01
meas dc logic_high_state find v(Vout) at=1.8
meas dc logic_low_state find v(Vout) at=0
meas dc v_switch find v(Vinp) when v(Vout)=0.9
let input_offset_voltage = v_switch - 0.9
print logic_high_state logic_low_state input_offset_voltage

* 2. Transient Analysis for Propagation Delay
tran 10p 10n
meas tran propagation_delay_tplh trig v(Vinp) val=0.9 rise=1 targ v(Vout) val=0.9 rise=1
meas tran propagation_delay_tphl trig v(Vinp) val=0.9 fall=1 targ v(Vout) val=0.9 fall=1
print propagation_delay_tplh propagation_delay_tphl

quit
.endc
.end