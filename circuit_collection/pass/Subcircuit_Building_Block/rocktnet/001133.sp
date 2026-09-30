* PWM Delay Cell Testbench
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

VVDD VDD 0 1.8
VVBP VBP 0 0.7
VVN1 VN1 0 1.8
VVN2 VN2 0 PULSE(0 1.8 2n 50p 50p 10n 20n)

XM1 N1 VDD N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 VN2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 VBP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 VN1 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}

Cload N1 0 10f

.control
tran 10p 60n
meas tran v_oh max v(N1) from=35n to=40n
meas tran v_ol min v(N1) from=25n to=30n
meas tran t_pd_fall trig v(VN2) val=0.9 rise=2 targ v(N1) val=0.9 fall=2
meas tran t_pd_rise trig v(VN2) val=0.9 fall=2 targ v(N1) val=0.9 rise=2
let t_pd = (t_pd_fall + t_pd_rise)/2

let pwr = -i(VVDD)*1.8
meas tran power avg pwr from=22n to=42n

print v_oh v_ol t_pd power
quit
.endc
.end