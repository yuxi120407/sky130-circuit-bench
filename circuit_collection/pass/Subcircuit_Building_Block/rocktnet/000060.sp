* Current Mirror / Bias Network Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5

XM1 N2 N7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N5 N7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N6 N7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N6 N7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 N7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}

* Bias voltage
Vbias N7 GND 0.7

* Drain voltages for measuring current
Vd2 N2 GND 1.8
Vd3 N3 GND 1.8
Vd5 N5 GND 1.8
Vd6 N6 GND 1.8

.control
op
let id2 = -i(Vd2)
let id3 = -i(Vd3)
let id5 = -i(Vd5)
let id6 = -i(Vd6)
let ratio_6_3 = id6 / id3

print id2 id3 id5 id6
print ratio_6_3

* DC sweep to find Rout of branch N3
dc Vd3 0 1.8 0.01
meas dc id3_1 find i(Vd3) at=0.9
meas dc id3_2 find i(Vd3) at=1.8
let rout3 = (1.8 - 0.9) / -(id3_2 - id3_1)
print rout3

quit
.endc
.end
