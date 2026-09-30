* Cherry-Hooper Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* DUT (Values appended to prevent syntax errors from incomplete extraction)
V1 N4 LABEL_NET_0 0
V2 N8 N3 0
V3 N0 N10 0
I1 GND N5 0
I2 N3 N2 0
I3 N3 N2 0
I4 vo1 N9 0
R1 N0 GND 1k
R2 N2 N4 1k
R3 N5 N8 1k
R5 N6 N7 1k
R4 N3 N9 1k
R6 N2 N10 1k
R7 N5 N6 1k
R8 N7 GND 1k
R9 vo1 N7 1k
R10 N9 LABEL_NET_1 1k

* Biasing and Sources
VLABEL_NET_0 LABEL_NET_0 0 dc 0.9 ac 0.5
VLABEL_NET_1 LABEL_NET_1 0 dc 0.9 ac -0.5
VN8 N8 0 dc 1.8
VN0 N0 0 dc 1.8

.control
* DC Analysis
op
let power = -(i(VN8) + i(VN0)) * 1.8
print power

* AC Analysis
ac dec 100 1M 100G
let gain_db = vdb(vo1)
meas ac low_freq_gain find gain_db at=1M
let gain_db_3db = low_freq_gain - 3
meas ac bw when gain_db=gain_db_3db fall=1

* Group Delay Calculation
let phase_rad = cph(v(vo1))
let group_delay = -deriv(phase_rad) / (2 * 3.14159265359)
meas ac gd_1M find group_delay at=1M

* Transient Analysis
tran 1p 10n
.endc
.end
