* CML Latch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Parameter definitions
.param R_load=500
.param R_deg=100

* Wrapper for NPN model to be used as subcircuit
.subckt sky130_fd_pr__npn_05v5 c b e
Q1 c b e sky130_fd_pr__npn_05v5
.ends

* DUT Netlist (with appended resistor values)
R1 VEE N10 {R_deg}
R2 VEE N15 {R_deg}
R3 N0 VCC {R_load}
R4 N2 VCC {R_load}
R5 VEE N6 {R_deg}
X3 N13 VBIAS N15 sky130_fd_pr__npn_05v5
X4 N16 VBIAS N10 sky130_fd_pr__npn_05v5
X1 N0 VBIAS VEE sky130_fd_pr__npn_05v5
X2 N16 VBIAS N10 sky130_fd_pr__npn_05v5
X5 N7 VBIAS N6 sky130_fd_pr__npn_05v5
X6 N4 CK_BAR N7 sky130_fd_pr__npn_05v5
X7 N2 DBAR N4 sky130_fd_pr__npn_05v5
X8 N0 D N4 sky130_fd_pr__npn_05v5
X9 N12 N12 N13 sky130_fd_pr__npn_05v5
X10 N2 Q_BAR N8 sky130_fd_pr__npn_05v5
X11 N11 N11 N16 sky130_fd_pr__npn_05v5
X12 Q Q N11 sky130_fd_pr__npn_05v5
X13 N0 Q N8 sky130_fd_pr__npn_05v5
X14 Q_BAR Q_BAR N12 sky130_fd_pr__npn_05v5
X15 N8 CK N7 sky130_fd_pr__npn_05v5

* Close the feedback loop for the latch
Vq Q N2 0
Vqbar Q_BAR N0 0

* Power Supplies and Biasing
VCC VCC 0 1.8
VEE VEE 0 0
VVBIAS VBIAS 0 0.9

* Input Stimuli (Data at 500MHz, Clock at 1GHz)
VD D 0 pulse(0.6 1.2 1.75n 20p 20p 0.98n 2n)
VDBAR DBAR 0 pulse(1.2 0.6 1.75n 20p 20p 0.98n 2n)
VCK CK 0 pulse(0.6 1.2 0.5n 20p 20p 0.48n 1n)
VCKBAR CK_BAR 0 pulse(1.2 0.6 0.5n 20p 20p 0.48n 1n)

* Differential output for measurement
Bdiff diff_out 0 V=v(N2)-v(N0)

.control
* Transient Analysis
tran 5p 5n

* Measure Voltage Swing
meas tran vmax max v(diff_out) from=2n to=5n
meas tran vmin min v(diff_out) from=2n to=5n
let voltage_swing = vmax - vmin
print voltage_swing

* Measure Propagation Delay (Clock to Q)
meas tran t_trig WHEN v(CK)=0.9 fall=1 from=1.9n
meas tran t_targ WHEN v(diff_out)=0 rise=1 from=1.9n
let propagation_delay = t_targ - t_trig
print propagation_delay

* Measure Operating Frequency
meas tran t_clk1 WHEN v(CK)=0.9 rise=1
meas tran t_clk2 WHEN v(CK)=0.9 rise=2
let clk_period = t_clk2 - t_clk1
let operating_frequency = 1 / clk_period
print operating_frequency

* Measure Average Power Consumption
meas tran avg_current avg i(VCC) from=0 to=5n
let power_consumption = -avg_current * 1.8
print power_consumption

quit
.endc
.end