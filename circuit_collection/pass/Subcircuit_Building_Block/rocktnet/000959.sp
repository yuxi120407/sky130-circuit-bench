* Cascode Current Mirror Bank Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xma=0.5
.param L_xmb=0.5

.param W_xma=5.0 L_xma=0.5
.param W_xmb=5.0 L_xmb=0.5
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

XMA VG2 VG2 VG1 VEE sky130_fd_pr__nfet_01v8 l={L_xma} w={W_xma}
XMB VG1 VG1 N_RB VEE sky130_fd_pr__nfet_01v8 l={L_xmb} w={W_xmb}
XM1 N_Q1E VG2 N_M1S VEE sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N_M1S VG1 N_RB1 VEE sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N_Q3E VG2 N_M3S VEE sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N_M3S VG1 N_RB2 VEE sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N_M5D VG2 N_M5S VEE sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N_M5S VG1 N_RB3 VEE sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N_M7D VG2 N_M7S VEE sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N_M7S VG1 N_RB4 VEE sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N_Q10E VG2 N_M9S VEE sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N_M9S VG1 N_RB5 VEE sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N_Q9E VG2 N_M11S VEE sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N_M11S VG1 N_RB6 VEE sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N_M13D VG2 N_M13S VEE sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N_M13S VG1 N_RB7 VEE sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 N_M15D VG2 N_M15S VEE sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16 N_M15S VG1 N_RB8 VEE sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}

VEE VEE 0 DC 0
VRB N_RB 0 DC 0
VRB1 N_RB1 0 DC 0
VRB2 N_RB2 0 DC 0
VRB3 N_RB3 0 DC 0
VRB4 N_RB4 0 DC 0
VRB5 N_RB5 0 DC 0
VRB6 N_RB6 0 DC 0
VRB7 N_RB7 0 DC 0
VRB8 N_RB8 0 DC 0

IREF VDD_REF VG2 DC 100u
VDD_REF VDD_REF 0 DC 1.8

VOUT1 N_Q1E 0 DC 1.8
VOUT2 N_Q3E 0 DC 1.8
VOUT3 N_M5D 0 DC 1.8
VOUT4 N_M7D 0 DC 1.8
VOUT5 N_Q10E 0 DC 1.8
VOUT6 N_Q9E 0 DC 1.8
VOUT7 N_M13D 0 DC 1.8
VOUT8 N_M15D 0 DC 1.8

.control
op
let i_out1 = -i(VOUT1)
let i_ref = 100u
let mirror_ratio = i_out1 / i_ref
print mirror_ratio

let power_ref = v(VG2) * i_ref
print power_ref

dc VOUT1 0 1.8 0.01
meas dc i1 find i(VOUT1) at=1.0
meas dc i2 find i(VOUT1) at=1.1
* i1 and i2 are negative, i1 is less negative than i2, so i1 - i2 is positive
let rout = 0.1 / (i1 - i2)
print rout

meas dc i_max find i(VOUT1) at=1.8
let i_95 = i_max * 0.95
meas dc v_comp when i(VOUT1)=i_95
print v_comp
quit
.endc
.end
