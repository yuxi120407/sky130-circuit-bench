* VCO Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

.param W_xm1=10.0 L_xm1=0.15

* DUT
R1 N4 GND 10k
L1 VCC N1 1n
I1 N0 GND 5m
R2 N8 GND 10k
L2 VCC N3 1n
R3 N5 VB 10k
R4 N6 VB 10k
C1 N1 N4 1p
D1 N4 VTUNE varactor
C2 VTUNE GND 10p
C3 VTUNE GND 10p
Q1 N3 N6 N0 npn
D2 N8 VTUNE varactor
C4 N1 N6 1p
C5 N3 N5 1p
C6 N3 N8 1p
Q2 N1 N5 N0 npn

* Models
.model npn npn (is=1e-16 bf=100)
.model varactor d (cjo=1p m=0.5 vj=0.8)

* Sources
VVCC VCC 0 1.8
VVB VB 0 0.9
VVTUNE VTUNE 0 0.9

* Initial conditions to start oscillation
.ic v(N1)=1.8 v(N3)=1.7

.control
* Transient analysis
tran 1p 10n

* Measure oscillation frequency
meas tran t1 trig v(N1) val=1.8 rise=20 targ v(N1) val=1.8 rise=21
let f_osc = 1 / t1
print f_osc

* Measure voltage swing
meas tran vmax max v(N1) from=5n to=10n
meas tran vmin min v(N1) from=5n to=10n
let vswing = vmax - vmin
print vswing

* Measure power
op
let power = -i(VVCC) * 1.8
print power

quit
.endc
.end
