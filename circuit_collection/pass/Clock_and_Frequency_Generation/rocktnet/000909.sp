* DCDE Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm6=5.0 L_xm6=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm1=5.0 L_xm1=0.5

XM6 VG GND VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM15 OUT N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM5 VG VG VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM13 N1 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM7 VG VG GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM3 VG VG VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM11 N2 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM2 VG B VG VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM8 N6 VG GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 IN N6 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM4 VG VG VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM12 N2 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM14 N1 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM16 OUT N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}
XM10 N3 IN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM1 VG A VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}

VVDD VDD 0 1.8
VIN IN 0 PULSE(0 1.8 5n 100p 100p 10n 20n)
VA A 0 PULSE(0 1.8 40n 100p 100p 50n 100n)
VB B 0 DC 0
CLOAD OUT 0 2p

.control
tran 100p 100n

* Measure delay with A=0 (first pulse at 5ns)
meas tran delay_rise_A0 trig v(in) val=0.9 rise=1 targ v(out) val=0.9 rise=1
meas tran delay_fall_A0 trig v(in) val=0.9 fall=1 targ v(out) val=0.9 fall=1

* Measure delay with A=1.8 (third pulse at 45ns)
meas tran delay_rise_A1 trig v(in) val=0.9 rise=3 targ v(out) val=0.9 rise=3
meas tran delay_fall_A1 trig v(in) val=0.9 fall=3 targ v(out) val=0.9 fall=3

* Measure average power
meas tran pwr_avg avg i(VVDD)
let power_W = -pwr_avg * 1.8
print power_W

quit
.endc
.end
