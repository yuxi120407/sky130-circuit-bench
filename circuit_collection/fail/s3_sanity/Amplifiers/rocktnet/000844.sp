* Fully Differential Op-Amp Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
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
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5

XM1 OUTP N1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N6 VB4 N10 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 OUTN N6 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUTN VCMFB2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 VCMFB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N10 VCMFB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N8 INN N4 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N12 INP N4 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 OUTP VCMFB2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N6 VB3 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N1 VB4 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N1 N1 N12 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N1 VB3 N12 GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N4 INN N12 GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}

* Power and Bias Sources
VVDD VDD 0 1.8
VVB4 VB4 0 0.99
VVCMFB2 VCMFB2 0 0.9
VVCMFB1 VCMFB1 0 0.9
VVB3 VB3 0 0.54

* Differential Input Sources (DC + AC + Transient Sine)
VINP INP 0 DC 0.9 AC 0.5 SIN(0.9 0.1 1MEG 0 0)
VINN INN 0 DC 0.9 AC -0.5 SIN(0.9 -0.1 1MEG 0 0)

* Behavioral source for differential output measurement
B1 OUT_DIFF 0 V='V(OUTP) - V(OUTN)'

* Load Capacitors
CL1 OUTP 0 1p
CL2 OUTN 0 1p

.control
* 1. DC Operating Point & Power
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

* 2. AC Analysis for Gain, UGBW, and Phase Margin
ac dec 100 1 10G
let out_diff_ac = v(OUTP) - v(OUTN)
let gain_db = db(out_diff_ac)
let phase = 180/PI * ph(out_diff_ac)
let phase_shifted = phase + 180

meas ac dc_gain find gain_db at=10
meas ac unity_gain_bandwidth when gain_db=0 fall=1
meas ac phase_margin find phase_shifted when gain_db=0 fall=1

print dc_gain
print unity_gain_bandwidth
print phase_margin

* 3. Transient Analysis for Output Swing
tran 1n 5u
let out_diff_tran = v(OUTP) - v(OUTN)
meas tran v_max max out_diff_tran
meas tran v_min min out_diff_tran
let transient_swing = v_max - v_min
print transient_swing

quit
.endc
.end