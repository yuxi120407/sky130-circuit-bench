* Testbench for Switched-Capacitor Charge Pump (Fig 17.10)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

* Define parameters used in the parameterized netlist
.param W_xm1=5.0 L_xm1=0.15
.param W_xm2=5.0 L_xm2=0.15
.param W_xm3=5.0 L_xm3=0.15

* --- DUT (Device Under Test) ---
VDD VDD 0 1.8
xm3 N001 phi1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm1 N002 phi2 N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
xm2 vbit 0 N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
C1 N001 0 1e-13
* -------------------------------

* Non-overlapping clocks (100MHz, T=10ns)
* phi1: active low (0V) from 0.1ns to 4.1ns (M3 ON, charges Ccup)
Vphi1 phi1 0 PULSE(1.8 0 0 100p 100p 4n 10n)
* phi2: active low (0V) from 5.1ns to 9.1ns (M1 ON, dumps Ccup to vbit)
Vphi2 phi2 0 PULSE(1.8 0 5n 100p 100p 4n 10n)

* Bitline voltage source (fixed at 0.9V to measure charge transfer)
Vbit_src vbit 0 DC 0.9

.control
* Run transient for 5 cycles (50ns)
tran 10p 50n

* 1. Measure charge dumped into vbit during the 3rd cycle (t=25n to 30n)
meas tran q_dump_raw integ i(Vbit_src) from=25n to=30n
let charge_dumped_per_cycle = abs(q_dump_raw)
print charge_dumped_per_cycle

* 2. Measure average current over one full cycle (20n to 30n)
meas tran q_cycle_raw integ i(Vbit_src) from=20n to=30n
let average_feedback_current = abs(q_cycle_raw) / 10n
print average_feedback_current

* --- Calculate System-Level Metrics (Eq 17.8, 17.9, 17.10) ---
* Assume typical system parameters:
let N_cycles = 15
let Cbit_sys = 500e-15
let Tclk = 10e-9

* Eq 17.9: Dynamic Range (dB)
let dynamic_range = 20 * log10(N_cycles)
print dynamic_range

* Eq 17.10: Minimum resolvable signal (A)
let minimum_resolvable_signal = average_feedback_current / N_cycles
print minimum_resolvable_signal

* Eq 17.8: Max bitline deviation (V)
let max_bitline_deviation = (average_feedback_current * Tclk) / Cbit_sys
print max_bitline_deviation

quit
.endc
.end