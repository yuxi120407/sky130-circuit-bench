* Testbench for Cascode Current Mirror (Baker Fig. 20.29)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Parameter definitions for device sizes
.param W_xm1=5.0 L_xm1=0.2
.param W_xm2=20.0 L_xm2=0.2
.param W_xm3=10.0 L_xm3=0.2
.param W_xm4=10.0 L_xm4=0.2
.param W_xm5=10.0 L_xm5=0.2
.param W_xmsu1=5.0 L_xmsu1=0.2
.param W_xmsu2=1.0 L_xmsu2=2.0
.param W_xmsu3=1.0 L_xmsu3=0.15

* DUT Schematic Netlist
VDD VDD 0 1.8
xm1 N003 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
Vo N001 0 DC 1.0 AC 1
X_U1 Vbiasn Vbiasp VDD 0 SUB_1
xm3 N002 N002 N003 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm2 N004 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm4 N001 N002 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm5 N002 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}

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
* 1. DC Operating Point Analysis
op
let vg4_gate_voltage = v(n002)
let power_dissipation = -i(vdd) * 1.8
print vg4_gate_voltage power_dissipation

* 2. Small-Signal AC Analysis for Output Resistance Ro
ac dec 10 1 1k
let ro_ac = 1 / (mag(i(vo)) + 1e-20)
meas ac output_resistance_ro find ro_ac at=10

* 3. DC Sweep of Vo from 0 to 1.8V
dc Vo 0 1.8 0.01
let io_sweep = -i(vo)
meas dc output_current_io find io_sweep at=1.0
let target_current = 0.9 * $&output_current_io
meas dc vo_min_compliance when io_sweep=$&target_current cross=1

print output_resistance_ro
print output_current_io
print vo_min_compliance
quit
.endc
.end