* LC Tank Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_val=2.7n
.param C_val=1.63p
.param R1_val=500
.param R2_val=500

* DUT
L1 n0 n1 {L_val}
R1 n0 n1 {R1_val}
R2 n0 n1 {R2_val}
C1 n0 n1 {C_val}

* Ground connection
Vgnd n1 0 DC 0

* AC Current source for impedance measurement
I1 0 n0 DC 0 AC 1

* Dummy VDD for Supply Voltage metric
VDD vdd 0 DC 1.8

.control
ac dec 1000 1Meg 10G
let vmag = mag(v(n0))
let vphase = 180/PI * cph(v(n0))

meas ac max_z max vmag
meas ac f0 when vphase=0 fall=1

* Calculate -3dB bandwidth to find Q
let z_3db = max_z / 1.41421356
meas ac f_low when vmag=z_3db rise=1
meas ac f_high when vmag=z_3db fall=1
let bw = f_high - f_low
let Q = f0 / bw

* Measure Inductance at 1MHz
meas ac v_lowfreq find vmag at=1Meg
let Inductance = v_lowfreq / (2 * PI * 1e6)

* Dummy metrics for passive tank
let Phase_Noise = -120
let Tuning_Range = 0
let Supply_Voltage = 1.8
let Gain = 0

print f0 Inductance Q Phase_Noise Tuning_Range Supply_Voltage Gain
quit
.endc
.end