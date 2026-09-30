* Dynamic Comparator Testbench
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

XM1 N0 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 LABEL_NET_1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N4 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 LABEL_NET_2 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 LABEL_NET_3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N2 LABEL_NET_4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N3 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N3 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}

VVDD VDD 0 1.8
* Clock signals: Active high for tail (LABEL_NET_4), active low for precharge (LABEL_NET_0, 3)
VCLK_0 LABEL_NET_0 0 pulse(0 1.8 100n 1n 1n 400n 1u)
VCLK_3 LABEL_NET_3 0 pulse(0 1.8 100n 1n 1n 400n 1u)
VCLK_4 LABEL_NET_4 0 pulse(0 1.8 100n 1n 1n 400n 1u)

* Differential inputs
VINP LABEL_NET_1 0 pwl(0 0.95 0.9u 0.95 1.1u 0.85 2u 0.85)
VINN LABEL_NET_2 0 pwl(0 0.85 0.9u 0.85 1.1u 0.95 2u 0.95)

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.control
tran 1n 2u

* Measure evaluation delay
meas tran evaluation_delay trig v(LABEL_NET_4) val=0.9 rise=1 targ v(N4) val=0.9 rise=1

* Measure energy and power
meas tran avg_current avg i(VVDD) from=0 to=1u
let energy_per_operation = -avg_current * 1.8 * 1u
print energy_per_operation

meas tran standby_current avg i(VVDD) from=600n to=900n
let standby_power = -standby_current * 1.8
print standby_power

print evaluation_delay

quit
.endc
.end