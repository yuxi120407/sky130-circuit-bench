* Testbench for Low-Voltage Cascode Current Mirror
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm5a=0.5
.param L_xm6=0.5
.param L_xm6b=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xma3=0.5
.param L_xma4=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param L_xmws=0.5

* Define parameters used in the parameterized netlist
.param W_xm1=10 L_xm1=2
.param W_xm2=10 L_xm2=2
.param W_xm3=20 L_xm3=2
.param W_xm4=10 L_xm4=2
.param W_xm5=10 L_xm5=2
.param W_xm6=10 L_xm6=2
.param W_xm7=20 L_xm7=2
.param W_xm8=10 L_xm8=2
.param W_xmws=2.5 L_xmws=2
.param W_xm5a=20 L_xm5a=2
.param W_xm6b=20 L_xm6b=2
.param W_xmsu1=2 L_xmsu1=2
.param W_xmsu2=2 L_xmsu2=2
.param W_xmsu3=2 L_xmsu3=2
.param W_xma3=20 L_xma3=2
.param W_xma4=20 L_xma4=2

VDD VDD 0 1.8
Vo N001 0 1.8

* DUT
xm2 N004 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
X_U1 Vbiasn Vbiasp VDD 0 SUB_1
xmws N002 N002 0 0 sky130_fd_pr__nfet_01v8 w={W_xmws} l={L_xmws}
xm1 N003 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 N001 N002 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm5a N002 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5a} l={L_xm5a}
xm6b N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6b} l={L_xm6b}

.subckt SUB_1 Vbiasn Vbiasp VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 Vbiasn GND 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  R1 N004 0 5.5k
  xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm5 N001 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
  xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xm8 0 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
  xm2 Vbiasp Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  xm6 N003 N003 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
.ends SUB_1

.control
  * 1. DC Sweep for Output Resistance and Vmin
  dc Vo 0 1.8 0.01
  
  * Calculate Ro = dV/dI at Vo = 1.0V
  let iout = -i(Vo)
  let deriv_iout = deriv(iout)
  let ro = 1 / deriv_iout
  meas dc Ro_at_1V find ro at=1.0
  
  * Find Vmin (where current drops to 95% of its nominal saturation value)
  meas dc Iout_nom find iout at=1.0
  let Iout_95 = Iout_nom * 0.95
  meas dc Vmin when iout=Iout_95
  
  * 2. Temperature Sweep for TC
  dc temp 0 100 10
  let iout_t = -i(Vo)
  meas dc Iout_27 find iout_t at=27
  meas dc Iout_100 find iout_t at=100
  let TC = (Iout_100 - Iout_27) / (Iout_27 * (100 - 27)) * 1e6
  print TC
  
  quit
.endc
.end