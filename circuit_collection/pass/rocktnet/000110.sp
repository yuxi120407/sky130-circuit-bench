* Single NMOS Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

.param W_xm1=5.0 L_xm1=0.5

XM1 N1 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

VVDD VDD 0 1.8
RL VDD N1 1k
VIN N0 0 DC 0.9 AC 1 SIN(0.9 0.2 100Meg)

.control
op
let id = -i(VVDD)
let power = id * 1.8
print id power

ac dec 100 1Meg 10Gig
let gain_db = vdb(N1)
meas ac gain_1M find gain_db at=1Meg
meas ac gain_1G find gain_db at=1Gig

tran 10p 50n
meas tran vout_max max v(N1)
meas tran vout_min min v(N1)
let vout_pp = vout_max - vout_min
let vout_p = vout_pp / 2
let pout_w = (vout_p * vout_p) / (2 * 1000)
let pout_dbm = 10 * log10(pout_w * 1000)
print vout_pp pout_dbm
four 100Meg v(N1)
quit
.endc
.end
