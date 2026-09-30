* Schmitt Trigger Testbench
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

* DUT
XM1 N2 N5 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N5 N0 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N5 N0 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 N2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N4 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

* Sources
VVDD VDD 0 1.8
VN1 N1 0 0
* PWL: Slow ramp up/down for hysteresis, then fast pulses for delay/energy
VIN N0 0 PWL(0 0 40u 1.8 80u 0 81u 0 81.01u 1.8 85u 1.8 85.01u 0 90u 0)

.control
tran 100p 90u

* Measure Thresholds and Hysteresis (from slow ramp)
meas tran vth_plus find v(N0) when v(N2)=0.9 rise=1
meas tran vth_minus find v(N0) when v(N2)=0.9 fall=1
let hysteresis = vth_plus - vth_minus
print hysteresis

* Measure Propagation Delay (from fast pulse)
meas tran t_pd_rise trig v(N0) val=0.9 rise=2 targ v(N2) val=0.9 rise=2
meas tran t_pd_fall trig v(N0) val=0.9 fall=2 targ v(N2) val=0.9 fall=2
let t_pd = (t_pd_rise + t_pd_fall) / 2
print t_pd

* Measure Energy per Operation (during fast pulse window)
let power = -i(VVDD) * 1.8
meas tran energy_pulse integ power from=81u to=86u
let energy_per_op = energy_pulse / 2
print energy_per_op

quit
.endc
.end
