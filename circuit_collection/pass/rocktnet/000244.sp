* Differential Pair Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

* DUT
XM1 N3 LABEL_NET_0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 LABEL_NET_1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Biasing and Loads
VVDD VDD 0 1.8
I_tail N1 0 1m
R1 VDD N3 2k
R2 VDD N2 2k

* Inputs (Common mode 0.9V, Differential AC 1V)
V_in1 LABEL_NET_0 0 dc 0.9 ac 0.5
V_in2 LABEL_NET_1 0 dc 0.9 ac -0.5

.control
* DC Operating Point & Power
op
let power = -i(VVDD) * 1.8
print power
print v(N3) v(N2) v(N1)

* AC Analysis for Gain and Bandwidth
ac dec 100 1Meg 100G
let vout_diff = v(N3) - v(N2)
let gain_mag = mag(vout_diff)
let gain_db = 20 * log10(gain_mag)

meas ac midband_gain find gain_db at=1Meg
let gain_3db = midband_gain - 3
meas ac bw_3db when gain_db=gain_3db fall=1

quit
.endc
.end
