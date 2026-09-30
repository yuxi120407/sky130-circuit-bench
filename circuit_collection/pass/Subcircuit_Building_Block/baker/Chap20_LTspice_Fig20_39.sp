* Low-Voltage Wide-Swing Cascode Current Mirror Testbench
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

* Parameter definitions for transistors
.param W_xm1=50.0 L_xm1=2.0
.param W_xm2=50.0 L_xm2=2.0
.param W_xm3=50.0 L_xm3=2.0
.param W_xm4=50.0 L_xm4=2.0
.param W_xmws=12.5 L_xmws=2.0
.param W_xm5a=100.0 L_xm5a=2.0
.param W_xm6b=100.0 L_xm6b=2.0
.param W_xmsu1=50.0 L_xmsu1=2.0
.param W_xmsu2=10.0 L_xmsu2=20.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xm5=50.0 L_xm5=2.0
.param W_xm6=50.0 L_xm6=2.0
.param W_xm7=100.0 L_xm7=2.0
.param W_xm8=50.0 L_xm8=2.0
.param W_xma3=100.0 L_xma3=2.0
.param W_xma4=100.0 L_xma4=2.0

* DUT Instance
VDD VDD 0 1.8
xm2 N004 N001 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
Vo N002 0 1.0
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
  xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xm4 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
  R1 N004 0 5.5k
  xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm5 N001 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
  xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xm8 0 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
  xm2 Vbiasp Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
  xm6 N003 N003 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
.ends SUB_1

.control
* Run DC Sweep on output compliance voltage Vo
dc Vo 0 1.8 0.005

* Calculate output current Io = -i(Vo)
let io_curr = -i(Vo)
let dio_dvo = deriv(io_curr)
let r_out = 1.0 / (dio_dvo + 1e-18)
let pwr = -i(VDD) * 1.8

* Output Current at nominal compliance Vo = 1.0 V
meas dc output_current find io_curr at=1.0

* Cascode output resistance at Vo = 1.0 V
meas dc cascode_output_resistance find r_out at=1.0

* Cascode bias voltage VG on node N003
meas dc cascode_gate_voltage find v(N003) at=1.0

* Intermediate node voltage VDS2 on node N004
meas dc m2_drain_voltage find v(N004) at=1.0

* Power dissipation
meas dc power_dissipation find pwr at=1.0

* Minimum output compliance voltage (where Io reaches 90% of nominal Io)
let io_90 = 0.90 * output_current
meas dc min_output_voltage when io_curr=io_90 cross=1

print output_current min_output_voltage cascode_output_resistance cascode_gate_voltage m2_drain_voltage power_dissipation
quit
.endc
.end