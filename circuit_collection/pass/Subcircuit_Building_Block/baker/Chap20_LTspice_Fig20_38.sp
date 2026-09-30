* Testbench for Low-Voltage Wide-Swing Cascode Current Mirror
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

* Parameters for sizing
.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=10.0 L_xm2=1.0
.param W_xm3=10.0 L_xm3=1.0
.param W_xm4=10.0 L_xm4=1.0
.param W_xmws=2.5 L_xmws=1.0
.param W_xm5a=20.0 L_xm5a=1.0
.param W_xm6b=20.0 L_xm6b=1.0

* Subckt SUB_1 sizing
.param W_xmsu1=10.0 L_xmsu1=1.0
.param W_xmsu2=20.0 L_xmsu2=1.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xm5=10.0 L_xm5=1.0
.param W_xm6=10.0 L_xm6=1.0
.param W_xm7=20.0 L_xm7=1.0
.param W_xm8=10.0 L_xm8=1.0
.param W_xma3=20.0 L_xma3=1.0
.param W_xma4=20.0 L_xma4=1.0

* Power Supplies & Test Source
VDD VDD 0 1.8
Vo N002 0 DC 0.9 AC 1

* DUT Instance
xm2 N004 N001 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
X_U1 Vbiasn Vbiasp VDD 0 SUB_1
xmws N003 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xmws} l={L_xmws}
xm1 P001 N001 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 N002 N003 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm5a N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5a} l={L_xm5a}
xm6b N001 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6b} l={L_xm6b}
xm3 N001 N003 P001 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}

.subckt SUB_1 Vbiasn Vbiasp VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 Vbiasn GND 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6b} l={L_xm6b}
  xm4 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6b} l={L_xm6b}
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
* 1. Operating Point Analysis
op
let output_current = -i(Vo)
let total_dc_power = -i(VDD) * 1.8
let cascode_gate_voltage = v(N003)
let m2_drain_voltage = v(N004)

print output_current
print total_dc_power
print cascode_gate_voltage
print m2_drain_voltage

* 2. Small-Signal AC Analysis for Output Resistance
ac dec 10 1 100k
let r_out = 1 / (mag(i(Vo)) + 1e-18)
meas ac cascode_output_resistance find r_out at=10
print cascode_output_resistance

* 3. DC Sweep Analysis for Compliance Voltage
dc Vo 0 1.8 0.01
let i_out_dc = -i(Vo)
meas dc io_nom find i_out_dc at=0.9
let io_90pct = 0.9 * $&io_nom
meas dc min_compliance_voltage when i_out_dc=$&io_90pct cross=1
print min_compliance_voltage

quit
.endc
.end