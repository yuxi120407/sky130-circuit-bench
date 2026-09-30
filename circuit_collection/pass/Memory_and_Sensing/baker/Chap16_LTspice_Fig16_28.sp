* Testbench for Clocked Sense Amplifier (Fig 16.28)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Define parameterized W/L values
.param W_xm1=2 L_xm1=0.15
.param W_xm2=2 L_xm2=0.15
.param W_xm3=2 L_xm3=0.15
.param W_xm4=1 L_xm4=0.15
.param W_xm5=1 L_xm5=0.15
.param W_xm6=1 L_xm6=0.15
.param W_xm7=1 L_xm7=1.0
.param W_xm8=0.5 L_xm8=1.0
.param W_xm9=1 L_xm9=1.0
.param W_xm10=0.5 L_xm10=1.0
.param W_xm11=1 L_xm11=0.15

* Stimulus
Vclock clock 0 PULSE(0 1.8 20n 100p 100p 20n 40n)

* DUT
xm1 N001 clock 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
VVDD VDD 0 1.8
xm11 Outm clock Inm VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
xm2 Outp Outm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xm3 Outm Outp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 Inp clock Outp VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm5 Outm Outp N001 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 Outp Outm N001 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 Inm 0 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 Inm 0 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
xm9 Inp VDD VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
xm10 Inp VDD 0 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}

.control
tran 10p 30n

* Measure clock feedthrough on Inp (nominally 0V)
meas tran inp_base find v(inp) at=19.9n
meas tran inp_peak max v(inp) from=19.9n to=21n
let feedthrough_inp = inp_peak - inp_base
print feedthrough_inp

* Measure clock feedthrough on Inm (nominally 1.8V)
meas tran inm_base find v(inm) at=19.9n
meas tran inm_peak max v(inm) from=19.9n to=21n
let feedthrough_inm = inm_peak - inm_base
print feedthrough_inm

* Measure peak switching current from VDD
meas tran peak_idd min i(VVDD)
let peak_current_uA = -peak_idd * 1e6
print peak_current_uA

quit
.endc
.end
