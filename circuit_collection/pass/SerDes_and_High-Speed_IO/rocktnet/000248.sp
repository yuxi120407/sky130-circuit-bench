* 50-Gb/s CML Buffer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Define a high-speed NPN model to simulate the extracted Q instances
.model npn npn (is=1e-16 bf=100 tf=2p cje=20f cjc=20f)

* Power Supplies (ECL levels)
V_VEE VEE 0 DC -3.6

* Bias and Reference
VVB VB 0 DC -2.5
VREF REF 0 DC -0.15

* Input Signal (50 Gb/s -> 25 GHz fundamental)
VIN IN 0 DC -0.15 AC 1 SIN(-0.15 0.15 25G)

* --- DUT Netlist ---
Q1 N8 N6 N3 npn
Q2 0 REF N5 npn
R1 N16 0 50
R2 N17 VEE 50
R3 N15 VEE 50
Q3 N1 N5 N11 npn
R4 N1 0 50
R5 N8 0 50
R6 N20 VEE 50
R7 N10 VEE 50
R8 N9 VEE 50
Q4 0 N1 N7 npn
Q5 N16 N7 N3 npn
R9 REF 0 50
Q6 N0 N12 N11 npn
R10 N19 VEE 50
Q7 0 N16 OUT2 npn
R11 IN 0 50
R12 N0 0 50
Q8 0 N8 OUT1 npn
Q9 0 N0 N6 npn
R13 N14 VEE 50
R14 N28 VEE 50
Q10 N7 VB N17 npn
Q11 N11 VB N20 npn
Q12 OUT1 VB N9 npn
Q13 OUT2 VB N10 npn
Q14 N3 VB N14 npn
Q15 N6 VB N28 npn
Q16 0 IN N12 npn
Q17 N5 VB N15 npn
Q18 N12 VB N19 npn
* -------------------

.control
* 1. DC Operating Point & Power
op
let power_dissipation = abs(i(V_VEE) * 3.6)
print power_dissipation

* 2. AC Analysis for Bandwidth and Gain
ac dec 50 100M 100G
let gain_db = db(v(OUT1))
meas ac dc_gain find gain_db at=100M
let gain_3db = dc_gain - 3
meas ac bandwidth when gain_db=$&gain_3db fall=1
print dc_gain
print bandwidth

* 3. Transient Analysis for Swing, Delay, Rise/Fall Time
tran 1p 200p
* Measure over a stable window to avoid startup transients
meas tran v_max max v(OUT1) from=100p to=200p
meas tran v_min min v(OUT1) from=100p to=200p
let voltage_swing = v_max - v_min
print voltage_swing

let v_20 = v_min + 0.2 * voltage_swing
let v_80 = v_min + 0.8 * voltage_swing
let v_mid = v_min + 0.5 * voltage_swing

* Measure on the 3rd cycle to ensure steady state
meas tran t_rise trig v(OUT1) val=$&v_20 rise=1 td=115p targ v(OUT1) val=$&v_80 rise=1 td=115p
meas tran t_fall trig v(OUT1) val=$&v_80 fall=1 td=115p targ v(OUT1) val=$&v_20 fall=1 td=115p
let rise_fall_time = (t_rise + t_fall) / 2
print rise_fall_time

meas tran t_in WHEN v(IN)=-0.15 rise=1 td=115p
meas tran t_out WHEN v(OUT1)=$&v_mid rise=1 td=115p
let propagation_delay = abs(t_out - t_in)
print propagation_delay

quit
.endc
.end