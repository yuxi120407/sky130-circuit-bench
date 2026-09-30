* Power Gating Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.15
.param L_xm2=0.15
.param L_xm3=0.15
.param L_xm4=0.15
.param L_xm5=0.15
.param L_xm6=0.15
.param L_xm7=0.15
.param L_xm8=0.15
.param L_xm9=0.15
.param L_xm10=0.15

.param W_xm1=20.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=20.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm9=5.0
.param W_xm10=5.0

VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9
VN6 N6 0 1.8

* Sleep signal (active low to turn on VDDV)
VN7 N7 0 PULSE(1.8 0 5n 0.1n 0.1n 20n 40n)

* DUT
XM1 N1 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N6 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N7 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 N3 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N5 LABEL_NET_1 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N5 N7 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N4 N6 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N3 N0 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Loads to simulate SRAM array and peripheral logic
Rload0 N0 0 10k
Rload4 N4 0 10k
Rload5 N5 0 10k

.control
tran 0.1n 50n

* Measure active voltage on virtual VDD (N0)
meas tran v_vddv_active avg v(N0) from=15n to=24n
let voltage_drop_active = 1.8 - v_vddv_active

* Measure turn-on time (delay from sleep falling to VDDV rising)
meas tran turn_on_time trig v(N7) val=0.9 fall=1 targ v(N0) val=1.5 rise=1

* Measure power consumption
meas tran i_active avg i(VVDD) from=15n to=24n
meas tran i_sleep avg i(VVDD) from=35n to=44n

let active_power = -i_active * 1.8
let leakage_power = -i_sleep * 1.8

print voltage_drop_active turn_on_time leakage_power active_power
quit
.endc
.end