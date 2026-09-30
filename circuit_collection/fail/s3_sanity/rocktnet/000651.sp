* Switched-Capacitor Comparator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param VDD=1.8
.param VCM=0.9
.param Cval=80f

* Clocks (20 MHz, non-overlapping)
Vphi1 phi1 0 PULSE(0 1.8 0 100p 100p 24n 50n)
Vphi2 phi2 0 PULSE(0 1.8 25n 100p 100p 24n 50n)

* DC Bias and References
V_label_net_5 label_net_5 0 DC VCM
V_label_net_6 label_net_6 0 DC VCM
V_label_net_4 label_net_4 0 DC 1.0
V_label_net_1 label_net_1 0 DC 0.8

* Differential Input Signal (1 MHz sine wave)
V_label_net_3 label_net_3 0 SINE(0.9 0.3 1Meg)
V_label_net_2 label_net_2 0 SINE(0.9 -0.3 1Meg)

* Power supply for measurement
Vdd_amp vdd 0 DC {VDD}
R_dummy vdd 0 10k

* Switch model
.model switch_ideal SW(Ron=100 Roff=1G vt=0.9)

* Amplifier subcircuit (Idealized Comparator)
.subckt amplifier out in_minus in_plus
B1 out 0 V='v(in_plus) - v(in_minus) > 0 ? 1.8 : 0'
.ends

* DUT (Modified to include capacitor values and switch control nodes)
C1 n0 n3 {Cval}
C2 n1 n2 {Cval}
X1 label_net_0 n1 n0 amplifier
C3 n0 n5 {Cval}
S1 n5 label_net_1 phi1 0 switch_ideal
C4 n1 n4 {Cval}
S2 n4 n5 phi2 0 switch_ideal
S3 n2 n3 phi2 0 switch_ideal
S4 n0 n1 phi1 0 switch_ideal
S5 n2 label_net_2 phi1 0 switch_ideal
S6 n3 label_net_3 phi1 0 switch_ideal
S7 n4 label_net_4 phi1 0 switch_ideal
S8 n0 label_net_5 phi1 0 switch_ideal
S9 n1 label_net_6 phi1 0 switch_ideal

.control
tran 1n 4u

let pwr = -(i(Vphi1)*v(phi1) + i(Vphi2)*v(phi2) + i(V_label_net_5)*v(label_net_5) + i(V_label_net_6)*v(label_net_6) + i(V_label_net_4)*v(label_net_4) + i(V_label_net_1)*v(label_net_1) + i(V_label_net_3)*v(label_net_3) + i(V_label_net_2)*v(label_net_2) + i(Vdd_amp)*v(vdd))
meas tran Power_Consumption avg pwr

meas tran t1 trig v(phi1) val=0.9 rise=1 targ v(phi1) val=0.9 rise=2
meas tran Operating_Frequency param='1/t1'

linearize v(n0) v(n1)
let v_diff = v(n0) - v(n1)
fft v_diff
let v_mag = mag(v_diff)
let v_mag2 = v_mag * v_mag
meas sp fund_pwr integ v_mag2 from=0.9Meg to=1.1Meg
meas sp noise_pwr1 integ v_mag2 from=0.1Meg to=0.9Meg
meas sp noise_pwr2 integ v_mag2 from=1.1Meg to=10Meg
meas sp SNDR param='10 * log10(fund_pwr / (noise_pwr1 + noise_pwr2 + 1e-16))'

dc V_label_net_4 0 1.8 0.1
meas dc Unit_Capacitance param='Cval'

print Power_Consumption Operating_Frequency Unit_Capacitance SNDR
quit
.endc
.end