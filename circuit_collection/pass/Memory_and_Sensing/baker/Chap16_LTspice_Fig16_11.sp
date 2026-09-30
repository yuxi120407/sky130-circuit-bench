* NMOS Sense Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

* DUT (Pasted from prompt, VDDby2 changed to 0.9V for VDD=1.8V)
xm1 N001 sense_N 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
VDDby2 VDDby2 0 0.9
xm2 bitline1 bitline0 N001 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 bitline0 bitline1 N001 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 bitline1 Eq bitline0 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm5 bitline0 Eq VDDby2 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 VDDby2 Eq bitline1 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
Ccol1 bitline1 0 1e-13
Ccol0 bitline0 0 1e-13
xm7 bitline0 ra0 mb0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
Cmbit0 mb0 0 2e-14
xm8 bitline1 ra1 mb1 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
Cmbit1 mb1 0 2e-14
Vsn1 ra1 0 0

* Parameters
.param W_xm1=2.0 L_xm1=0.15
.param W_xm2=1.0 L_xm2=0.15
.param W_xm3=1.0 L_xm3=0.15
.param W_xm4=1.0 L_xm4=0.15
.param W_xm5=1.0 L_xm5=0.15
.param W_xm6=1.0 L_xm6=0.15
.param W_xm7=1.0 L_xm7=0.15
.param W_xm8=1.0 L_xm8=0.15

* Stimulus
Veq Eq 0 PULSE(1.8 0 5n 100p 100p 20n 40n)
Vra0 ra0 0 PULSE(0 1.8 7n 100p 100p 20n 40n)
Vsn sense_N 0 PULSE(0 1.8 12n 100p 100p 20n 40n)

* Initial conditions (mb0=0V to read a 0, bitlines start imbalanced to show equilibration)
.ic v(mb0)=0 v(mb1)=1.8 v(bitline0)=0 v(bitline1)=1.8

.control
tran 10p 20n uic

* Measure bitline voltage change (Delta Vbit)
meas tran v_precharge find v(bitline0) at=6n
meas tran v_final_share find v(bitline0) at=11n
let delta_v_bit = v_final_share - v_precharge
print delta_v_bit

* Measure sense delay (time from sense_N going high to bitline0 dropping to 10% of VDD)
meas tran t_sense_start when v(sense_N)=0.9 rise=1
meas tran t_sense_end when v(bitline0)=0.18 fall=1
let sense_delay = t_sense_end - t_sense_start
print sense_delay

quit
.endc
.end
