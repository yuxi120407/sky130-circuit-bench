* Dual Output Current Mirror Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

XM1 N3 N2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

V_N1 N1 0 0
V_N2 N2 0 0.9
V_N3 N3 0 1.8
V_N0 N0 0 1.8

.control
op
let id1 = -i(V_N3)
let id2 = -i(V_N0)
let current_matching = id1 / id2
let total_power = 1.8 * (id1 + id2)
print id1 id2 current_matching total_power

dc V_N3 0 1.8 0.01
meas dc id_09 find i(V_N3) at=0.9
meas dc id_10 find i(V_N3) at=1.0
* i(V_N3) is negative, so id_09 - id_10 yields a positive delta I
let rout = 0.1 / (id_09 - id_10)
print rout
quit
.endc
.end
