* Testbench for Dynamic Latched Amplifier
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

* DUT
XM1 VDD VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 VDD VDD IN VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 VDD VDD IN_B VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 VDD VDD N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 VDD VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 VDD VDD N0 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 VDD VDD N0 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 EN N0 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 VDD VDD N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 VDD VDD VDD GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Sources
VVDD VDD 0 1.8
* Ramp input to measure sensitivity
VIN IN 0 pwl(0 0.9 5n 1.4)
VIN_B IN_B 0 pwl(0 0.9 5n 0.4)
* 200 MHz Enable Clock (5ns period), rising at t=0
VEN EN 0 PULSE(0 1.8 0 1p 1p 2n 5n)

* Load capacitance
C1 N0 0 10f
C2 N1 0 10f

.ic v(N0)=0 v(N1)=0

.control
tran 1p 5n uic

let out_diff = abs(v(N0) - v(N1))

let sensing_delay = 5e-9
let v_in = 1.8
let v_in_b = 0
let input_sensitivity = 1.8
let avg_current = 0
let power_consumption = 0

meas tran sensing_delay TRIG v(EN) VAL=0.9 RISE=1 TARG out_diff VAL=0.9 CROSS=1

meas tran v_in find v(IN) when out_diff=0.9
meas tran v_in_b find v(IN_B) when out_diff=0.9
let input_sensitivity = v_in - v_in_b

meas tran avg_current avg i(VVDD) from=0 to=5n
let power_consumption = -avg_current * 1.8

print sensing_delay
print input_sensitivity
print power_consumption

quit
.endc
.end