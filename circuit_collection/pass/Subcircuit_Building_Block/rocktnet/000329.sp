* Differential Pair Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

XM1 N2 LABEL_NET_0 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 LABEL_NET_2 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Power Supply and Biasing
VVDD VDD 0 1.8
I_tail N_tail 0 1m
V_tie1 N4 N_tail 0
V_tie2 N6 N_tail 0

* Loads
R1 VDD N2 2k
R2 VDD N1 2k
C1 N2 0 100f
C2 N1 0 100f

* Inputs (DC bias + AC + Transient Sine)
V_INP LABEL_NET_0 0 dc 0.9 ac 0.5 sin(0.9 0.1 100Meg)
V_INN LABEL_NET_2 0 dc 0.9 ac -0.5 sin(0.9 -0.1 100Meg)

.control
* 1. DC Operating Point
op
let power = 1.8 * (-i(VVDD))
print power

* 2. AC Analysis
ac dec 100 1Meg 10Gig
let out_diff = v(N1) - v(N2)
let gain_mag = mag(out_diff)
let gain_db = 20 * log10(gain_mag)
meas ac dc_gain find gain_db at=1Meg
meas ac ugbw when gain_db=0 fall=1

* 3. Transient Analysis
tran 100p 20n
meas tran vout_max max v(N1)
meas tran vout_min min v(N1)

quit
.endc
.end