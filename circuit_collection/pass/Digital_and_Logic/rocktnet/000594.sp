* Symmetric NAND2 Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

VVDD VDD 0 1.8
* Input A configured for DC sweep, AC analysis, and Transient pulse
VA A 0 DC 0.9 AC 1 PULSE(0 1.8 1n 50p 50p 2n 4n)
VB B 0 DC 1.8

* DUT
XM1 N4 A GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N5 B GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 OUT B N4 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUT A N5 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 OUT A VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 OUT B VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}

Cload OUT 0 50f

.control
* 1. DC Sweep
dc VA 0 1.8 0.01
meas dc vth_switching find v(A) when v(OUT)=v(A)
let efficiency_ratio = (vth_switching / 1.8) * 100
print efficiency_ratio

* 2. AC Analysis
alter VA dc = $&vth_switching
ac dec 10 1Meg 1Gig
let vout_db = db(v(OUT))
meas ac gain max vout_db
let omega = 2 * pi * frequency
let cap = abs(im(i(VA))) / omega
meas ac capacitance avg cap
print gain capacitance

* 3. Transient Analysis
tran 10p 10n
meas tran t_delay_fall trig v(A) val=0.9 rise=1 targ v(OUT) val=0.9 fall=1
meas tran t_delay_rise trig v(A) val=0.9 fall=1 targ v(OUT) val=0.9 rise=1
let pwr = -i(VVDD)*1.8
meas tran power avg pwr
let t_delay = (t_delay_fall + t_delay_rise) / 2
let operating_frequency = 1 / (2 * t_delay)
print t_delay operating_frequency power

quit
.endc
.end