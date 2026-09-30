* Testbench for D-FF Input Section (Figure 13.33)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Define parameters used in the parameterized netlist
.param W_xm1=1.0 L_xm1=0.15
.param W_xm2=2.0 L_xm2=0.15
.param W_xm3=2.0 L_xm3=0.15
.param W_xm4=1.0 L_xm4=0.15
.param W_xm5=1.0 L_xm5=0.15
.param W_xm6=2.0 L_xm6=0.15
.param W_xm7=1.0 L_xm7=0.15
.param W_xm8=2.0 L_xm8=0.15
.param W_xm9=1.0 L_xm9=0.15
.param W_xm10=2.0 L_xm10=0.15

* --- DUT Netlist ---
xm1 B A 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xm2 B A VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xm5 N001 B 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 N001 B VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
xm7 D VDD A 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
* Replaced DC source with PULSE for transient delay measurement
* VD D 0 DC 0.9
VD D 0 PULSE(0 1.8 100p 20p 20p 400p 1n)
xm3 A 0 D VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 A 0 N001 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm8 N001 VDD A VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
xm9 N001 0 N002 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm10 N002 VDD N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
* --- End DUT ---

.control
tran 1p 2n

* Measure delay from D to A (Rise edge)
meas tran delay_d_to_a trig v(d) val=0.9 rise=1 targ v(a) val=0.9 rise=1

* Measure delay from A to B (Fall edge, since inverter 1 inverts the signal)
meas tran delay_a_to_b trig v(a) val=0.9 rise=1 targ v(b) val=0.9 fall=1

* Measure total delay from D to B
meas tran delay_d_to_b trig v(d) val=0.9 rise=1 targ v(b) val=0.9 fall=1

* Setup time is approximately the delay to charge node A
let setup_time_approx = delay_d_to_a

print delay_d_to_a delay_a_to_b delay_d_to_b setup_time_approx
quit
.endc
.end