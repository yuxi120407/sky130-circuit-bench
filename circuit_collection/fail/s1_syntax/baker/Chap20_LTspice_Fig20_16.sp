* Beta-Multiplier Reference Testbench (Baker Fig. 20.15)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xmsu1=10.0 L_xmsu1=2.0
.param W_xmsu2=10.0 L_xmsu2=100.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xm1=10.0   L_xm1=2.0
.param W_xm2=40.0   L_xm2=2.0
.param W_xm3=30.0   L_xm3=2.0
.param W_xm4=30.0   L_xm4=2.0

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
set filetype=ascii
save all
save @m.xm1.msky130_fd_pr__nfet_01v8[gm]
save @m.xm1.msky130_fd_pr__nfet_01v8[vth]
save @m.xmsu3.msky130_fd_pr__nfet_01v8[id]

* === Operating Point Analysis ===
op

let iref = v(N002) / 6500.0
let vgs1 = v(Vbiasn)
let delta_vgs = v(N002)
let power = -i(VDD) * 1.8

let gm = @m.xm1.msky130_fd_pr__nfet_01v8[gm]
let vds_sat1 = vgs1 - @m.xm1.msky130_fd_pr__nfet_01v8[vth]
let startup_leakage_current = @m.xmsu3.msky130_fd_pr__nfet_01v8[id]

print iref gm vds_sat1 vgs1 delta_vgs startup_leakage_current power

* === DC Supply Sweep ===
dc VDD 0 1.8 0.01

meas dc v_n002_nom find v(N002) at=1.8
let iref_nom = v_n002_nom / 6500.0

let v_n002_target = 0.9 * v_n002_nom
meas dc vdd_min when v(N002)=v_n002_target rise=1

meas dc v_n002_1v6 find v(N002) at=1.6
let iref_1v6 = v_n002_1v6 / 6500.0

let supply_sensitivity = (iref_nom - iref_1v6) / 0.2
print vdd_min supply_sensitivity

quit
.endc
.end