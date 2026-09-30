* Vision Sensor Contrast Circuit Testbench
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

XM1 COSN N1 IF VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 COSN N2 IF VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 COSP N1 IF VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 COSP N2 IF VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 SINN N4 IF VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 SINN N3 IF VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 SINP N4 IF VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 SINP N3 IF VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 SMP VL VSS sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N2 SMP VR VSS sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N3 SMP VT VSS sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N4 SMP VB VSS sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 IF IF VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 IF IF VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}

VVDD VDD 0 1.8
VVSS VSS 0 0
VCOSN COSN 0 1.8
VCOSP COSP 0 1.8
VSINN SINN 0 1.8
VSINP SINP 0 1.8

VSMP SMP 0 dc 1.8 pulse(0 1.8 10n 1n 1n 1u 2u)
VVL VL 0 dc 0.9 pwl(0 0.9 5n 1.2)
VVR VR 0 0.9
VVT VT 0 0.9
VVB VB 0 0.9

.ic v(N1)=0 v(N2)=0 v(N3)=0 v(N4)=0

.control
* DC Sweep for Gain, Dynamic Range, and Power
dc VVL 0 1.8 0.01
let power = (-i(VVDD) - i(VCOSN) - i(VCOSP) - i(VSINN) - i(VSINP)) * 1.8
meas dc power_consumption avg power
let gain = deriv(v(IF))
meas dc contrast_gain min gain
meas dc v_if_max max v(IF)
meas dc v_if_min min v(IF)
let dynamic_range = v_if_max - v_if_min
print power_consumption contrast_gain dynamic_range

* Transient for Sample Time
tran 0.1n 30n
meas tran sample_time trig v(SMP) val=0.9 rise=1 targ v(N1) val=1.15 rise=1
print sample_time
quit
.endc
.end