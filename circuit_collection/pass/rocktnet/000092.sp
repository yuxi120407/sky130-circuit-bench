* Testbench for Differential Pair
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

* DUT
XM1 LABEL_NET_0 LABEL_NET_1 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 LABEL_NET_2 LABEL_NET_3 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Biasing and Loads
VDD vdd 0 1.8
R1 vdd LABEL_NET_0 1k
R2 vdd LABEL_NET_2 1k
I_tail N0 0 1m

* Inputs
Vcm vcm 0 1.2
V_in_p LABEL_NET_1 vcm dc 0 ac 0.5
V_in_n LABEL_NET_3 vcm dc 0 ac -0.5

* Differential to Single-Ended Converter for easy measurement
E1 out_diff 0 LABEL_NET_0 LABEL_NET_2 1

.control
op
let pwr = 1.8 * -i(VDD)
print pwr

ac dec 100 1Meg 100G
let gain_db = vdb(out_diff)
meas ac max_gain MAX gain_db
let gain_3db = max_gain - 3
meas ac bw_3db when gain_db=gain_3db fall=1

print max_gain bw_3db
quit
.endc
.end