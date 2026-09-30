* Testbench for Figure 26.28 CMFB Amplifiers
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm6t=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xma3=0.5
.param L_xma4=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Device parameter definitions (Baker W/L: NMOS 10/1, PMOS 20/1)
.param W_xm1=20.0 L_xm1=1.0
.param W_xm2=20.0 L_xm2=1.0
.param W_xm3=20.0 L_xm3=1.0
.param W_xm4=20.0 L_xm4=1.0
.param W_xm5=10.0 L_xm5=1.0
.param W_xm6=10.0 L_xm6=1.0
.param W_xm6t=10.0 L_xm6t=1.0
.param W_xm7=10.0 L_xm7=1.0
.param W_xm8=20.0 L_xm8=1.0
.param W_xm9=20.0 L_xm9=1.0
.param W_xmsu1=10.0 L_xmsu1=1.0
.param W_xmsu2=20.0 L_xmsu2=1.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xma3=20.0 L_xma3=1.0
.param W_xma4=20.0 L_xma4=1.0

* DUT Netlist
VDD VDD 0 1.8
xm4 N001 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
VCMA VCMA 0 500m
xm6t VCMFB1 VCMFB1 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6t} l={L_xm6t}
VCM VCM 0 500m
X_U1 Vbiasn Vbiasp VDD 0 SUB_1
xm5 N003 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm1 N003 VCMA N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
xm2 VCMFB1 VCM N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xm3 N002 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm6 VCMFB2 N004 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 N004 N004 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
xm8 N004 VCMA N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
xm9 VCMFB2 VCM N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}

.subckt SUB_1 Vbiasn Vbiasp VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 Vbiasn GND 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  R1 N004 0 4k
  xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm5 N001 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
  xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xm2 Vbiasp Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  xm6 N003 N003 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
.ends SUB_1

.control
* Run DC sweep matching Baker's simulation command
dc VCMA 400m 600m 0.5m

* Compute small-signal derivative gains
let g_diode = deriv(v(VCMFB1))
let g_mirror = deriv(v(VCMFB2))

* Measure quiescent voltages at VCMA = 500 mV
meas dc vcmfb1_quiescent find v(VCMFB1) at=0.5
meas dc vcmfb2_quiescent find v(VCMFB2) at=0.5

* Measure voltage gains at VCMA = 500 mV
meas dc gain_diode_load find g_diode at=0.5
meas dc gain_mirror_load find g_mirror at=0.5

print vcmfb1_quiescent vcmfb2_quiescent gain_diode_load gain_mirror_load
quit
.endc
.end