* Testbench for Comparator Preamp and Decision Circuit (Baker Fig. 27.5)
.lib "/path/to/sky130_fd_pr/models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm31=0.5
.param L_xm4=0.5
.param L_xm41=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Parameter definitions
.param W_xmsu3=20.0 L_xmsu3=1.0
.param W_xm31=30.0  L_xm31=1.0
.param W_xm41=30.0  L_xm41=1.0
.param W_xm2=10.0   L_xm2=1.0
.param W_xm1=10.0   L_xm1=1.0
.param W_xm3=30.0   L_xm3=1.0
.param W_xm4=30.0   L_xm4=1.0
.param W_xm5=10.0   L_xm5=1.0
.param W_xm6=10.0   L_xm6=1.0
.param W_xm7=10.0   L_xm7=1.0
.param W_xm8=10.0   L_xm8=1.0

* SUB_1 Bias generator parameters
.param W_xmsu2=20.0 L_xmsu2=1.0
.param W_xmsu1=10.0 L_xmsu1=1.0

* Power Supplies
VDD VDD 0 1.8

* Input Sources
* Common-mode level is 0.9 V
Vp vp 0 0.9
Vm vm 0 0.9

* Circuit Under Test (DUT)
xmsu3 N003 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
xm31 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm31} l={L_xm31}
xm41 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm41} l={L_xm41}
xm2 N001 vm N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N002 vp N003 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
X_U1 Vbiasn Vbiasp VDD 0 SUB_1
xm3 vop N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 vom N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm5 vop vop 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 vop vom 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 vom vop 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
xm8 vom vom 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}

.subckt SUB_1 Vbiasn Vbiasp VDD GND
  xmsu2 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N001 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 VDD N001 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 Vbiasp Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm2 Vbiasp Vbiasn N002 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  R1 N002 GND 6.5k
.ends SUB_1

.control
* 1. Operating Point Analysis
op
let iss_val = -i(VDD)
let power_val = -i(VDD) * 1.8
print iss_val power_val

* 2. DC Sweep Analysis for Forward Transition (increasing vp)
dc Vp 0.8 1.0 0.0005
let diff_out = v(vop) - v(vom)
let v_diff_in = v(vp) - 0.9

meas dc vop_max max v(vop)
meas dc vom_min min v(vom)
let swing = vop_max - vom_min
print swing

* Switching threshold: where vop crosses vom
meas dc vsph_abs when v(vop)=v(vom) rise=1
let vsph = vsph_abs - 0.9
print vsph

* 3. DC Sweep Analysis for Reverse Transition (decreasing vp)
dc Vp 1.0 0.8 -0.0005
meas dc vspl_abs when v(vop)=v(vom) fall=1
let vspl = vspl_abs - 0.9
print vspl

let vhyst = vsph - vspl
print vhyst

quit
.endc
.end