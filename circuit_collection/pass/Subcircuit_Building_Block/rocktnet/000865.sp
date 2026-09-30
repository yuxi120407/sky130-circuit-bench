* Delay Element Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm2=0.5
.param L_xm7=0.5

.param W_xm2=5.0 L_xm2=0.5
.param W_xm7=5.0 L_xm7=0.5

XM2 OUT IN N4 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM7 OUT IN N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}

* Supply and Bias Connections (Tying exposed sources to rails for standard inverter operation)
VVDD VDD 0 1.8
VN2 N2 0 1.8
VN4 N4 0 0

* Input Signal (50 MHz)
VIN IN 0 PULSE(0 1.8 5n 0.1n 0.1n 10n 20n)

* Load Capacitor
CL OUT 0 50f

.control
* DC Analysis for Switching Threshold
dc VIN 0 1.8 0.01
meas dc v_th when v(out)=0.9 fall=1
print v_th

* Transient Analysis for Delay and Power
tran 10p 40n
meas tran t_rise trig v(out) val=0.36 rise=1 targ v(out) val=1.44 rise=1
meas tran t_fall trig v(out) val=1.44 fall=1 targ v(out) val=0.36 fall=1
meas tran t_pd_hl trig v(in) val=0.9 rise=1 targ v(out) val=0.9 fall=1
meas tran t_pd_lh trig v(in) val=0.9 fall=1 targ v(out) val=0.9 rise=1
let t_pd = (t_pd_hl + t_pd_lh) / 2
print t_pd

* Power Measurement
let inst_power = -i(VVDD)*1.8 - i(VN2)*1.8
meas tran power avg inst_power from=0 to=40n
print power

quit
.endc
.end