* Complex Logic Gate Testbench
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

* DUT
XM1 N0 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 LABEL_NET_3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 LABEL_NET_4 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 LABEL_NET_5 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 LABEL_NET_6 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}

* Pull-up resistor and load capacitor to complete the gate
Rpu VDD N2 10k
Cload N2 GND 10f

* Power supply
Vdd VDD 0 1.8

* Stimulus for Path 1: IN4=1, IN0 pulses
V0 LABEL_NET_0 0 pulse(0 1.8 1n 0.1n 0.1n 2n 5n)
V1 LABEL_NET_1 0 dc 0
V2 LABEL_NET_2 0 dc 0
V3 LABEL_NET_3 0 dc 0
V4 LABEL_NET_4 0 dc 1.8
V5 LABEL_NET_5 0 dc 0
V6 LABEL_NET_6 0 dc 0

.control
tran 10p 5n

* Measure delays
meas tran tpHL trig v(LABEL_NET_0) val=0.9 rise=1 targ v(N2) val=0.9 fall=1
meas tran tpLH trig v(LABEL_NET_0) val=0.9 fall=1 targ v(N2) val=0.9 rise=1

* Measure logic levels
meas tran VOL min v(N2)
meas tran VOH max v(N2)

* Measure static power when output is low (at t=2ns)
meas tran I_vdd find i(Vdd) at=2n
let static_power = -I_vdd * 1.8
print static_power

quit
.endc
.end
