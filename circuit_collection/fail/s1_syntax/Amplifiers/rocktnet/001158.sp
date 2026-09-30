* Fully Differential OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm18=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xmt1=0.5
.param L_xmt2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xmt1=5.0 L_xmt1=0.5
.param W_xm18=5.0 L_xm18=0.5
.param W_xmt2=5.0 L_xmt2=0.5

XM1 N8 N2 N12 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N5 VIN_MINUS N10 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N10 VB3 N15 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VO_MINUS N16 N19 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VO_PLUS N15 N17 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N17 N9 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 N18 N20 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N20 N7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N2 CM_REF N8 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N5 N2 N11 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N19 N9 GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 VO_PLUS VB4 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 N5 VIN_PLUS N10 GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N9 VB2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 N5 N2 N11 VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}
XM16 N11 VO_PLUS N11 VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}
XMT1 N11 VO_MINUS LABEL_NET_5 VDD sky130_fd_pr__pfet_01v8 l={L_xmt1} w={W_xmt1}
XM18 VO_MINUS VB4 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm18} w={W_xm18}
XMT2 N12 CMFB LABEL_NET_6 VDD sky130_fd_pr__pfet_01v8 l={L_xmt2} w={W_xmt2}

* Power and Bias Sources
VVDD VDD 0 1.8
VCM_REF CM_REF 0 0.9
VVB2 VB2 0 0.54
VVB3 VB3 0 0.54
VVB4 VB4 0 0.99
VLABEL_NET_5 LABEL_NET_5 0 0.9
VLABEL_NET_6 LABEL_NET_6 0 0.9

* Fixes for floating nodes (extracted from partial schematic)
VN16 N16 0 0.54
VN18 N18 0 0.54
VN7 N7 0 0.54

* Ideal CMFB to set output common-mode to 0.9V
Bcmfb CMFB 0 V='0.9 + 10*(0.5*(v(VO_PLUS) + v(VO_MINUS)) - 0.9)'

* Input Sources (AC and Transient)
VVIN_PLUS VIN_PLUS 0 DC 0.9 AC 0.5 SIN(0.9 0.1 10MEG 0 0)
VVIN_MINUS VIN_MINUS 0 DC 0.9 AC -0.5 SIN(0.9 -0.1 10MEG 0 0)

* Load Capacitors
CL1 VO_PLUS 0 1p
CL2 VO_MINUS 0 1p

.control
op
let power = -i(VVDD) * 1.8
print power

ac dec 100 1k 10G
let vout_diff = v(VO_PLUS) - v(VO_MINUS)
let gain_db = 20*log10(mag(vout_diff))
let phase = 180/PI * cph(vout_diff)

meas ac dc_gain find gain_db at=1k
meas ac ugbw when gain_db=0 fall=1
meas ac phase_at_ugbw find phase when gain_db=0 fall=1
let pm = phase_at_ugbw + 180
print pm

tran 1n 200n
meas tran vout_max max v(VO_PLUS)
meas tran vout_min min v(VO_PLUS)
let vout_pp = vout_max - vout_min
print vout_pp

quit
.endc
.end
