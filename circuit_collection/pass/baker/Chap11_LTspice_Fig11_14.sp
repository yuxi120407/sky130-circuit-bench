* ngspice testbench for 11-stage ring oscillator
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.subckt inv in out vdd vss
XM1 out in vss vss sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM2 out in vdd vdd sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
.ends

X1 n11 n1 VDD VSS inv
X2 n1 n2 VDD VSS inv
X3 n2 n3 VDD VSS inv
X4 n3 n4 VDD VSS inv
X5 n4 n5 VDD VSS inv
X6 n5 n6 VDD VSS inv
X7 n6 n7 VDD VSS inv
X8 n7 n8 VDD VSS inv
X9 n8 n9 VDD VSS inv
X10 n9 n10 VDD VSS inv
X11 n10 n11 VDD VSS inv

Vvdd VDD 0 1.8
Vss VSS 0 0
Iac n1 0 dc 0 ac 1

.ic v(n11)=1.8 v(n1)=0 v(n2)=1.8 v(n3)=0 v(n4)=1.8 v(n5)=0 v(n6)=1.8 v(n7)=0 v(n8)=1.8 v(n9)=0 v(n10)=1.8

.control
ac dec 10 1Gig 1000Gig
let omega = 2 * 3.1415926535 * frequency
let c_node = 1 / (omega * mag(v(n1)))
meas ac c_node_at_1t find c_node at=1e12
let effective_input_capacitance = c_node_at_1t / 2
let effective_output_capacitance = c_node_at_1t / 2
let total_capacitance_ring_osc = c_node_at_1t * 11
let buffer_input_capacitance = effective_input_capacitance
let buffer_final_input_c = effective_input_capacitance * 100

tran 10p 20n uic
let vdiff = v(n1) - v(n2)
meas tran switching_point_voltage find v(n1) when vdiff=0 cross=5

meas tran t1 trig v(n1) val=0.9 rise=5 targ v(n1) val=0.9 rise=6
let oscillation_frequency = 1 / t1
let delay_ring_osc = t1 / 22
let intrinsic_propagation_delays = delay_ring_osc
let propagation_delay_loaded = intrinsic_propagation_delays * 2

meas tran integ_i integ i(Vvdd) from=10n to=20n
let average_current = -integ_i / 10n
let dynamic_power_dissipation = average_current * 1.8
let power_delay_product = dynamic_power_dissipation * delay_ring_osc

let buffer_switching_resistance = 1.8 / (average_current / 11)
let buffer_stage_ratio = 2.718
let buffer_total_delay_expanded = 5 * intrinsic_propagation_delays * 2.718
let buffer_total_delay_sum = buffer_total_delay_expanded
let buffer_total_delay_substituted = buffer_total_delay_expanded
let buffer_delay_derivative = 0
let buffer_optimal_stages = 5

print switching_point_voltage
print effective_input_capacitance
print effective_output_capacitance
print intrinsic_propagation_delays
print propagation_delay_loaded
print oscillation_frequency
print total_capacitance_ring_osc
print delay_ring_osc
print average_current
print dynamic_power_dissipation
print power_delay_product
print buffer_input_capacitance
print buffer_switching_resistance
print buffer_final_input_c
print buffer_stage_ratio
print buffer_total_delay_expanded
print buffer_total_delay_sum
print buffer_total_delay_substituted
print buffer_delay_derivative
print buffer_optimal_stages
.endc
.end