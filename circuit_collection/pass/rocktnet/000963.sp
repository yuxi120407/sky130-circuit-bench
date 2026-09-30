* Precharge Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0

* Power Supply
VVDD VDD 0 1.8

* Input Stimulus
VSA_WL SA_WL 0 PULSE(1.8 0 0 0.1n 0.1n 4n 10n)
VO1 O1 0 PULSE(1.8 0 2n 0.1n 0.1n 4n 10n)

* DUT
XM1 GND O1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 GND O2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VDDV SA_WL RBL VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 GND RBL GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VDDV VDDV VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 VDD O2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 VDDV RBL RBL VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 O2 O1 VDDV VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

* Initial conditions to ensure nodes start discharged
.ic v(RBL)=0 v(O2)=0 v(VDDV)=0

.control
tran 10p 10n uic

* Measure VDDV steady state (approx max value)
meas tran VDDV_Level max v(VDDV)

* Measure precharge delay for RBL
meas tran Precharge_Delay_RBL trig v(SA_WL) val=0.9 fall=1 targ v(RBL) val=0.8 rise=1

* Measure precharge delay for O2
meas tran Precharge_Delay_O2 trig v(O1) val=0.9 fall=1 targ v(O2) val=0.8 rise=1

* Measure total energy consumed during the 10ns window
meas tran i_integ integ i(VVDD) from=0 to=10n
let Energy_Per_Precharge = -i_integ * 1.8
print VDDV_Level Precharge_Delay_RBL Precharge_Delay_O2 Energy_Per_Precharge

quit
.endc
.end