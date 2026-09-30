* Ngspice Testbench for Beta-Multiplier Reference
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Parameter definitions based on Fig 20.18
.param W_xm1=50.0 L_xm1=2.0
.param W_xm2=200.0 L_xm2=2.0
.param W_xm3=100.0 L_xm3=2.0
.param W_xm4=100.0 L_xm4=2.0
.param W_xmsu1=50.0 L_xmsu1=2.0
.param W_xmsu2=10.0 L_xmsu2=20.0
.param W_xmsu3=10.0 L_xmsu3=1.0

* Circuit Netlist (DUT)
VDD VDD 0 1.8
xmsu2 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
xmsu1 N001 Vref 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
xmsu3 N002 N001 Vref 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
xm3 Vref N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm1 Vref Vref 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 N002 Vref N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
R1 N003 0 5000.0

.control
* 1. Operating Point Analysis at 27C
op
let vref = v(vref)
let iref = v(N003)/5000.0
let power_dissipation = -i(VDD) * 1.8
print vref iref power_dissipation

* 2. VDD Sweep from 0 to 1.8 V (VDD_min and Supply Sensitivity)
dc VDD 0 1.8 0.01
let iref_dc = v(N003)/5000.0
meas dc iref_1v2 find iref_dc at=1.2
meas dc iref_1v8 find iref_dc at=1.8
let supply_sensitivity_iref = (iref_1v8 - iref_1v2) / 0.6
print supply_sensitivity_iref

meas dc vref_nom_dc find v(vref) at=1.8
meas dc vdd_min when v(vref)='0.9*vref_nom_dc' cross=1
print vdd_min

* 3. Temperature Sweep from 0 to 100 C
dc temp 0 100 5
let iref_t = v(N003)/5000.0
meas dc vref_t0 find v(vref) at=0
meas dc vref_t100 find v(vref) at=100
let temp_coeff_vref = (vref_t100 - vref_t0) / 100.0
print temp_coeff_vref

meas dc iref_t0 find iref_t at=0
meas dc iref_t27 find iref_t at=27
meas dc iref_t100 find iref_t at=100
let temp_coeff_iref = (iref_t100 - iref_t0) / (100.0 * iref_t27)
print temp_coeff_iref

quit
.endc
.end