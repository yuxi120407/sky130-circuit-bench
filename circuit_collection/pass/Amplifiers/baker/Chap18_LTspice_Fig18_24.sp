* Rail-to-rail input buffer testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Circuit Netlist
.subckt rr_inbuf vinp vinm vout VDD GND
* N-flavor self-biased diff amp
XM1 n1 vinm tail_n GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM2 out_diff vinp tail_n GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM3 n1 n1 VDD VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
XM4 out_diff n1 VDD VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
XM5 tail_n n1 GND GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15

* P-flavor self-biased diff amp
XM6 p1 vinm tail_p VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
XM7 out_diff vinp tail_p VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
XM8 p1 p1 GND GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM9 out_diff p1 GND GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM10 tail_p p1 VDD VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15

* Output inverter
XM11 vout out_diff VDD VDD sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
XM12 vout out_diff GND GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
.ends

X1 vinp vinm vout VDD 0 rr_inbuf

* Stimuli
VDD VDD 0 1.8
Vref vinm 0 0.9
Vinp vinp 0 dc 0.9 pulse(0 1.8 1n 100p 100p 4n 10n)

* Control block
.control
* DC Analysis
dc Vinp 0 1.8 0.01

* logic_high_state and logic_low_state
meas dc logic_high_state when v(vout)=1.62
meas dc logic_low_state when v(vout)=0.18

* input_offset_voltage
meas dc vth when v(vout)=0.9
let input_offset_voltage = vth - 0.9
print logic_high_state logic_low_state input_offset_voltage

* Transient Analysis
tran 10p 10n

* propagation_delay_tPLH
meas tran propagation_delay_tPLH trig v(vinp) val=0.9 rise=1 targ v(vout) val=0.9 rise=1

* propagation_delay_tPHL
meas tran propagation_delay_tPHL trig v(vinp) val=0.9 fall=1 targ v(vout) val=0.9 fall=1

* delay_skew
let delay_skew = propagation_delay_tPLH - propagation_delay_tPHL
print propagation_delay_tPLH propagation_delay_tPHL delay_skew

.endc
.end