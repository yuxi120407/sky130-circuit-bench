* Push-Push Frequency Doubler Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Define generic NPN model since SKY130 NPNs have different subcircuit names
.model npn npn (bf=100 is=1e-15 vaf=50)

* DUT (with component values added for simulation)
Q1 n0 label_net_0 n2 npn
Q2 n0 n1 n2 npn
C1 n2 label_net_1 10p
R1 VDD n0 1k
R2 n2 GND 1k
C2 n1 label_net_2 10p

* Biasing and Sources
VVDD VDD 0 1.8

* Symmetric Differential RF input at 1GHz (0.1V peak)
Vbias0 label_net_0 0 dc 0.9 sin(0.9 0.1 1G 0 0 0)
Vbias2 n1 0 dc 0.9 sin(0.9 0.1 1G 0 0 180)

* AC ground for emitter bypass
Vbias1 label_net_1 0 dc 0

* Ground label_net_2 since C2 is now just a load
Vbias_net2 label_net_2 0 dc 0

* B-sources for Fourier integration
B_sin1 out_sin1 0 V=v(n0) * sin(2 * 3.14159265359 * 1e9 * time)
B_cos1 out_cos1 0 V=v(n0) * cos(2 * 3.14159265359 * 1e9 * time)
B_sin2 out_sin2 0 V=v(n0) * sin(2 * 3.14159265359 * 2e9 * time)
B_cos2 out_cos2 0 V=v(n0) * cos(2 * 3.14159265359 * 2e9 * time)

.control
* 1. DC Operating Point for Power Consumption
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

* 2. Transient Analysis for Conversion Gain and Fundamental Rejection
tran 5p 20n

* Integrate over steady state (10ns to 20ns)
meas tran int_sin1 integ v(out_sin1) from=10n to=20n
meas tran int_cos1 integ v(out_cos1) from=10n to=20n
meas tran int_sin2 integ v(out_sin2) from=10n to=20n
meas tran int_cos2 integ v(out_cos2) from=10n to=20n

* Calculate amplitudes (T_int = 10ns)
let amp1 = 2 * sqrt(int_sin1 * int_sin1 + int_cos1 * int_cos1) / 10n
let amp2 = 2 * sqrt(int_sin2 * int_sin2 + int_cos2 * int_cos2) / 10n

* Input fundamental differential amplitude is 0.2V
let conversion_gain = amp2 / 0.2

* Fundamental rejection [dBc]
let fundamental_rejection = 20 * log10((amp1 + 1e-15) / (amp2 + 1e-15))

print conversion_gain
print fundamental_rejection

quit
.endc
.end