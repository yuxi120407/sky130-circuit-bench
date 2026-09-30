* Testbench for Figure 27.26 Four-Quadrant CMOS Analog Multiplier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

* Sizing parameters for multiplying quad (Baker 10/2)
.param W_xm1=10.0 L_xm1=2.0
.param W_xm2=10.0 L_xm2=2.0
.param W_xm3=10.0 L_xm3=2.0
.param W_xm4=10.0 L_xm4=2.0

* Circuit Netlist (DUT)
E1 vom N002 vp vm 1e4
E2 N002 vop vp vm 1e4
VCM N002 0 0.5V
R1 vm vom 20000.0
R2 vop vp 20000.0
xm1 N001 N005 vm 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 N003 N004 vm 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 N001 N004 vp 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 N003 N005 vp 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
Vx N001 N003 0
Vxdc N006 0 DC 0.5
Vydc N007 0 1.5
Vy N005 N004 0
R3 N001 N006 20000.0
R4 N003 N006 20000.0
R5 N005 N007 20000.0
R6 N004 N007 20000.0

.control
* 1. Operating Point: Measure DC offset voltage with vx=0, vy=0
op
let output_offset_voltage = v(vop) - v(vom)
print output_offset_voltage

* 2. DC Sweep: Set Vy to 0.1V and sweep Vx from -0.1V to +0.1V
alter Vy 0.1
dc Vx -0.1 0.1 0.001

let vout = v(vop) - v(vom)
meas dc vout_at_pos01 find vout at=0.1
meas dc vout_at_zero  find vout at=0.0
meas dc vout_at_neg01 find vout at=-0.1

let differential_output_voltage = vout_at_pos01
print differential_output_voltage

* Calculate multiplier gain Km = d(vout) / (vx * vy)
let multiplier_gain = (vout_at_pos01 - vout_at_neg01) / (0.2 * 0.1)
print multiplier_gain

* Quad transconductance parameter beta
let quad_transconductance_parameter = multiplier_gain / 20000.0
print quad_transconductance_parameter

* Differential branch current
let differential_branch_current = differential_output_voltage / 20000.0
print differential_branch_current

* Nonlinearity deviation
let ideal_vout = multiplier_gain * (v(N001) - v(N003)) * 0.1
let diff_vout = vout - ideal_vout
let abs_diff = abs(diff_vout)
meas dc max_abs_diff max abs_diff
let nonlinearity_deviation = (max_abs_diff / differential_output_voltage) * 100
print nonlinearity_deviation

quit
.endc
.end