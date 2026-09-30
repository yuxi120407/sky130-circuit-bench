* Current-Starved Delay Cell Testbench
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
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

XM1 N5 IN N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 VC GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 VC GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N5 IN N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 OUT N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 OUT N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

VVDD VDD 0 1.8
VVC VC 0 0.9
VIN IN 0 PULSE(0 1.8 2n 0.1n 0.1n 5n 10n)

.control
tran 10p 20n
meas tran delay_rise trig v(IN) val=0.9 rise=1 targ v(OUT) val=0.9 rise=1
meas tran delay_fall trig v(IN) val=0.9 fall=1 targ v(OUT) val=0.9 fall=1
meas tran trise trig v(OUT) val=0.36 rise=1 targ v(OUT) val=1.44 rise=1
meas tran tfall trig v(OUT) val=1.44 fall=1 targ v(OUT) val=0.36 fall=1
let pwr = -i(VVDD)*1.8
meas tran avg_power avg pwr

dc VIN 0 1.8 0.01
meas dc trip_point when v(OUT)=0.9 rise=1
quit
.endc
.end
