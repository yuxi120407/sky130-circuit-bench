* Clocked Sense Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm11=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=2.0 L_xm1=0.15
.param W_xm11=1.0 L_xm11=0.15
.param W_xm2=2.0 L_xm2=0.15
.param W_xm3=2.0 L_xm3=0.15
.param W_xm4=1.0 L_xm4=0.15
.param W_xm5=2.0 L_xm5=0.15
.param W_xm6=2.0 L_xm6=0.15

* Stimulus
Vclock clock 0 PULSE(0 1.8 5n 0.1n 0.1n 10n 20n)
* Add 10k resistor to Inp to measure feedthrough/kickback as suggested on page 449
Vinp_src Inp_ideal 0 0.55
Rinp Inp_ideal Inp 10k

* DUT (Netlist pasted directly)
xm1 N001 clock 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
xm11 Outm clock Inm VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
xm2 Outp Outm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xm3 Outm Outp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 Inp clock Outp VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm5 Outm Outp N001 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 Outp Outm N001 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
Vinm Inm 0 500m

.control
tran 0.1n 40n

* Measure average current (IDD)
meas tran avg_idd avg i(VDD)

* Measure peak contention current (minimum because current out of VDD is negative)
meas tran peak_idd min i(VDD)

* Measure clock feedthrough noise on Inp (peak deviation)
meas tran max_inp max v(Inp)
meas tran min_inp min v(Inp)
let feedthrough_pk2pk = max_inp - min_inp

print avg_idd peak_idd feedthrough_pk2pk
quit
.endc
.end
