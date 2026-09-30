* Stacked NMOS Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

* DUT
XM1 N9 INPUT N3 N4 sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 INPUT N9 N0 sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Biasing and Loads
RL N2 VDD 10k
VN3 N3 0 0
VN4 N4 0 0
VN0 N0 0 0

* Sources
VVDD VDD 0 1.8
VINPUT INPUT 0 DC 0.9 AC 1 SIN(0.9 0.1 1MEG 0 0)

.control
* 1. DC Operating Point
op
let dc_power = -i(VVDD) * 1.8
print dc_power

* 2. AC Analysis
ac dec 100 1k 100MEG
let gain_db = vdb(N2)
meas ac gain_1mhz find gain_db at=1MEG

* 3. Transient Analysis
tran 10n 5u
meas tran vout_max max v(N2)
meas tran vout_min min v(N2)
let output_swing = vout_max - vout_min
print output_swing

quit
.endc
.end