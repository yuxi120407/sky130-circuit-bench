* Load-Adaptive Output Buffer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0

* DUT
XM1 N0 N6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}

* Power Supply
VVDD VDD 0 1.8

* Input Stimulus (25MHz, 1.8V swing)
VIN IN 0 PULSE(0 1.8 5n 0.1n 0.1n 20n 40n)

* Tie all control/input nodes together to enable maximum drive strength
V1 N1 IN 0
V4 N4 IN 0
V5 N5 IN 0
V6 N6 IN 0

* Load Capacitors (Reduced to 1pF to allow full swing at 25MHz)
CLOAD N0 0 1p
CLOAD2 N2 0 1p

.control
tran 0.1n 100n

* Measure Rise and Fall Times at main output N0
meas tran t_rise trig v(N0) val=0.18 rise=1 targ v(N0) val=1.62 rise=1
meas tran t_fall trig v(N0) val=1.62 fall=1 targ v(N0) val=0.18 fall=1

* Measure Propagation Delay
meas tran t_pd trig v(IN) val=0.9 rise=1 targ v(N0) val=0.9 fall=1

* Measure Average Power
let pwr = -i(VVDD)*1.8
meas tran avg_power avg pwr from=0 to=100n

print t_rise t_fall t_pd avg_power
quit
.endc
.end