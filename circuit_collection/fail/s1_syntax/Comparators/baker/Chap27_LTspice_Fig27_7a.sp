* Testbench for Pre-amp and Decision Circuit (Fig. 27.5, Baker Ch 27)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm1_bias=0.5
.param L_xm2=0.5
.param L_xm2_bias=0.5
.param L_xm3=0.5
.param L_xm31=0.5
.param L_xm3_bias=0.5
.param L_xm4=0.5
.param L_xm41=0.5
.param L_xm4_bias=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Parameter definitions for nominal sizing
.param W_xmsu3=20.0 L_xmsu3=2.0
.param W_xm31=30.0  L_xm31=2.0
.param W_xm41=30.0  L_xm41=2.0
.param W_xm1=10.0   L_xm1=2.0
.param W_xm2=10.0   L_xm2=2.0
.param W_xm3=30.0   L_xm3=2.0
.param W_xm4=30.0   L_xm4=2.0
.param W_xm5=10.0   L_xm5=2.0
.param W_xm6=12.0   L_xm6=2.0
.param W_xm7=12.0   L_xm7=2.0
.param W_xm8=10.0   L_xm8=2.0

.param W_xmsu1=10.0 L_xmsu1=2.0
.param W_xmsu2=10.0 L_xmsu2=2.0
.param W_xm3_bias=30.0 L_xm3_bias=2.0
.param W_xm4_bias=30.0 L_xm4_bias=2.0
.param W_xm1_bias=10.0 L_xm1_bias=2.0
.param W_xm2_bias=10.0 L_xm2_bias=2.0

* Power Supplies
VDD VDD 0 1.8

* Device Under Test (DUT)
xmsu3 N003 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
xm31  N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm31} l={L_xm31}
xm41  N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm41} l={L_xm41}
xm2   N001 vm N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1   N002 vp N003 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}

X_U1  Vbiasn Vbiasp VDD 0 SUB_1

Vp vp 0 0.9
Vm vm 0 0.9

xm3   vop N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4   vom N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm5   vop vop 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6   vop vom 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7   vom vop 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
xm8   vom vom 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}

* Bias Circuit Subcircuit
.subckt SUB_1 Vbiasn Vbiasp VDD GND
  xmsu2 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N001 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 VDD N001 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3   Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3_bias} l={L_xm3_bias}
  xm4   Vbiasp Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4_bias} l={L_xm4_bias}
  xm1   Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1_bias} l={L_xm1_bias}
  xm2   Vbiasp Vbiasn N002 0 sky130_fd_pr__nfet_01v8 w={W_xm2_bias} l={L_xm2_bias}
  R1    N002 GND 6.5k
.ends SUB_1

* Control Script
.control
  op
  let Iss = -i(VDD)
  let pwr = -i(VDD) * 1.8
  print Iss pwr

  * Forward DC sweep: vp swept from 0.8V to 1.0V (increasing)
  dc Vp 0.8 1.0 0.001
  let diff_out = v(vop) - v(vom)
  meas dc voh max v(vop)
  meas dc vol min v(vom)
  meas dc vp_switch_high when diff_out=0 rise=1
  let vsph = vp_switch_high - 0.9
  print vsph voh vol

  * Backward DC sweep: vp swept from 1.0V down to 0.8V (decreasing)
  dc Vp 1.0 0.8 -0.001
  let diff_out_rev = v(vop) - v(vom)
  meas dc vp_switch_low when diff_out_rev=0 fall=1
  let vspl = vp_switch_low - 0.9
  let v_hyst = vsph - vspl
  print vspl v_hyst

  quit
.endc
.end