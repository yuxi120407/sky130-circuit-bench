* Switched-Capacitor Integrator Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param C_val=1p
.param V_in=0.1

* DUT (Adapted for standard SPICE syntax)
XAo Vout XIN 0 VDD 0 amplifier
XS1 N3 Vin phi1 0 switch_ideal
CF Vout XIN {C_val}
CI N2 N3 {C_val}
XS2 XIN N2 phi2 0 switch_ideal
XS3 N3 0 phi2 0 switch_ideal
XS4 N2 0 phi1 0 switch_ideal

* Models and Subcircuits
.subckt switch_ideal n1 n2 ctrl ctrl_ref
S1 n1 n2 ctrl ctrl_ref sw_mod
.model sw_mod sw vt=0.9 vh=0.1 ron=100 roff=1G
.ends

.subckt amplifier out in_neg in_pos vdd vss
* Simple Opamp Macro Model (Gain = 1000, GBW = 159MHz)
G1 vss int in_pos in_neg 1m
R1 int vss 1Meg
C1 int vss 1p
E1 out vss int vss 1
R_iq vdd vss 10k
.ends

* Sources
VVDD VDD 0 DC 1.8
VVIN Vin 0 DC {V_in}
* 50MHz Non-overlapping clocks
Vphi1 phi1 0 PULSE(0 1.8 0 0.1n 0.1n 9n 20n)
Vphi2 phi2 0 PULSE(0 1.8 10n 0.1n 0.1n 9n 20n)

* Reset switch to initialize CF
XS_rst Vout XIN rst 0 switch_ideal
Vrst rst 0 PWL(0 1.8 9n 1.8 9.1n 0)

.control
tran 0.1n 100n

* Measure voltage step between cycle 1 and cycle 2
meas tran vout_c1 find v(Vout) at=39n
meas tran vout_c2 find v(Vout) at=59n
let voltage_step = vout_c2 - vout_c1
print voltage_step

* Measure settling time during the 2nd active integration phase (2nd phi2 pulse)
* Vout goes from 0.1V to 0.2V; 90% of the step is 0.19V
meas tran settling_time trig v(phi2) val=0.9 rise=2 targ v(Vout) val=0.19 rise=1
print settling_time

* Measure power consumption
meas tran i_vdd_integ integ i(VVDD) from=0 to=100n
let power_consumption = -(i_vdd_integ / 100n) * 1.8
print power_consumption

quit
.endc
.end