* Gilbert Cell Mixer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_rf=50
.param L_rf=0.15
.param W_lo=20
.param L_lo=0.15
.param RL=500
.param RE=10
.param CL=2p
.param I_tail=2m

* DUT
X1 N1 Vin N3 0 sky130_fd_pr__nfet_01v8 w={W_rf} l={L_rf}
X2 N2 Vinb N4 0 sky130_fd_pr__nfet_01v8 w={W_rf} l={L_rf}
X3 Vob LO N1 0 sky130_fd_pr__nfet_01v8 w={W_lo} l={L_lo}
X4 Vo LOb N1 0 sky130_fd_pr__nfet_01v8 w={W_lo} l={L_lo}
X5 Vob LOb N2 0 sky130_fd_pr__nfet_01v8 w={W_lo} l={L_lo}
X6 Vo LO N2 0 sky130_fd_pr__nfet_01v8 w={W_lo} l={L_lo}

R1 VCC Vob RL
R2 VCC Vo RL
R3 N4 N5 RE
R4 N3 N5 RE
C1 Vo VCC CL
C2 Vob VCC CL
I1 N5 VEE I_tail

* Supplies
VVCC VCC 0 DC 1.8
VVEE VEE 0 DC 0

* RF Inputs (930 MHz, 10mV peak per side)
VRF Vin 0 DC 0.9 SIN(0.9 0.01 930MEG 0 0 0) AC 1 0
VRFB Vinb 0 DC 0.9 SIN(0.9 0.01 930MEG 0 0 180) AC 1 180

* LO Inputs (920 MHz, 300mV peak per side)
VLO LO 0 DC 1.3 SIN(1.3 0.3 920MEG 0 0 0)
VLOB LOb 0 DC 1.3 SIN(1.3 0.3 920MEG 0 0 180)

* Differential Output Calculation
B1 Vdiff 0 V=v(Vo)-v(Vob)

.control
* 1. Transient Analysis for Conversion Gain and Power
* IF is 10 MHz (Period = 100ns). Run for 300ns, measure last 100ns.
tran 10p 300n
meas tran vout_max max v(Vdiff) from=200n to=300n
meas tran vout_min min v(Vdiff) from=200n to=300n
let vout_pp = vout_max - vout_min
* Input RF is 20mV peak-to-peak differential
let conv_gain = vout_pp / 0.02
let conversion_gain = 20 * log10(conv_gain)
print conversion_gain

meas tran pwr_avg avg i(VVCC) from=200n to=300n
let power_consumption = -pwr_avg * 1.8
print power_consumption

* 2. AC Analysis for IF Bandwidth
* Unbalance the LO to make the mixer act as a cascode amplifier
alter VLO dc=1.8
alter VLOB dc=0
ac dec 10 1Meg 10Gig
let vdiff_db = vdb(Vdiff)
meas ac max_gain max vdiff_db
let gain_3db = max_gain - 3
meas ac if_bandwidth when vdiff_db=gain_3db fall=1
print if_bandwidth

quit
.endc
.end