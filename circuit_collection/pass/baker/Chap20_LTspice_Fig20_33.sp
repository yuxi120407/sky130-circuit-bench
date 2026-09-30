* Cascode Current Mirror Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param L_xmws=0.5

* Define parameters for the parameterized netlist
.param W_xm1=2 L_xm1=1
.param W_xmws=0.5 L_xmws=1
.param W_xm2=2 L_xm2=1
.param W_xm4=2 L_xm4=1
.param W_xm5=4 L_xm5=1
.param W_xm6=4 L_xm6=1
.param W_xmsu1=1 L_xmsu1=1
.param W_xmsu2=1 L_xmsu2=1
.param W_xmsu3=1 L_xmsu3=1
.param W_xm3=4 L_xm3=1

* DUT Netlist
VDD VDD 0 1.8
xm1 N003 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
Vo N001 0 0
X_U1 Vbiasn Vbiasp VDD 0 SUB_1
xmws N002 N002 0 0 sky130_fd_pr__nfet_01v8 w={W_xmws} l={L_xmws}
xm2 N004 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm4 N001 N002 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm5 N002 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
xm6 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}

.subckt SUB_1 Vbiasn Vbiasp VDD GND
  xmsu2 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N001 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N001 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 Vbiasp Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm2 Vbiasp Vbiasn N002 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  R1 N002 GND 6.5k
.ends SUB_1

.control
* Sweep output voltage to characterize the current mirror
dc Vo 0 1.8 0.01

* Current flows out of the Vo source into the drain of M4
let i_out = -i(Vo)
* Output resistance is the inverse derivative of the output current
let r_out = 1 / deriv(i_out)

* Measure nominal current and output resistance in saturation (at Vo = 1.0V)
meas dc i_out_nom find i_out at=1.0
meas dc r_out_nom find r_out at=1.0

* Find minimum output voltage (compliance voltage) where current drops to 95% of nominal
let i_out_95 = 0.95 * i_out_nom
meas dc v_omin when i_out = i_out_95

print i_out_nom r_out_nom v_omin
quit
.endc
.end
