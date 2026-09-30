* Testbench for Bias Network
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5

XM1 N_E3 VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VOUTp VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N_M3D VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VOUTn VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N_E5 VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}

VVDD VDD 0 1.8
VVBIAS VBIAS 0 0.54

* Connect drains to VDD to measure current
V_NE3 N_E3 0 1.8
V_VOUTp VOUTp 0 1.8
V_NM3D N_M3D 0 1.8
V_VOUTn VOUTn 0 1.8
V_NE5 N_E5 0 1.8

.control
op
let id1 = -i(V_NE3)
let id2 = -i(V_VOUTp)
let id3 = -i(V_NM3D)
let id4 = -i(V_VOUTn)
let id5 = -i(V_NE5)
let total_power = (id1 + id2 + id3 + id4 + id5) * 1.8
print id1 id2 id3 id4 id5 total_power

* DC sweep to measure output resistance of XM1
dc V_NE3 0 1.8 0.01
meas dc i1 find i(V_NE3) at=0.89
meas dc i2 find i(V_NE3) at=0.91
* Current i(V_NE3) is negative, so i1 - i2 is positive
let rout = 0.02 / (i1 - i2)
print rout

quit
.endc
.end
