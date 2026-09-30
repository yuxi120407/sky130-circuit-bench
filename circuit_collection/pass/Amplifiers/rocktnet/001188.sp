* Pseudo-Differential Cascode Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=50.0 L_xm1=0.15
.param W_xm2=50.0 L_xm2=0.15
.param W_xm3=50.0 L_xm3=0.15
.param W_xm4=50.0 L_xm4=0.15

* DUT
XM1 N5 N0 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 LABEL_NET_0 N0 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N7 N9 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N8 N2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Biasing and Loads
VVDD VDD 0 1.8
Rload1 VDD N5 1k
Rload2 VDD LABEL_NET_0 1k

* Grounding sources (Pseudo-differential)
Vsrc1 N4 0 0
Vsrc2 N1 0 0

* Cascode bias
Vbias N0 0 1.3

* Differential Inputs (DC=0.75V, AC=1V diff, 2.4GHz 20mVpp diff transient)
Vinp N9 0 dc 0.75 ac 0.5 sin(0.75 0.01 2.4G)
Vinn N2 0 dc 0.75 ac -0.5 sin(0.75 0.01 2.4G 0 0 180)

.control
* DC Operating Point & Power
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

* AC Analysis for Gain and Bandwidth
ac dec 100 1M 100G
let vout_diff = v(N5) - v(LABEL_NET_0)
let gain_db = db(vout_diff)
meas ac voltage_gain find gain_db at=2.4G
meas ac gain_max max gain_db
let gain_3db = gain_max - 3
meas ac bandwidth when gain_db="$&gain_3db" fall=1
print voltage_gain
print bandwidth

* Transient Analysis for Output Swing
tran 10p 5n
let vout_diff_tran = v(N5) - v(LABEL_NET_0)
meas tran vpp_out pp vout_diff_tran
print vpp_out

quit
.endc
.end