* Beta-Multiplier Reference Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=40.0 L_xm2=1.0
.param W_xm3=20.0 L_xm3=1.0
.param W_xm4=20.0 L_xm4=1.0
.param W_xmsu1=5.0 L_xmsu1=1.0
.param W_xmsu2=2.0 L_xmsu2=10.0
.param W_xmsu3=2.0 L_xmsu3=1.0

* Circuit Under Test
VDD VDD 0 1.8
xmsu2 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
xmsu1 N001 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
xmsu3 Vbiasp N001 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 Vbiasp Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 Vbiasp Vbiasn N002 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
R1 N002 0 6500.0

.control
save all
op
let reference_current = v(N002) / 6500.0
let transconductance = @m.xm1.msky130_fd_pr__nfet_01v8[gm]
let overdrive_voltage = @m.xm1.msky130_fd_pr__nfet_01v8[vdsat]
let startup_leakage_current = @m.xmsu3.msky130_fd_pr__nfet_01v8[id]
let total_power = -i(VDD) * 1.8

print reference_current
print transconductance
print overdrive_voltage
print startup_leakage_current
print total_power

dc VDD 0 1.8 0.01
let iref = v(N002) / 6500.0
meas dc iref_at_1p2 find iref at=1.2
meas dc iref_at_1p8 find iref at=1.8
meas dc supply_sensitivity param='(iref_at_1p8 - iref_at_1p2) / 0.6'
meas dc iref_target param='0.9 * iref_at_1p2'
meas dc minimum_vdd when iref=iref_target rise=1

quit
.endc
.end