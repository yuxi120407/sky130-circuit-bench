* NMOS Bias/Load Circuit Testbench

.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5

* DUT
XM2 VDD LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM1 VDD VDD GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* Sources
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.control
* 1. Operating Point Analysis
op
let total_current = -i(VVDD)
let total_pwr = total_current * 1.8
print total_current
print total_pwr

* 2. DC Sweep for Transconductance
dc VLABEL_NET_0 0 1.8 0.01
let gm_total = deriv(-i(VVDD))
meas dc gm_at_09 find gm_total at=0.9
meas dc gm_max max gm_total

quit
.endc
.end
