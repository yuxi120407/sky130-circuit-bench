* Current-Steering Pair Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

XM1 VOUT_P VCTRL_P VIN GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VOUT_N VCTRL_N VIN GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

VDD VDD 0 DC 1.8
R_LOAD1 VDD VOUT_P 5k
R_LOAD2 VDD VOUT_N 5k

V_CTRL_P VCTRL_P 0 DC 1.2
V_CTRL_N VCTRL_N 0 DC 0.8

I_BIAS VIN 0 DC 100u
C_AC VIN_AC VIN 1m
V_IN VIN_AC 0 DC 0 AC 1 SIN(0 0.1 1MEG 0 0)

.control
op
let power = -i(VDD) * 1.8
print power

ac dec 10 1k 10G
let gain_db = db(v(VOUT_P))
meas ac max_gain max gain_db
let gain_3db = max_gain - 3
meas ac bandwidth when gain_db=gain_3db fall=1
print max_gain bandwidth

tran 1n 5u
meas tran vout_max max v(VOUT_P) from=2u to=5u
meas tran vout_min min v(VOUT_P) from=2u to=5u
let vout_pp = vout_max - vout_min
print vout_pp
quit
.endc
.end