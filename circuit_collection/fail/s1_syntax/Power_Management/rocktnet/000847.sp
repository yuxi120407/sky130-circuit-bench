* NMOS Switch Testbench
.param W_xm1=5.0 L_xm1=0.5

XM1 N1 LABEL_NET_0 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* Sources
VGS LABEL_NET_0 0 DC 0 PULSE(0 1.8 1n 1n 1n 10u 20u)
VVDD VDD 0 1.8
Rload VDD N1 1k
VN0 N0 0 0
VGND GND 0 0

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

.control
* 1. DC Sweep for Vth and Rdson
dc VGS 0 1.8 0.01
let id = -i(VVDD)
let rdson = v(N1) / id
meas dc vth find v(LABEL_NET_0) when id=1u
meas dc ioff find id at=0
meas dc rdson_val find rdson at=1.8

* 2. Transient for switching times
tran 10n 20u
meas tran t_on trig v(LABEL_NET_0) val=0.9 rise=1 targ v(N1) val=0.9 fall=1
meas tran t_off trig v(LABEL_NET_0) val=0.9 fall=1 targ v(N1) val=0.9 rise=1

print vth ioff rdson_val t_on t_off
quit
.endc
.end
