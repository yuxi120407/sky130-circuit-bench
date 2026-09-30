* Chap24_LTspice_Fig24_32_no_load
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

VDD vdd 0 1.8
VSS vss 0 0

* Bias
Iref vdd nbias 10u
XM1 nbias nbias vss vss sky130_fd_pr__nfet_01v8 w=5.0 l=2.0
XM2 tail nbias vss vss sky130_fd_pr__nfet_01v8 w=10.0 l=2.0

* Diff pair
XM3 d1 vinn tail vss sky130_fd_pr__nfet_01v8 w=20.0 l=2.0
XM4 d2 vinp tail vss sky130_fd_pr__nfet_01v8 w=20.0 l=2.0

* Active load
XM5 d1 d1 vdd vdd sky130_fd_pr__pfet_01v8 w=10.0 l=2.0
XM6 d2 d1 vdd vdd sky130_fd_pr__pfet_01v8 w=10.0 l=2.0

* Second stage
XM7 vout d2 vss vss sky130_fd_pr__nfet_01v8 w=40.0 l=2.0
XM8 vout pbias vdd vdd sky130_fd_pr__pfet_01v8 w=20.0 l=2.0

* pbias generation
XM9 pbias nbias vss vss sky130_fd_pr__nfet_01v8 w=5.0 l=2.0
XM10 pbias pbias vdd vdd sky130_fd_pr__pfet_01v8 w=10.0 l=2.0

* Compensation
Cc d2 vout 2p

* Testbench Stimulus
Vinp vinp 0 DC 1.1 AC 1 PULSE(0.9 1.4 1n 1n 1n 5u 10u)
Lfb vout vinn 1G
Cac vinn 0 1G

.control
* AC Analysis
ac dec 10 1 1G
let gain_mag = v(vout)
let gain_db = db(gain_mag)
let phase_deg = 180 / 3.14159265359 * vp(vout)

meas ac open_loop_gain MAX gain_db
meas ac unity_gain_frequency when gain_db=0 fall=1
meas ac phase_at_ugf find phase_deg when gain_db=0 fall=1
let phase_margin = phase_at_ugf + 180
print open_loop_gain
print unity_gain_frequency
print phase_margin

* Transient Analysis
alter Lfb 1n
alter Cac 1f
tran 10n 10u

meas tran t1 when v(vout)=1.0 rise=1
meas tran t2 when v(vout)=1.3 rise=1
let slew_rate = (1.3 - 1.0) / (t2 - t1) / 1e6
print slew_rate
.endc
.end