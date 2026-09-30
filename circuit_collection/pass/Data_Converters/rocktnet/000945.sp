* MDAC Stage Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param c=1p

* Macro-model for the Op-Amp (Tuned to 56.7dB DC Gain, 1.1GHz GBW)
.subckt amplifier out in_p in_n
G1 0 int_node in_p in_n 1m
R1 int_node 0 683k
C1 int_node 0 0.145p
E1 out 0 int_node 0 1
.ends

* Macro-model for the Ideal Switch
.subckt switch_ideal n1 n2
R1 n1 n2 10
.ends

* --- DUT (Modified slightly to use valid ngspice subcircuit prefixes 'X') ---
XA2c V3C 0 NET1 amplifier
Xphi1 V3C NET2 switch_ideal
C1 NET2 0 1p
C3_2c VCMO NET1 {2*c}
C1B_2c VR_XD2 NET1 {2*c}
C2B_2c NET1 V3C {2*c}
* ---------------------------------------------------------------------------

* DC Biasing and Stimulus
* VCMO is set to 0V for simplicity in observing the step response
VVCMO VCMO 0 0
* Input steps from 0V to 0.1V
VVR_XD2 VR_XD2 0 dc 0 ac 1 pulse(0 0.1 1n 10p 10p 10n 20n)

* Large resistor to provide DC feedback and set the operating point (prevents floating node NET1)
Rfb NET1 V3C 1G

.control
* 1. AC Analysis for Closed-Loop Gain and Bandwidth
ac dec 100 1 10G

let opamp_gain_db = db(v(V3C)) - db(v(NET1))
meas ac opamp_dc_gain find opamp_gain_db at=1
meas ac opamp_gbw when opamp_gain_db=0 fall=1

let cl_gain_db = db(v(V3C))
meas ac closed_loop_gain find cl_gain_db at=1MEG
let cl_gain_ref = closed_loop_gain - 3
meas ac closed_loop_bw when cl_gain_db=cl_gain_ref fall=1

* 2. Transient Analysis for Step Response and Settling Time
tran 10p 20n
* Measure 1% settling time (Target is -0.099V since input is 0.1V and gain is -1)
meas tran settling_time trig v(VR_XD2) val=0.05 rise=1 targ v(V3C) val=-0.099 fall=1

print opamp_dc_gain opamp_gbw closed_loop_gain closed_loop_bw settling_time
.endc
.end