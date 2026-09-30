* StrongARM Latch Testbench
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

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5

VVDD VDD 0 1.8
* 1GHz Clock: 1ns period, 100ps delay, 400ps pulse width
VCLK CLOCK 0 PULSE(0 1.8 0.1n 0.02n 0.02n 0.4n 1n)

* Differential input: Cycle 1 (V1P > V1N), Cycle 2 (V1P < V1N)
V1P V1P 0 PWL(0 0.95 0.9n 0.95 1.0n 0.85 2n 0.85)
V1N V1N 0 PWL(0 0.85 0.9n 0.85 1.0n 0.95 2n 0.95)

XM1 N0 V1N N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VON VOP N4 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VOP VON VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 VOP VON N0 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 CLOCK VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 VOP CLOCK VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 CLOCK GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 VON CLOCK VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 VON VOP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N4 CLOCK VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N4 V1P N1 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}

.control
tran 1p 2n

* Measure delay for Cycle 1 (V1P > V1N -> VON falls)
meas tran delay_von trig v(CLOCK) val=0.9 rise=1 targ v(VON) val=0.9 fall=1

* Measure delay for Cycle 2 (V1P < V1N -> VOP falls)
meas tran delay_vop trig v(CLOCK) val=0.9 rise=2 targ v(VOP) val=0.9 fall=1

* Measure average power and energy per operation
meas tran i_avg avg i(VVDD) from=0 to=2n
let pwr_avg = -i_avg * 1.8
* 1ns period means 1 operation per 1ns
let energy_per_op = pwr_avg * 1n

print delay_von delay_vop pwr_avg energy_per_op
quit
.endc
.end
