* Latch-Type Sense Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5

XM1 V1 V2 N_TAIL GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 V1 V2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 V2 V1 N_TAIL GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 V2 V1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N_TAIL EN GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 V1 EN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 V2 EN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}

VVDD VDD 0 1.8
VEN EN 0 PULSE(0 1.8 2n 50p 50p 10n 20n)
I_diff V2 0 50u

.control
tran 1p 10n
meas tran v1_init find v(V1) at=1.9n
meas tran v2_init find v(V2) at=1.9n
meas tran delay trig v(EN) val=0.9 rise=1 targ v(V2) val=0.9 fall=1
let pwr = -i(VVDD)*1.8
meas tran avg_power avg pwr from=2n to=5n
meas tran i_peak min i(VVDD)
quit
.endc
.end