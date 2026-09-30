* Single NMOS Transistor Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

* DUT
.param W_xm1=5.0 L_xm1=0.5
XM1 N0 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* Testbench components
VDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 dc 0.9 ac 1
RL VDD N0 10k
CL N0 0 10f

.control
* DC Operating Point Analysis
op
let id = -i(VDD)
let power = id * 1.8
print id power

* AC Analysis
ac dec 100 1k 100G
let gain_db = vdb(N0)
meas ac low_freq_gain find gain_db at=10k
let target_gain = $&low_freq_gain - 3
meas ac bw_3db when gain_db=target_gain fall=1

quit
.endc
.end