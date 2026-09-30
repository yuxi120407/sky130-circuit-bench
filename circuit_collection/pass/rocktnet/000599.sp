* Bias Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 VBN VBN GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 LABEL_NET_0 VBN LABEL_NET_0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VBN VBP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 GND VBP GND VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

* Voltage Sources
VVDD VDD 0 1.8
VVBP_ideal VBP_ideal 0 0.99 ac 1
R_VBP VBP_ideal VBP_sense 1Meg
V_sense VBP_sense VBP 0
VLABEL_NET_0 LABEL_NET_0 0 0

.control
* DC Operating Point Analysis
op
let i_bias = -i(VVDD)
let power = i_bias * 1.8
let vbn_dc = v(VBN)
print i_bias power vbn_dc

* AC Analysis for Transfer Function and Bandwidth
ac dec 100 1k 100G
let gain_db = vdb(VBN)
meas ac ac_gain max gain_db
meas ac bandwidth when gain_db='ac_gain-3' fall=1

* Filter Capacitance
let omega = 2 * pi * frequency
let c_xm2_vec = im(i(VLABEL_NET_0) / v(VBN)) / omega
let c_vbp_vec = im(i(V_sense) / v(VBP)) / omega
let filter_cap_vec = c_xm2_vec + c_vbp_vec
meas ac filter_capacitance find filter_cap_vec at=100k

print ac_gain bandwidth filter_capacitance

quit
.endc
.end