* Testbench for BMR with Cascode PMOS Mirror (Figure 23.9)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.options savecurrents
.nodeset V(Vbiasn)=0.5 V(Vbiasp)=1.1 V(Vpcas)=0.5 V(N001)=1.7 V(N002)=0.0 V(N003)=0.02

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3b=0.5
.param L_xm3t=0.5
.param L_xm4b=0.5
.param L_xm4t=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Parameter definitions for devices
.param W_xmsu1=50.0 L_xmsu1=2.0
.param W_xmsu2=10.0 L_xmsu2=20.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xm3t=100.0 L_xm3t=2.0
.param W_xm3b=100.0 L_xm3b=2.0
.param W_xm4t=100.0 L_xm4t=2.0
.param W_xm4b=100.0 L_xm4b=2.0
.param W_xm1=50.0  L_xm1=2.0
.param W_xm2=200.0 L_xm2=2.0

* Power supply
VDD VDD 0 1.8

* DUT Circuit Netlist
xmsu1 N002 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
xmsu3 Vbiasp N002 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
xm3t N001 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3t} l={L_xm3t}
xm3b Vbiasn Vpcas N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm3b} l={L_xm3b}
xm4t Vbiasp Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4t} l={L_xm4t}
xm4b Vpcas Vpcas Vbiasp VDD sky130_fd_pr__pfet_01v8 w={W_xm4b} l={L_xm4b}
xm2 Vpcas Vbiasn N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
R1 N003 0 6500.0

.control
* 1. Operating Point Analysis
op

let iref2 = v(N003) / 6500.0
let iref1 = @m.xm1.msky130_fd_pr__nfet_01v8[id]
let iref_nominal = iref1
let current_matching_error = iref1 - iref2
let vbiasn_voltage = v(Vbiasn)
let startup_msu3_vgs = v(N002) - v(Vbiasn)
let quiescent_power = -i(VDD) * 1.8

print iref_nominal
print current_matching_error
print vbiasn_voltage
print startup_msu3_vgs
print quiescent_power

* 2. DC Sweep from 1.8V to 0V to observe turn-off and line sensitivity
dc VDD 1.8 0 -0.01

* Measure turn-on voltage where IREF reaches 50% of nominal value
meas dc v_n003_nom find v(N003) at=1.8
meas dc half_v_n003 param='0.5 * v_n003_nom'
meas dc vdd_min when v(N003)=half_v_n003 cross=1

* Measure line sensitivity between 1.2V and 1.8V
meas dc v_n003_1v2 find v(N003) at=1.2
meas dc vbiasn_at_1v2 find v(Vbiasn) at=1.2
meas dc vbiasn_at_1v8 find v(Vbiasn) at=1.8

meas dc iref_at_1v8 param='v_n003_nom / 6500.0'
meas dc iref_at_1v2 param='v_n003_1v2 / 6500.0'
meas dc line_sensitivity_iref param='(iref_at_1v8 - iref_at_1v2) / 0.6'
meas dc line_sensitivity_vbiasn param='(vbiasn_at_1v8 - vbiasn_at_1v2) / 0.6'

print vdd_min
print line_sensitivity_iref
print line_sensitivity_vbiasn

quit
.endc
.end