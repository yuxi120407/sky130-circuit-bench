* Adaptive Cable Equalizer Interpolator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Generic NPN model for simulation (since netlist uses 'npn')
.model npn npn(is=1e-16 bf=100 cje=10f cjc=10f)

* DUT
I1 E_TAIL GND 1m
Q1 VEQ_P VFAST_N E_LEFT npn
Q2 E_RIGHT VCONTROL_N E_TAIL npn
Q3 E_LEFT VCONTROL_P E_TAIL npn
Q4 VEQ_N VFAST_P E_LEFT npn
Q5 VEQ_P VSLOW_P E_RIGHT npn
Q6 VEQ_N VSLOW_N E_RIGHT npn
R1 VDD VEQ_P 1k
R2 VDD VEQ_N 1k

* Biasing and Sources
VVDD VDD GND 1.8
VVCONTROL_P VCONTROL_P GND 1.2
VVCONTROL_N VCONTROL_N GND 0.6

* Inputs (Fast path active, Slow path AC grounded)
VFAST_P VFAST_P GND dc 0.9 ac 0.5 sin(0.9 0.01 1G)
VFAST_N VFAST_N GND dc 0.9 ac -0.5 sin(0.9 -0.01 1G)
VSLOW_P VSLOW_P GND dc 0.9 ac 0
VSLOW_N VSLOW_N GND dc 0.9 ac 0

.control
* DC Analysis
op
let power = -i(VVDD)*1.8
print power
meas dc power_meas param power

* AC Analysis
ac dec 100 1Meg 100Gig
let vout_diff = v(VEQ_P) - v(VEQ_N)
let gain_db = vdb(vout_diff)
meas ac low_freq_gain find gain_db at=1Meg
meas ac bw_3db when gain_db='low_freq_gain-3' fall=1

* Transient Analysis
tran 10p 5n
let vout_diff_tran = v(VEQ_P) - v(VEQ_N)
meas tran vout_max max vout_diff_tran from=2n to=5n
meas tran vout_min min vout_diff_tran from=2n to=5n
let tran_swing = vout_max - vout_min
print tran_swing

quit
.endc
.end
