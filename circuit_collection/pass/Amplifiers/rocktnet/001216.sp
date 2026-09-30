* Dual Regulated Cascode Photoreceptor Testbench
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

XM1 N5 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 N5 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 N4 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N4 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 VDD N1 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

VVDD VDD 0 1.8
Iin_left N2 0 DC 1n AC 1 PULSE(1n 10n 10m 1m 1m 40m 100m)
Iin_right N3 0 DC 1n AC 1 PULSE(1n 10n 10m 1m 1m 40m 100m)

Cload_left N1 0 2.3p
Cload_right N0 0 2.3p

.control
* DC Operating Point
op
let power = -i(VVDD) * 1.8
print power
print v(N1) v(N0) v(N2) v(N3)

* AC Analysis
ac dec 10 0.1 1Meg
let gain_left = vdb(N1)
let gain_right = vdb(N0)
meas ac dc_gain_left find gain_left at=1
meas ac dc_gain_right find gain_right at=1
meas ac bw_left when gain_left='dc_gain_left - 3' fall=1
meas ac bw_right when gain_right='dc_gain_right - 3' fall=1

* Transient Analysis for Log Slope
tran 100u 100m
meas tran v1_base find v(N1) at=5m
meas tran v1_pulse find v(N1) at=30m
let log_slope_left = v1_base - v1_pulse
print log_slope_left

meas tran v0_base find v(N0) at=5m
meas tran v0_pulse find v(N0) at=30m
let log_slope_right = v0_base - v0_pulse
print log_slope_right

quit
.endc
.end
