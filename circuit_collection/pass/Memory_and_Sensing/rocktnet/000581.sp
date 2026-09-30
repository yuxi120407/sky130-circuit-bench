* Latch-Type Voltage Sense Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
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

VVDD VDD 0 1.8
VEN EN 0 PULSE(0 1.8 1n 50p 50p 2n 5n)
* Input DC level = 1.26V (70% of 1.8V), diff = 100mV
VINP INP 0 DC 1.31
VINN INN 0 DC 1.21

XM1 SO SON N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 SO SON VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 SON SO N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 SON SO VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 INN COM GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 INP COM GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 SO EN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 SON EN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 COM EN GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}

* Load capacitors
C1 SO 0 10f
C2 SON 0 10f

.control
tran 10p 5n
* Measure delay from EN rising to SON falling (since INP > INN)
meas tran t_delay trig v(en) val=0.9 rise=1 targ v(son) val=0.9 fall=1

* Measure average power during the sensing event
let pwr = -i(VVDD)*1.8
meas tran avg_pwr avg pwr from=1n to=3n

print t_delay avg_pwr
quit
.endc
.end
