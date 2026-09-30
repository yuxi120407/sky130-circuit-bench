* Op-Amp Open-Loop AC Testbench (Fig 24.9)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Core Op-Amp
XM1 n1 vminus n3 0 sky130_fd_pr__nfet_01v8 w=10.0 l=1.0
XM2 n2 vplus n3 0 sky130_fd_pr__nfet_01v8 w=10.0 l=1.0
XM3 n1 n1 vdd vdd sky130_fd_pr__pfet_01v8 w=20.0 l=1.0
XM4 n2 n1 vdd vdd sky130_fd_pr__pfet_01v8 w=20.0 l=1.0
XM5 n3 bias 0 0 sky130_fd_pr__nfet_01v8 w=10.0 l=1.0
XM6 vout n2 vdd vdd sky130_fd_pr__pfet_01v8 w=80.0 l=1.0
XM7 vout bias 0 0 sky130_fd_pr__nfet_01v8 w=20.0 l=1.0
XM8 bias bias 0 0 sky130_fd_pr__nfet_01v8 w=10.0 l=1.0
Iref vdd bias 10u
Cc n2 nz 1p
Rz nz vout 2.5k

* Testbench
VDD vdd 0 1.8
Vref vplus 0 0.9
Vac in 0 dc 0 ac 1
C1 in vminus 10u
R1 vout vminus 100Meg
CL vout 0 2p

.control
op
let power_dissipation = -i(VDD) * 1.8
print power_dissipation

ac dec 100 1 10G
let A_ol = v(vout)/v(vminus)
let gain_db = db(A_ol)
let phase_deg = ph(A_ol) * 180 / 3.14159265358979323846

meas ac open_loop_gain MAX gain_db
let g3 = open_loop_gain - 3
meas ac dominant_pole_f1 when gain_db = $&g3

meas ac unity_gain_frequency_fun when gain_db = 0

meas ac phase_margin find phase_deg when gain_db = 0

meas ac second_pole_f2 when phase_deg = 45

meas ac gain_at_0 find gain_db when phase_deg = 0
let gain_margin = -gain_at_0
print gain_margin

.endc
.end