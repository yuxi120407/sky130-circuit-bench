* Disconnected NMOS Characterization Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

XM1 VDD LABEL_NET_0 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N2 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N5 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

VVDD VDD 0 1.8

* Biasing XM1
VLABEL_NET_0 LABEL_NET_0 0 0.9
VN8 N8 0 0

* Biasing XM2
VN1 N1 0 1.8
VN2 N2 0 0.9
VN4 N4 0 0

* Biasing XM3
VN0 N0 0 1.8
VN5 N5 0 0.9
VN3 N3 0 0

.control
op
let id1 = -i(VVDD)
let id2 = -i(VN1)
let id3 = -i(VN0)
print id1 id2 id3

dc VN2 0 1.8 0.01
let id2_sweep = -i(VN1)
meas dc id_at_0v9 find id2_sweep at=0.9
meas dc vth_approx when id2_sweep=1u rise=1
quit
.endc
.end
