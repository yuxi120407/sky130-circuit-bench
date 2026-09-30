* Testbench for MOSFET-only current mirror bias circuits (Baker Fig 20.13)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm4p=30.0
.param L_xm4p=2.0
.param W_xm3n=30.0
.param L_xm3n=2.0
.param W_xm1n=10.0
.param L_xm1n=270.0
.param W_xm3p=10.0
.param L_xm3p=90.0
.param W_xm1p=10.0
.param L_xm1p=2.0
.param W_xm2n=10.0
.param L_xm2n=2.0

xm4p 0 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4p} l={L_xm4p}
xm3n N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3n} l={L_xm3n}
VDD VDD 0 1.8
xm1n N001 N001 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1n} l={L_xm1n}
xm3p N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3p} l={L_xm3p}
xm1p N002 N002 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1p} l={L_xm1p}
xm2n VDD N002 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2n} l={L_xm2n}

.control
save all
save @m.xm4p.msky130_fd_pr__pfet_01v8[id]
save @m.xm2n.msky130_fd_pr__nfet_01v8[id]

dc VDD 1.5 2.1 0.005

let i_op_vec = abs(@m.xm4p.msky130_fd_pr__pfet_01v8[id])
let i_on_vec = abs(@m.xm2n.msky130_fd_pr__nfet_01v8[id])
let di_op_vec = deriv(i_op_vec)
let di_on_vec = deriv(i_on_vec)

meas dc i_op find i_op_vec at=1.8
meas dc i_on find i_on_vec at=1.8
meas dc v_bias_nmos_res find v(N001) at=1.8
meas dc v_bias_pmos_res find v(N002) at=1.8
meas dc di_op_dvdd find di_op_vec at=1.8
meas dc di_on_dvdd find di_on_vec at=1.8

print i_op i_on v_bias_nmos_res v_bias_pmos_res di_op_dvdd di_on_dvdd
quit
.endc
.end