* 10T CAM Cell Testbench
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

* DUT
XM1 N3 N7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N6 LABEL_NET_0 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 LABEL_NET_2 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 N3 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 N5 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 N2 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N5 N2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Sources
VVDD VDD 0 1.8
VN4 N4 0 0
VN2 N2 0 1.8
R_ML VDD N1 10k

* Stimuli (50MHz -> 20ns period)
* N7 toggles to test inverter chain and enable/disable Path 1
V_N7 N7 0 PWL(0 1.8 10n 1.8 10.1n 0 30n 0 30.1n 1.8 50n 1.8)
* SL0 tests Path 1 (requires N3=1.8V, i.e., N7=0V)
V_SL0 LABEL_NET_0 0 PWL(0 0 15n 0 15.1n 1.8 25n 1.8 25.1n 0 50n 0)
* SL2 tests Path 2 (independent of N3 in this extraction)
V_SL2 LABEL_NET_2 0 PWL(0 0 35n 0 35.1n 1.8 45n 1.8 45.1n 0 50n 0)

* Load capacitance
C_N3 N3 0 10f
C_N0 N0 0 10f
C_N1 N1 0 50f

.control
tran 10p 50n

* Inverter delays
meas tran t_inv1_rise trig v(N7) val=0.9 fall=1 targ v(N3) val=0.9 rise=1
meas tran t_inv1_fall trig v(N7) val=0.9 rise=1 targ v(N3) val=0.9 fall=1
meas tran t_inv2_rise trig v(N3) val=0.9 fall=1 targ v(N0) val=0.9 rise=1
meas tran t_inv2_fall trig v(N3) val=0.9 rise=1 targ v(N0) val=0.9 fall=1

* Matchline pull-down delays
meas tran t_pulldown1 trig v(LABEL_NET_0) val=0.9 rise=1 targ v(N1) val=0.9 fall=1
meas tran t_pulldown2 trig v(LABEL_NET_2) val=0.9 rise=1 targ v(N1) val=0.9 fall=2

* Power measurement
let power = -i(VVDD)*1.8
meas tran power_avg avg power

let t_match_pulldown = (t_pulldown1 + t_pulldown2) / 2
let t_inv_delay = (t_inv1_rise + t_inv1_fall + t_inv2_rise + t_inv2_fall) / 4

print t_match_pulldown power_avg t_inv_delay
quit
.endc
.end