* Testbench for Improved Beta-Multiplier Reference (Fig. 20.22)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Sizing Parameters
.param W_xm1=10.0
.param L_xm1=0.5
.param W_xm2=40.0
.param L_xm2=0.5
.param W_xm3=20.0
.param L_xm3=0.5
.param W_xm4=20.0
.param L_xm4=0.5
.param W_xma3=20.0
.param L_xma3=0.5
.param W_xma4=20.0
.param L_xma4=0.5
.param W_xm5=10.0
.param L_xm5=0.5
.param W_xm6=10.0
.param L_xm6=0.5
.param W_xmsu1=10.0
.param L_xmsu1=0.5
.param W_xmsu2=2.0
.param L_xmsu2=5.0
.param W_xmsu3=2.0
.param L_xmsu3=0.5
.param W_xm7=10.0
.param L_xm7=10.0
.param W_xm8=10.0
.param L_xm8=10.0

* Supply Voltage
VDD VDD 0 1.8

* Circuit Netlist (Fig. 20.22 DUT)
xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
xmsu1 N002 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
xmsu3 Vbiasp N002 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 N003 N003 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
R1 N004 0 5500.0
xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
xm5 N001 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 Vbiasp Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 0 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}

.control
save all @m.xm1.msky130_fd_pr__nfet_01v8[id] @m.xm1.msky130_fd_pr__nfet_01v8[gm] @m.xm1.msky130_fd_pr__nfet_01v8[vth] @m.xmsu3.msky130_fd_pr__nfet_01v8[id]

* 1. Operating Point Analysis
op
let transconductance_gm = @m.xm1.msky130_fd_pr__nfet_01v8[gm]
let vth_m1 = @m.xm1.msky130_fd_pr__nfet_01v8[vth]
let vgs_m1 = v(Vbiasn)
let vov_overdrive_voltage = vgs_m1 - vth_m1
let startup_quiescent_current = abs(@m.xmsu3.msky130_fd_pr__nfet_01v8[id])

print transconductance_gm vov_overdrive_voltage startup_quiescent_current

* 2. DC Sweep Analysis for Supply Sensitivity and VDDmin
dc VDD 0 1.8 0.01
let iref_sweep = abs(@m.xm1.msky130_fd_pr__nfet_01v8[id])
let d_iref = deriv(iref_sweep)
let v_mismatch = abs(v(N003) - v(Vbiasn))

meas dc reference_current find iref_sweep at=1.8
meas dc supply_sensitivity find d_iref at=1.8
meas dc minimum_supply_voltage when iref_sweep=2.5u rise=1
meas dc drain_voltage_mismatch find v_mismatch at=1.8

print reference_current supply_sensitivity minimum_supply_voltage drain_voltage_mismatch

quit
.endc
.end