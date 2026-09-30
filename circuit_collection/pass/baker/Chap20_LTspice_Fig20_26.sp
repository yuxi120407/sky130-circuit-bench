* Testbench for Resistor-MOSFET PMOS Current Mirror Reference (Fig 20.11 / Fig 20.25)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=10.0 L_xm2=1.0

* Circuit Under Test (DUT)
xm2 0 VD1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xm1 VD1 VD1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
R1 VD1 0 65000.0

.control
* Run DC sweep over temperature from 0C to 100C
dc temp 0 100 1

* Measure voltages at nominal temperature (27C)
meas dc reference_gate_voltage find v(VD1) at=27

* Measure reference current at nominal temperature (27C)
let iref_vec = v(VD1) / 65000.0
meas dc reference_current find iref_vec at=27

* Measure mirrored output current at nominal temperature (27C)
* Current into ground from xm2 drain (node 0)
let i_total = -i(VDD)
let i_out = i_total - iref_vec
meas dc output_mirrored_current find i_out at=27

* Measure temperature variations of VD1 and VSG
meas dc vd1_0 find v(VD1) at=0
meas dc vd1_100 find v(VD1) at=100

let vsg_0 = 1.8 - vd1_0
let vsg_100 = 1.8 - vd1_100
let vsg_temp_coeff = (vsg_100 - vsg_0) / 100.0

* Measure temperature coefficient of reference current TCIREF
meas dc iref_0 find iref_vec at=0
meas dc iref_100 find iref_vec at=100
let iref_temp_coeff = (iref_100 - iref_0) / (100.0 * reference_current)

print reference_current reference_gate_voltage vsg_temp_coeff iref_temp_coeff output_mirrored_current

quit
.endc
.end