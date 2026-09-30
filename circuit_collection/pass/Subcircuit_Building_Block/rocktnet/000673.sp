* Stacked NMOS Switch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

* DUT
XM1 N2 N0 LABEL_NET_0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N0 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 LABEL_NET_1 N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

* Voltage sources
Vgate N0 0 1.8
Vsrc LABEL_NET_0 0 0
Vdrain LABEL_NET_1 0 0.1

.control
* Sweep gate voltage from 0 to 1.8V
dc Vgate 0 1.8 0.01

* Calculate current and resistance
let id = abs(i(Vdrain))
let ron = 0.1 / (id + 1e-20)

* Measure metrics
meas dc ron_on find ron at=1.8
meas dc i_off find id at=0

print ron_on i_off
quit
.endc
.end