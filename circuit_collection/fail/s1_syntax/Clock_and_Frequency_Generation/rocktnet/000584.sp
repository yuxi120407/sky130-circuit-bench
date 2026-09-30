* Injection-Locked Frequency Divider Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=10.0 L_xm1=0.15
.param W_xm2=20.0 L_xm2=0.15
.param W_xm3=5.0 L_xm3=0.15
.param W_xm4=10.0 L_xm4=0.15
.param W_xm5=20.0 L_xm5=0.15
.param W_xm6=5.0 L_xm6=0.15

* DUT
XM1 QX Q VSS GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 QX Q VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 Q INX QX GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 Q QX VSS GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 Q QX VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 QX IN Q GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

* LC Tank (Required for oscillation, added to testbench)
L1 Q QX 2n
C1 Q QX 12.6f

* Sources
VVDD VDD 0 1.8
VVSS VSS 0 0
VGND GND 0 0
VIN IN 0 DC 0.9 SIN(0.9 0.9 2G 0 0 0)
VINX INX 0 DC 0.9 SIN(0.9 0.9 2G 0 0 180)

* Initial conditions to kickstart oscillation
.ic v(Q)=1.8 v(QX)=0

.control
tran 10p 50n

* Measure output frequency (divided frequency)
meas tran t_period trig v(Q) val=0.9 rise=10 targ v(Q) val=0.9 rise=11
let out_freq = 1 / t_period
print out_freq

* Measure power consumption
meas tran pwr_avg avg i(VVDD) from=10n to=50n
let power = -pwr_avg * 1.8
print power

* Measure output voltage swing
meas tran v_max max v(Q) from=10n to=50n
meas tran v_min min v(Q) from=10n to=50n
let swing = v_max - v_min
print swing

quit
.endc
.end
