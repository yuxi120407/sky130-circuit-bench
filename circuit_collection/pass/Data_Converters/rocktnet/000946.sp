* Dual-Path Pipelined ADC MDAC Stage Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param VDD=1.8

* Behavioral models
.subckt amplifier out in_p in_n
G1 0 int in_p in_n 1m
* R1 sets DC gain to 683 (56.7 dB)
R1 int 0 683k
* C1 sets dominant pole for GBW = 1.1 GHz
C1 int 0 145f
E1 out 0 int 0 1
.ends

.subckt switch_ideal n1 n2
R1 n1 n2 1
.ends

* DUT (Modified syntax for ngspice compatibility)
X2f V3f GND N_IN amplifier
C3B N_IN V3f 2f
C2B Vr_x_D2 N_IN 2f
C1B VCMO N_IN 2f
C4 VCMO N_IN 2f
XS1 V3f N_OUT switch_ideal
C3 N_OUT GND 3f

* DC bias to prevent floating node
R_fb N_IN V3f 1T
R_in Vr_x_D2 N_IN 1T

* Sources
VVCMO VCMO 0 0.9
V_Vr_x_D2 Vr_x_D2 0 DC 0.0 AC 1 PULSE(0.0 0.1 1n 10p 10p 10n 20n)

.control
op
print v(V3f) v(N_IN)

ac dec 100 1Meg 10Gig
let gain_db = vdb(V3f)
meas ac dc_gain find gain_db at=1Meg
meas ac bw_3db when gain_db=-3 fall=1

tran 10p 5n
meas tran v_start find v(V3f) at=0.9n
meas tran v_final find v(V3f) at=4n
* Measure 10% to 90% settling time for a -0.1V step
meas tran t_settle trig v(V3f) val=-0.01 fall=1 targ v(V3f) val=-0.09 fall=1

quit
.endc
.end