* RF Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_m14=10.0 L_m14=0.15
.param W_m15=50.0 L_m15=0.15

VVDD VDD 0 1.8
VIIN IIN 0 DC 0.9 AC 1 SIN(0.9 0.1 1.9G 0 0)

* DUT (Adapted from NPN to SKY130 NMOS)
Ibias VDD N1 1m
XM15 N0 N1 0 0 sky130_fd_pr__nfet_01v8 w={W_m15} l={L_m15}
L1 VDD N0 10n
XM14 N1 N1 0 0 sky130_fd_pr__nfet_01v8 w={W_m14} l={L_m14}
C1 N0 Vout 1p
C2 N1 IIN 1p

* Load
Rload Vout 0 50

.control
* DC Analysis
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

* AC Analysis
ac dec 50 100MEG 10G
let gain_db = db(v(Vout))
meas ac voltage_gain find gain_db at=1.9G
meas ac center_frequency max_at gain_db
print voltage_gain
print center_frequency

* Transient Analysis
tran 10p 5n
meas tran vout_swing pp v(Vout)
print vout_swing
.endc
.end