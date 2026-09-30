* 5T Latch Testbench
.param W_xm1=1.0 L_xm1=0.15
.param W_xm2=1.0 L_xm2=0.15
.param W_xm4=1.0 L_xm4=0.5
.param W_xm5=1.0 L_xm5=0.5
.param W_xm9=10.0 L_xm9=0.15

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

VVDD VDD 0 1.8
VBL BL 0 PULSE(1.8 0 2n 0.1n 0.1n 4n 10n)

XM1 N0 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM4 N1 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM9 BL VDD N1 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}

.ic v(N1)=1.8 v(N0)=0

.control
tran 10p 10n uic

* Measure write delays
meas tran write0_delay trig v(BL) val=0.9 fall=1 targ v(N1) val=0.9 fall=1
meas tran write1_delay trig v(BL) val=0.9 rise=1 targ v(N1) val=0.9 rise=1

* Measure static current in both states
meas tran I_static_1 avg i(VVDD) from=1n to=1.9n
meas tran I_static_0 avg i(VVDD) from=5n to=5.9n

* Calculate static power
let pwr_1 = -1 * I_static_1 * 1.8
let pwr_0 = -1 * I_static_0 * 1.8
let static_power = (pwr_1 + pwr_0) / 2

print write0_delay write1_delay static_power
quit
.endc
.end