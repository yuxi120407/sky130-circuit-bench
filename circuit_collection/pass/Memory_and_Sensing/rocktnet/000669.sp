* Sense Current Recovery Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm8=5.0 L_xm8=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm3=5.0 L_xm3=0.5

* DUT
XM8 N4 INI_CHGB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM7 N6 ENB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM6 N0 CAS_BIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM5 BITLINE INI_CHG GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM2 B CASREF N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM1 A BITLINE N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM4 BITLINE A N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM3 SAIN A BITLINE GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

* Testbench Loads
RA A VDD 10k
RB B VDD 10k
RSAIN SAIN GND 10k

* Bias and Supply Sources
VVDD VDD 0 1.8
VCAS_BIAS CAS_BIAS 0 1.0
VCASREF CASREF 0 0.9
VINI_CHGB INI_CHGB 0 0
VINI_CHG INI_CHG 0 0
VENB ENB 0 0

* Stimulus
VBITLINE_IN BITLINE_IN 0 PULSE(1.8 0 5n 1n 1n 20n 50n)
RBITLINE BITLINE_IN BITLINE 1k

.control
* DC Analysis for Trip Point
dc VBITLINE_IN 0 1.8 0.01
meas dc trip_voltage find v(BITLINE) when v(A)=1.6 cross=1
print trip_voltage

* Transient Analysis for Response Time
tran 0.1n 50n
meas tran response_time trig v(BITLINE) val=0.9 fall=1 targ v(A) val=1.6 rise=1
print response_time

* Operating Point for Power
op
let power = -i(VVDD) * 1.8
print power

quit
.endc
.end