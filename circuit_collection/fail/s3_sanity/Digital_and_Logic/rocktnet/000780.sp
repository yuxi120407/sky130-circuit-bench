* SiGe HBT MUX Subcircuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

.param V_EE=-1.8
.param W_xm1=1 L_xm1=0.15

Vee VEE 0 V_EE
Vclk CLK 0 PULSE(-0.6 -0.2 0 10p 10p 100p 200p)
Vn5 N5 0 PULSE(-0.6 -0.2 50p 10p 10p 200p 400p)
Vn3 N3 0 DC -0.4
Vn2 N2 0 PULSE(-0.2 0.2 50p 10p 10p 200p 400p)

* DUT (Resistor values added for simulation)
R1 N10 N6 1k
R2 N7 VEE 1k
R3 N6 VEE 1k
R4 N4 VEE 1k
R5 GND N8 1k
R6 GND GND 1k
R7 GND VEE 1k
Q1 N2 N5 N6 npn
Q2 GND N2 N0 npn
Q3 N8 GND N0 npn
Q4 GND GND N2 npn
Q5 GND N3 GND npn
Q6 N3 CLK N4 npn
Q7 GND N8 N2 npn
Q8 N8 N8 GND npn
Q9 GND N5 N10 npn
Q10 N0 GND N7 npn
Q11 N8 N0 GND pnp

.model npn NPN(is=1e-16 bf=100 tf=1p cje=10f cjc=10f)
.model pnp PNP(is=1e-16 bf=50 tf=1p cje=10f cjc=10f)

.control
op
tran 1p 3n

* Power measurement
let power = abs(i(Vee) * 1.8)
meas tran power_consumption avg power
print power_consumption

* Voltage swing measurement
meas tran v_max max v(N8)
meas tran v_min min v(N8)
meas tran voltage_swing param='v_max - v_min'
print voltage_swing

* Rise and fall time measurement
meas tran v10 param='v_min + 0.1 * voltage_swing'
meas tran v90 param='v_min + 0.9 * voltage_swing'
meas tran v_mid param='v_min + 0.5 * voltage_swing'

meas tran rise_time trig v(N8) val=v10 rise=2 targ v(N8) val=v90 rise=2
meas tran fall_time trig v(N8) val=v90 fall=2 targ v(N8) val=v10 fall=2
meas tran rise_fall_time param='(rise_time + fall_time) / 2'
print rise_fall_time

* RMS jitter measurement
meas tran t1 trig v(N8) val=v_mid rise=2
meas tran t2 trig v(N8) val=v_mid rise=3
meas tran t3 trig v(N8) val=v_mid rise=4
meas tran t4 trig v(N8) val=v_mid rise=5
meas tran p1 param='t2 - t1'
meas tran p2 param='t3 - t2'
meas tran p3 param='t4 - t3'
meas tran p_avg param='(p1 + p2 + p3) / 3'
meas tran j1 param='p1 - p_avg'
meas tran j2 param='p2 - p_avg'
meas tran j3 param='p3 - p_avg'
meas tran rms_jitter param='sqrt((j1*j1 + j2*j2 + j3*j3)/3)'
print rms_jitter

quit
.endc
.end