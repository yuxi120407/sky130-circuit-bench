* Testbench for Differential Delay Cell
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

XM1 N0 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}

VVDD VDD 0 1.8
VN2 N2 0 0.9
VIN_P LABEL_NET_0 0 PULSE(0 1.8 0 100p 100p 1.9n 4n)
VIN_N LABEL_NET_1 0 PULSE(1.8 0 0 100p 100p 1.9n 4n)

C0 N0 0 50f
C1 N1 0 50f

.control
tran 10p 20n

* Measure propagation delay
meas tran delay_fall trig v(LABEL_NET_0) val=0.9 rise=2 targ v(N0) val=0.9 fall=2
meas tran delay_rise trig v(LABEL_NET_0) val=0.9 fall=2 targ v(N0) val=0.9 rise=2
let tpd = (delay_fall + delay_rise) / 2
print tpd

* Measure output voltage swing
meas tran v_max max v(N0)
meas tran v_min min v(N0)
let v_swing = v_max - v_min
print v_swing

* Measure average power consumption
meas tran power_avg avg i(VVDD) from=4n to=16n
let power_mw = -power_avg * 1.8 * 1000
print power_mw

quit
.endc
.end
