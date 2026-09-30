* Testbench for Chapter 26 Fig 26.3 Self-Biased Reference
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xma3=0.5
.param L_xma4=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Parameter definitions from Fig. 26.3 schematic
.param W_xmsu2=10.0 L_xmsu2=20.0
.param W_xmsu1=10.0 L_xmsu1=1.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xm1=10.0   L_xm1=1.0
.param W_xm2=10.0   L_xm2=2.0
.param W_xm3=20.0   L_xm3=1.0
.param W_xm4=20.0   L_xm4=1.0
.param W_xm5=10.0   L_xm5=2.0
.param W_xm6=40.0   L_xm6=1.0
.param W_xm7=100.0  L_xm7=100.0
.param W_xma3=20.0  L_xma3=2.0
.param W_xma4=20.0  L_xma4=2.0

* Circuit Netlist (DUT)
xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
xmsu1 N002 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
xmsu3 VDD N002 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
R1 N004 0 4000.0
xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
xm5 N001 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm2 Vbiasp Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm6 N003 N003 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
VDD VDD 0 1.8

.control
* Run operating point analysis at nominal VDD = 1.8V
op

let iref_val = v(N004) / 4000.0
let vbiasn_val = v(vbiasn)
let vbiasp_val = v(vbiasp)
let v_sgp_val = v(vdd) - v(vbiasp)
let total_current_val = -i(vdd)
let power_val = total_current_val * 1.8

print iref_val
print vbiasn_val
print vbiasp_val
print v_sgp_val
print total_current_val
print power_val

meas op iref find iref_val at=0
meas op vbiasn find vbiasn_val at=0
meas op vbiasp find vbiasp_val at=0
meas op v_sgp find v_sgp_val at=0
meas op total_current find total_current_val at=0
meas op power_dissipation find power_val at=0

* Run DC sweep of VDD from 0 to 1.8V to measure turn-on and min_vdd
dc VDD 0 1.8 0.01

let iref_sweep = v(N004) / 4000.0
let i_target = 0.9 * iref_val
meas dc min_vdd when iref_sweep=i_target rise=1

print min_vdd
quit
.endc
.end