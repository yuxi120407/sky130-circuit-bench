* Symmetric Delay Cell Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm3=5.0 L_xm3=0.5

VVDD VDD 0 1.8
VVSS VSS 0 0
VGND GND 0 0

* IN2 is tied high to enable the second parallel NMOS pull-down branch for symmetric operation
VIN2 IN2 0 1.8

* Pulse input for transient analysis (250 MHz)
VIN1 IN1 0 PULSE(0 1.8 1n 0.1n 0.1n 2n 4n)

* DUT
XM1 N4 IN1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 IN1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM6 N1 IN1 VSS GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM8 OUT N4 VSS GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM7 OUT N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM4 N0 IN1 VSS GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N4 IN2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM3 N4 IN1 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

* Load capacitor
Cload OUT 0 10f

.control
* Transient Analysis
tran 10p 10n

* Measure Propagation Delays
meas tran tpd_rise trig v(IN1) val=0.9 rise=1 targ v(OUT) val=0.9 rise=1
meas tran tpd_fall trig v(IN1) val=0.9 fall=1 targ v(OUT) val=0.9 fall=1

* Measure Rise and Fall Times (20% to 80% of 1.8V)
meas tran trise trig v(OUT) val=0.36 rise=1 targ v(OUT) val=1.44 rise=1
meas tran tfall trig v(OUT) val=1.44 fall=1 targ v(OUT) val=0.36 fall=1

* Measure Average Power
let inst_pwr = -i(VVDD) * 1.8
meas tran avg_power avg inst_pwr from=0 to=10n

* DC Analysis for Voltage Transfer Characteristic (VTC)
dc VIN1 0 1.8 0.01
meas dc vth find v(IN1) when v(OUT)=0.9 rise=1

quit
.endc
.end