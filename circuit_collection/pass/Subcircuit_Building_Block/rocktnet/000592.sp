* VCO Delay Cell Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
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
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5

VVDD VDD 0 1.8
* Enable cross-coupling (TGs ON)
VLABEL_NET_0 LABEL_NET_0 0 0
VLABEL_NET_1 LABEL_NET_1 0 0
VLABEL_NET_2 LABEL_NET_2 0 1.8
VLABEL_NET_3 LABEL_NET_3 0 1.8

* Differential inputs at 160 MHz (Period = 6.25ns)
VINP N4 0 PULSE(0 1.8 1n 0.1n 0.1n 3n 6.25n)
VINN N2 0 PULSE(1.8 0 1n 0.1n 0.1n 3n 6.25n)

* Load capacitors
C1 N5 0 10f
C2 N0 0 10f

* DUT
XM1 N5 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 LABEL_NET_0 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 LABEL_NET_1 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N5 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N5 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N3 LABEL_NET_2 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N5 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N1 LABEL_NET_3 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}

.control
tran 10p 20n
meas tran tpd_fall trig v(N4) val=0.9 rise=1 targ v(N5) val=0.9 fall=1
meas tran tpd_rise trig v(N2) val=0.9 fall=1 targ v(N0) val=0.9 rise=1
let tpd = (tpd_fall + tpd_rise)/2
print tpd

meas tran trise trig v(N0) val=0.36 rise=1 targ v(N0) val=1.44 rise=1
meas tran tfall trig v(N5) val=1.44 fall=1 targ v(N5) val=0.36 fall=1

meas tran pwr_avg avg i(VVDD)
let power = -pwr_avg * 1.8
print power
quit
.endc
.end
