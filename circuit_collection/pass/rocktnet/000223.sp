* Shrunk Logic Swing Buffer Testbench
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_2 LABEL_NET_2 0 1.8

* Input signal: 50MHz -> 20ns period
VIN N3 0 PULSE(0 1.8 2n 0.1n 0.1n 9.8n 20n)

XM1 N1 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 LABEL_NET_0 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 GND N3 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 VDD VDD GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 LABEL_NET_2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.control
tran 0.1n 100n

* Measure V_OH and V_OL
meas tran v_oh max v(N0) from=10n to=20n
meas tran v_ol min v(N0) from=20n to=30n

* Measure delays (midpoint of 1.8V and 0.4V is ~1.1V)
meas tran delay_rise trig v(N3) val=0.9 rise=1 targ v(N0) val=1.1 rise=1
meas tran delay_fall trig v(N3) val=0.9 fall=1 targ v(N0) val=1.1 fall=1

* Measure power
meas tran avg_current avg i(VVDD) from=0 to=100n
let avg_power = -avg_current * 1.8
print avg_power

quit
.endc
.end
