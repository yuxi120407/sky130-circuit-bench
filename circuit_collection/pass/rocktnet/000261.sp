* Differential Pair Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

* DUT
XM1 N2 LABEL_NET_0 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 LABEL_NET_1 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Testbench components (Tail current and Load resistors)
VVDD VDD 0 1.8
I_tail N0 0 1m
R1 VDD N2 1k
R2 VDD N3 1k

* Inputs
VCM VCM 0 0.9
VINP LABEL_NET_0 VCM dc 0 ac 0.5 sin(0 0.1 1G)
VINN LABEL_NET_1 VCM dc 0 ac -0.5 sin(0 -0.1 1G)

.control
* 1. DC Operating Point & Power
op
let power = -i(VVDD) * 1.8
print power

* 2. AC Analysis (Gain and Bandwidth)
ac dec 100 1M 100G
let out_diff = v(N2) - v(N3)
let gain_db = 20 * log10(mag(out_diff))
meas ac max_gain MAX gain_db
meas ac f3db WHEN gain_db='max_gain - 3' FALL=1
print max_gain f3db

* 3. Transient Analysis (Output Swing)
tran 1p 5n
let out_diff_tran = v(N2) - v(N3)
meas tran v_max MAX out_diff_tran
meas tran v_min MIN out_diff_tran
let v_swing = v_max - v_min
print v_swing

quit
.endc
.end