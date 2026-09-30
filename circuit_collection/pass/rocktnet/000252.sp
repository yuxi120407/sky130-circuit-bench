* Switched-Capacitor Summing Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param C_f=1p C_r=1p C_g=2p C_b=1p

* Runnable equivalent of the abstract DUT
* OTA Macro-model with finite bandwidth
G1 Vout_pre GND N0 GND 1m
R1 Vout_pre GND 10Meg
C1 Vout_pre GND 1p
E1 Vout GND Vout_pre GND 1

Cf N0 Vout {C_f}
Cr N0 _Vr {C_r}
Cg N0 Vg {C_g}
Cb N0 _Vb {C_b}
S1 N0 Vout clk GND switch_model
.model switch_model SW(Vt=0.9 Ron=100 Roff=1G)

* Stimulus
* Phase 1 (Reset 1): 0 to 10ns. clk is high, Vr is sampled.
* Phase 2 (Evaluate 1): 10.1ns to 60ns. clk goes low, Vr goes to 0, transferring charge to Cf.
* Phase 3 (Reset 2): 60.1ns to 70ns. clk is high, Vg is sampled.
* Phase 4 (Evaluate 2): 70.1ns to 120ns. clk goes low, Vg goes to 0, transferring charge to Cf.
V_clk clk GND pwl(0 1.8 10n 1.8 10.1n 0 60n 0 60.1n 1.8 70n 1.8 70.1n 0 120n 0)
V_Vr _Vr GND pwl(0 1.0 11n 1.0 11.1n 0 120n 0)
V_Vg Vg GND pwl(0 0 60n 0 60.1n 1.0 71n 1.0 71.1n 0 120n 0)
V_Vb _Vb GND pwl(0 0 120n 0)

.control
tran 0.1n 120n

* Measure final settled voltages for Red and Green channels
meas tran vout_r_final find v(Vout) at=59n
meas tran vout_g_final find v(Vout) at=119n

* Calculate voltage gains (Input step is 1.0V)
let voltage_gain_r = vout_r_final / 1.0
let voltage_gain_g = vout_g_final / 1.0

* Measure settling time (99% of the 0.9995V actual final value is ~0.9895V)
* Trigger is set to the start of the evaluation phase (when Vr starts falling)
meas tran settling_time trig v(_Vr) val=0.99 fall=1 targ v(Vout) val=0.9895 rise=1

print voltage_gain_r
print voltage_gain_g
print settling_time

quit
.endc
.end