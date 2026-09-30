* Testbench for Figure 18.28 & 18.30: DC Generation Circuit
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Parameter definitions for parameterized netlist
.param W_xm1=2.0  L_xm1=0.15
.param W_xm2=2.0  L_xm2=0.15
.param W_xm3=4.0  L_xm3=0.15
.param W_xm4=4.0  L_xm4=0.15
.param W_xm5=4.0  L_xm5=0.15
.param W_xm6=2.0  L_xm6=0.15
.param W_xm7=2.0  L_xm7=0.15
.param W_xm8=2.0  L_xm8=0.15
.param W_xm9=4.0  L_xm9=0.15
.param W_xm10=4.0 L_xm10=0.15
.param W_xm11=2.0 L_xm11=0.15
.param W_xm12=4.0 L_xm12=0.15

* Power Supplies
VDD VDD 0 1.8

* Input Data Signal: 50 MHz pulses (20ns period, 10ns width)
Vvin Vin 0 PULSE(0 1.8 10n 0.1n 0.1n 10n 20n)

* Circuit Under Test (Figures 18.28 and 18.30)
X_U1 Max In N001 VDD 0 SUB_1
X_U2 Min In N002 VDD 0 SUB_1
X_U3 In Avg Out VDD 0 SUB_1
xm1 Max N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
xm2 Min N002 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
C1 Max 0 1e-12
C2 0 Min 1e-12
C3 Avg 0 1e-12
R1 Max Avg 100000.0
R2 Avg Min 100000.0
R3 Vin In 1000.0
C4 In 0 1e-11
R4 VDD In 1000.0
R5 In 0 1000.0

* Subcircuit Definition from Figure 18.23
.subckt SUB_1 Vinp Vinm Out VDD GND
  xm1 N004 Vinm N005 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm3 N004 N004 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 N002 N004 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm2 N002 Vinp N005 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  xm6 N005 N004 GND 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
  xm5 Out N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
  xm7 Out N002 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
  xm8 N003 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
  xm9 N003 Vinm N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
  xm10 N002 Vinp N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
  xm11 N002 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
  xm12 N001 N003 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm12} l={L_xm12}
.ends SUB_1

.control
tran 0.1n 300n

* Measure input node In levels in steady state
meas tran v_in_min min v(In) from=200n to=300n
meas tran v_in_max max v(In) from=200n to=300n
let input_node_dc_voltage_range_min = v_in_min
let input_node_dc_voltage_range_max = v_in_max
let delta_vin = v_in_max - v_in_min
let input_attenuation_factor = delta_vin / 1.8
print input_node_dc_voltage_range_min input_node_dc_voltage_range_max input_attenuation_factor

* Measure channel effective 10% to 90% rise time to verify tau_eff = tr / 2.2
meas tran t_rise trig v(In) val=0.66 rise=2 targ v(In) val=1.14 rise=2
let effective_channel_time_constant = t_rise / 2.197
print effective_channel_time_constant

* Measure DC generator peak, valley, and average voltages
meas tran v_peak_steady find v(Max) at=290n
meas tran v_valley_steady find v(Min) at=290n
meas tran dc_reference_average_voltage find v(Avg) at=290n
print v_peak_steady v_valley_steady dc_reference_average_voltage

* Averaging filter time constant
let averaging_filter_time_constant = 50000 * 1e-12
print averaging_filter_time_constant

* Measure output swing of slicing buffer
meas tran slicing_buffer_output_swing_min min v(Out) from=200n to=300n
meas tran slicing_buffer_output_swing_max max v(Out) from=200n to=300n
print slicing_buffer_output_swing_min slicing_buffer_output_swing_max

* Measure propagation delays
meas tran t_plh trig v(In) val=0.90 rise=1 td=200n targ v(Out) val=0.90 rise=1 td=200n
meas tran t_phl trig v(In) val=0.90 fall=1 td=200n targ v(Out) val=0.90 fall=1 td=200n
let slicing_buffer_propagation_delay = (t_plh + t_phl) / 2
print t_plh t_phl slicing_buffer_propagation_delay

quit
.endc
.end