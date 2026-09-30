* Injection-Locked Frequency Divider Testbench
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

XM1 N2 OUT N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 BUF_OUT OUT GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 IN GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 BIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 OUT N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 OUT BIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 BIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

VVDD VDD 0 1.8
VBIAS BIAS 0 0.8
VIN IN 0 SIN(0.9 0.9 600MEG 0 0)
Rbuf BUF_OUT VDD 10k

.ic v(N0)=0 v(N2)=1.8 v(OUT)=0

.control
tran 10p 100n

* Measure input frequency
meas tran t_in_period trig v(in) val=0.9 rise=20 targ v(in) val=0.9 rise=21
let f_in = 1 / t_in_period

* Measure output frequency
meas tran t_out_period trig v(out) val=0.9 rise=10 targ v(out) val=0.9 rise=11
let f_out = 1 / t_out_period

* Calculate division ratio
let div_ratio = f_in / f_out
print f_in f_out div_ratio

* Measure power consumption
meas tran i_vdd avg i(VVDD) from=50n to=100n
let power = -i_vdd * 1.8
print power

* Measure output amplitude
meas tran v_max max v(out) from=50n to=100n
meas tran v_min min v(out) from=50n to=100n
let v_pp = v_max - v_min
print v_pp

quit
.endc
.end
