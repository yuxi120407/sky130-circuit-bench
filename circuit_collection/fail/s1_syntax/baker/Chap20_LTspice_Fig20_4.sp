* NMOS Current Mirror Testbench (Baker Fig 20.4)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=2.0 L_xm1=1.0
.param W_xm2=2.0 L_xm2=1.0

* Circuit Netlist (DUT)
VDD_SRC N001 0 DC 1.8
xm1 N003 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
R1  N001 N003 200000.0
xm2 N002 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
Vo  N002 0 DC 0.6

.control
dc Vo 0 1.8 0.005

let io = -i(Vo)
let iref = -i(VDD_SRC)

meas dc reference_current find iref at=1.0
meas dc vgs1 find v(N003) at=1.0

let vds_sat_vec = v(N003) - 0.42
meas dc vds_sat find vds_sat_vec at=1.0

let compliance_range_vec = 1.8 - vds_sat_vec
meas dc compliance_range find compliance_range_vec at=1.0

let vth_mismatch_sensitivity_vec = 2.0 / vds_sat_vec
meas dc vth_mismatch_sensitivity find vth_mismatch_sensitivity_vec at=1.0

meas dc io_at_match find io when v(N002)=v(N003)
meas dc iref_at_match find iref when v(N002)=v(N003)
let matched_current_ratio = io_at_match / iref_at_match

let g_out = deriv(io)
meas dc g_out_1v find g_out at=1.0
let output_resistance = 1 / g_out_1v

meas dc io_at_1v find io at=1.0
meas dc iref_at_1v find iref at=1.0
let ratio_at_1v = io_at_1v / iref_at_1v
let vds_mismatch_error = ratio_at_1v - matched_current_ratio

print reference_current
print vgs1
print vds_sat
print compliance_range
print matched_current_ratio
print output_resistance
print vds_mismatch_error
print vth_mismatch_sensitivity

quit
.endc
.end