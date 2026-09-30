* Switched Opamp Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
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

XM1 N4 N5 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 GND VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N5 GND VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N6 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N5 LABEL_NET_0 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 LABEL_NET_1 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N5 N4 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N7 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N2 LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}

* Power supply
VVDD VDD 0 1.8

* Clocks (tied high to keep opamp ON for AC analysis)
VN0 N0 0 1.8
VN3 N3 0 1.8

* Bias for cross-coupled tail
VLABEL_NET_2 LABEL_NET_2 0 0.9

* AC inputs (Differential)
V_INP LABEL_NET_0 0 dc 0.9 ac 0.5
V_INN LABEL_NET_1 0 dc 0.9 ac -0.5

* Load capacitors
C1 N4 0 1p
C2 N5 0 1p

* Differential to single-ended converter for easy measurement
E_diff out_diff 0 N4 N5 1

.control
* DC Operating Point
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

* AC Analysis
ac dec 100 1 10G
let gain_db = vdb(out_diff)
let phase = 180/PI * cph(v(out_diff))
let phase_margin_vec = 180 + phase

meas ac dc_gain find gain_db at=10
meas ac ugf when gain_db=0 fall=1
meas ac phase_margin find phase_margin_vec when gain_db=0 fall=1

print dc_gain
print ugf
print phase_margin

quit
.endc
.end