* Fully Differential Two-Stage Op-Amp Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Parameters
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5

* DUT
XM1 N6 N2 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N12 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 N0 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 N6 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM6 N0 N4 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM5 N11 N4 N12 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM7 N9 N2 N12 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 N13 N10 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N5 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N0 N14 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N7 LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N8 LABEL_NET_3 N11 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N8 LABEL_NET_3 N9 GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N6 N14 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM15 N3 N13 N10 VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}

* Power Supplies
VVDD VDD 0 1.8
VN10 N10 0 1.8
VN8 N8 0 1.8

* Bias Voltages
VLABEL_NET_0 LABEL_NET_0 0 0.6
VLABEL_NET_1 LABEL_NET_1 0 0.6
VLABEL_NET_2 LABEL_NET_2 0 0.6
VLABEL_NET_3 LABEL_NET_3 0 1.0

* Ideal CMFB for PMOS loads
B1 N14 0 V='1.2 + (v(N6) + v(N0) - 1.8)*10'
B2 N13 0 V='1.2 + (v(N3) + v(N1) - 1.8)*10'

* Input Sources
VCM VCM 0 0.9
VD INP_AC 0 dc 0 ac 1
E1 N2 VCM INP_AC 0 0.5
E2 N4 VCM INP_AC 0 -0.5

* Compensation Capacitors (Added for stability)
Cc1 N6 N3 1p
Cc2 N0 N1 1p

* Load Capacitors (From paper: 6pF)
C1 N3 0 6p
C2 N1 0 6p

* Differential Output Extraction
E_diff out_diff 0 vol='v(N3) - v(N1)'

.control
op
print v(N6) v(N0) v(N3) v(N1) v(N14) v(N13)

* Differential AC Analysis
ac dec 100 1 1G
let gain_db = vdb(out_diff)
let phase = 180/PI * cph(v(out_diff))
let pm = phase + 180

meas ac dc_gain find gain_db at=10
meas ac ugf when gain_db=0 fall=1
meas ac phase_margin find pm when gain_db=0 fall=1

* Common Mode AC Analysis
alter VD ac=0
alter VCM ac=1
ac dec 100 1 1G
let cm_gain_db = vdb(out_diff)
meas ac cm_gain find cm_gain_db at=10

* Power Calculation
op
let power = -(i(VVDD) + i(VN10) + i(VN8)) * 1.8
print power
.endc
.end