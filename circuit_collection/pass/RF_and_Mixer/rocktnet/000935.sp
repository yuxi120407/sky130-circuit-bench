* Double-Balanced Mixer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

XM1 N2 LABEL_NET_1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 LABEL_NET_2 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 N3 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LABEL_NET_4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 N3 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 LABEL_NET_5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

* Supply and Load (N2 is the shorted transformer primary)
VDD VDD 0 1.8
RLOAD VDD N2 50

* LO Signals (60GHz)
VLO_P1 LABEL_NET_1 0 DC 0.9 SIN(0.9 0.3 60G 0 0 0)
VLO_P2 LABEL_NET_2 0 DC 0.9 SIN(0.9 0.3 60G 0 0 0)
VLO_N N3 0 DC 0.9 SIN(0.9 0.3 60G 0 0 180)

* Baseband Signals (1GHz)
VBB_P LABEL_NET_5 0 DC 0.9 SIN(0.9 0.2 1G 0 0 0)
VBB_N LABEL_NET_4 0 DC 0.9 SIN(0.9 0.2 1G 0 0 180)

.control
op
let pdc = -i(VDD) * 1.8
print pdc

tran 1p 2n
meas tran vout_max max v(N2)
meas tran vout_min min v(N2)
let vout_pp = vout_max - vout_min
* Approximate conversion gain (will be near zero due to shorted drains)
let conv_gain_db = 20 * log10((vout_pp / 2) / 0.2 + 1e-10)
print conv_gain_db
quit
.endc
.end
