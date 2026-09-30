* Testbench for Baker Fig 19.25 VCO Tuning and Bias Scheme
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xmref=0.5

* Parameterized transistor sizes
.param W_xm1=2.0   L_xm1=0.5
.param W_xm2=2.0   L_xm2=0.5
.param W_xm3=4.0   L_xm3=0.5
.param W_xm4=4.0   L_xm4=0.5
.param W_xm5=4.0   L_xm5=0.5
.param W_xm6=8.0   L_xm6=0.5
.param W_xm7=2.0   L_xm7=0.5
.param W_xm8=4.0   L_xm8=0.5
.param W_xm9=4.0   L_xm9=0.5
.param W_xm10=2.0  L_xm10=0.5
.param W_xmref=5.0 L_xmref=0.5

* DUT Instance (direct netlist)
xm1 N004 N004 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
Vindel Vindel 0 dc 0.8
VDD VDD 0 dc 1.8
xm3 N004 n2_ac N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 Vrbias Vref N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm2 Vrbias N004 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm5 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
xm7 n2 Vrbias 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
xm6 N003 N004 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
xmref N001 Vindel P001 0 sky130_fd_pr__nfet_01v8 w={W_xmref} l={L_xmref}
R1 P001 0 10000.0
VREF VREF 0 dc 500mV
xm8 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
xm9 n2 0 N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
xm10 n2 n2 0 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}

* Small AC coupling for open-loop AC analysis
Vac n2_ac n2 dc 0 ac 1
Cload Vrbias 0 50f

.control
save all

* 1. DC Operating Point Analysis
op
let id_mref = v(P001)/10000.0
let v_n2_regulated = v(n2)
let vrbias = v(Vrbias)
let power = -i(VDD) * 1.8
print id_mref v_n2_regulated vrbias power

* 2. Supply Sensitivity Analysis over VDD
dc VDD 1.6 2.0 0.05
meas dc vrbias_vdd_low find v(Vrbias) at=1.6
meas dc vrbias_vdd_high find v(Vrbias) at=2.0
let supply_sensitivity = (vrbias_vdd_high - vrbias_vdd_low) / 0.4
print supply_sensitivity

* 3. AC Analysis for Error Amplifier
ac dec 100 1 10G
let a_ol = db(v(Vrbias)/v(n2_ac))
meas ac opamp_open_loop_gain find a_ol at=1
meas ac opamp_unity_gain_frequency when a_ol=0 fall=1

print opamp_open_loop_gain opamp_unity_gain_frequency
quit
.endc
.end