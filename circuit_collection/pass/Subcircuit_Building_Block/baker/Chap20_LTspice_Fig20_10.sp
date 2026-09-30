* Testbench for PMOS Current Mirror with Resistor Bias
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

* Define parameters for the parameterized netlist
.param W_xm1=100 L_xm1=2
.param W_xm2=100 L_xm2=2

* --- DUT (Device Under Test) ---
xm2 0 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
VDD VDD 0 1.8
R1 N001 0 65000.0
* -------------------------------

.control
* 1. Operating Point Analysis (Measure currents and Lambda mismatch)
op
* I_REF is the current through R1
let iref_op = v(N001) / 65000.0
* Total current supplied by VDD
let itotal_op = -i(VDD)
* I_O is the current through xm2 (Total - I_REF)
let iout_op = itotal_op - iref_op
* Calculate the current ratio (I_O / I_REF)
let current_ratio = iout_op / iref_op

print iref_op iout_op current_ratio

* 2. DC Sweep Analysis (Measure Supply Sensitivity)
dc VDD 0.9 1.8 0.01
* Calculate I_REF across the sweep
let iref_sweep = v(N001) / 65000.0
* Calculate the derivative (Sensitivity = d(I_REF)/d(VDD))
let sensitivity = deriv(iref_sweep)

* Extract the sensitivity at nominal VDD (1.8V)
meas dc sens_at_1v8 find sensitivity at=1.8

quit
.endc
.end