* Charge-pump clock driver testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm1a=0.5
.param L_xm1i=0.5
.param L_xm2=0.5
.param L_xm2a=0.5
.param L_xm2i=0.5
.param L_xm3=0.5
.param L_xm4=0.5

* Define parameters for the parameterized netlist
.param W_xm1i=2.0 L_xm1i=0.15
.param W_xm2i=4.0 L_xm2i=0.15
.param W_xm1a=4.0 L_xm1a=0.15
.param W_xm2a=8.0 L_xm2a=0.15
.param W_xm1=2.0 L_xm1=0.15
.param W_xm2=10.0 L_xm2=0.15
.param W_xm3=10.0 L_xm3=0.15
.param W_xm4=10.0 L_xm4=0.15

* Input clock (25MHz)
Vclk N003 0 PULSE(0 1.8 0 100p 100p 20n 40n)

* --- DUT START ---
xm1i N001 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1i} l={L_xm1i}
VDD VDD 0 1.8
xm2i N001 N003 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2i} l={L_xm2i}
Cload Vout 0 1e-12
C2 N002 B 1e-12
xm1a N002 N001 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1a} l={L_xm1a}
xm2a N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2a} l={L_xm2a}
xm3 Vout N001 0 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 Vout N001 B B sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
C1 N001 A 1e-13
xm2 B A VDD 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 A B VDD 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
* --- DUT END ---

* Initial conditions to help startup
.ic v(vout)=0 v(a)=1.8 v(b)=1.8

.control
tran 100p 200n

* Measure steady state boosted voltages (after a few cycles)
meas tran v_out_high max v(vout) from=100n to=200n
meas tran v_boot_b max v(b) from=100n to=200n
meas tran v_boot_a max v(a) from=100n to=200n

* Measure rise time on a later edge (10% to 90% of actual swing)
let v10 = 0.1 * v_out_high
let v90 = 0.9 * v_out_high
meas tran t_rise trig v(vout) val=$&v10 rise=1 targ v(vout) val=$&v90 rise=1 from=110n to=140n

* Measure average power from VDD
meas tran pwr_integ integ i(VDD) from=100n to=200n
let power = -(pwr_integ / 100e-9) * 1.8

print v_out_high v_boot_b v_boot_a t_rise power
quit
.endc
.end