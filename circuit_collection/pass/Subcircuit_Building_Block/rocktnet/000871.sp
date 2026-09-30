* Testbench for Programmable NMOS Array
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 N1 C2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 C3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 C1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 C0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Voltage sources for drains
Vd0 N0 GND 1.8
Vd1 N4 GND 1.8
Vd2 N1 GND 1.8
Vd3 N2 GND 1.8

* Voltage sources for gates
Vc0 C0 GND 0
Vc1 C1 GND 0
Vc2 C2 GND 0
Vc3 C3 GND 0

.control
* 1. DC sweep for Vth, Id_sat, and Ioff
dc Vc0 0 1.8 0.01
let id0 = -i(Vd0)
meas dc vth0 when id0=10u
meas dc id_sat find id0 at=1.8
let ioff = id0[0]
print ioff

* 2. Operating point for Ron (Linear region)
alter Vd0 = 0.1
alter Vc0 = 1.8
op
let ron = 0.1 / -i(Vd0)
print ron

quit
.endc
.end
