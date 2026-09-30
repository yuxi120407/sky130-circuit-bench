* Two-Stage Fully Differential OTA Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xmn1=0.5
.param L_xmn15=0.5
.param L_xmn16=0.5
.param L_xmn2=0.5
.param L_xmn3=0.5
.param L_xmn4=0.5
.param L_xmnt1=0.5
.param L_xmnt2=0.5
.param L_xmp10=0.5
.param L_xmp13=0.5
.param L_xmp14=0.5
.param L_xmp5=0.5
.param L_xmp6=0.5
.param L_xmp9=0.5

.param W_xmn4=5.0 L_xmn4=0.5
.param W_xmp13=5.0 L_xmp13=0.5
.param W_xmn15=5.0 L_xmn15=0.5
.param W_xmp9=5.0 L_xmp9=0.5
.param W_xmp5=5.0 L_xmp5=0.5
.param W_xmp6=5.0 L_xmp6=0.5
.param W_xmp10=5.0 L_xmp10=0.5
.param W_xmn3=5.0 L_xmn3=0.5
.param W_xmn16=5.0 L_xmn16=0.5
.param W_xmn1=5.0 L_xmn1=0.5
.param W_xmp14=5.0 L_xmp14=0.5
.param W_xmnt2=5.0 L_xmnt2=0.5
.param W_xmn2=5.0 L_xmn2=0.5
.param W_xmnt1=5.0 L_xmnt1=0.5

XMN4 N15 N3 N4 GND sky130_fd_pr__nfet_01v8 l={L_xmn4} w={W_xmn4}
XMP13 N11 BIAS5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp13} w={W_xmp13}
XMN15 N11 N14 N0 GND sky130_fd_pr__nfet_01v8 l={L_xmn15} w={W_xmn15}
XMP9 N2 BIAS4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp9} w={W_xmp9}
XMP5 N15 LABEL_NET_0 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xmp5} w={W_xmp5}
XMP6 N17 N9 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xmp6} w={W_xmp6}
XMP10 N5 BIAS4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp10} w={W_xmp10}
XMN3 N17 N7 N6 GND sky130_fd_pr__nfet_01v8 l={L_xmn3} w={W_xmn3}
XMN16 N8 N15 N0 GND sky130_fd_pr__nfet_01v8 l={L_xmn16} w={W_xmn16}
XMN1 N6 VI_PLUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xmn1} w={W_xmn1}
XMP14 N8 BIAS5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp14} w={W_xmp14}
XMNT2 N0 STAGE2_CMFB GND GND sky130_fd_pr__nfet_01v8 l={L_xmnt2} w={W_xmnt2}
XMN2 N4 VI_MINUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xmn2} w={W_xmn2}
XMNT1 N1 STAGE1_CMFB GND GND sky130_fd_pr__nfet_01v8 l={L_xmnt1} w={W_xmnt1}

* Fix missing connection between first stage output and second stage input
Rshort N14 N17 1m

* Power supply
VVDD VDD 0 1.8

* Biasing
VBIAS4 BIAS4 0 0.7
VBIAS5 BIAS5 0 0.7
VN3 N3 0 1.3
VN7 N7 0 1.3
VLABEL_NET_0 LABEL_NET_0 0 0.3
VN9 N9 0 0.3

* Ideal CMFB to set output common-mode
B1 STAGE1_CMFB 0 V=0.8+10*(V(N15)+V(N17)-2.1)
B2 STAGE2_CMFB 0 V=0.8+10*(V(N8)+V(N11)-1.8)

* Inputs
V_INP VI_PLUS 0 dc 1.1 ac 0.5 sin(1.1 0.1 10Meg)
V_INN VI_MINUS 0 dc 1.1 ac -0.5 sin(1.1 -0.1 10Meg)

* Load capacitors
CL1 N8 0 1p
CL2 N11 0 1p

* Differential output voltage source for easy measurement
Ediff OUT_DIFF 0 N11 N8 1.0

.control
op
let power = -i(VVDD) * 1.8
print power

ac dec 100 1 1G
let gain_db = db(v(OUT_DIFF))
let phase_margin_vec = (180/PI * cph(v(OUT_DIFF))) + 180

meas ac dc_gain find gain_db at=10
meas ac gbw when gain_db=0 fall=1
meas ac phase_margin find phase_margin_vec when gain_db=0 fall=1

print dc_gain
print gbw
print phase_margin
.endc
.end