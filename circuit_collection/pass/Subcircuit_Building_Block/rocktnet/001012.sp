* Testbench for NMOS Current Sinks

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xmcs=0.5

.param W_xmcs=5.0 L_xmcs=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

* Bias and Supply Voltages
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_2 LABEL_NET_2 0 0.9

* Load voltages to measure current
V_N1 N1 0 1.8
V_OUT OUT 0 1.8

* DUT
XMCS GND LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xmcs} w={W_xmcs}
XM2 N1 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 OUT LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

.control
* 1. Operating Point Analysis for DC Currents
op
let i_out = -i(V_OUT)
let i_n1 = -i(V_N1)
print i_out i_n1

* 2. DC Sweep for Output Resistance
dc V_OUT 0 1.8 0.01
meas dc i_18 find i(V_OUT) at=1.8
meas dc i_17 find i(V_OUT) at=1.7
* Calculate resistance: dV / dI. Note that i(V_OUT) is negative.
let r_out = 0.1 / (i_17 - i_18)
print r_out

quit
.endc
.end