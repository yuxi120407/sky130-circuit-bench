* Testbench for Fully Differential Two-Stage Op-Amp
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

.param W_xm11=5.0 L_xm11=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5

XM11 VOP VB4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM7 B VB4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 VB4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM12 VON VB4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM5 A VB3 B VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 VB3 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM3 A VB2 N3 VSS sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 VB2 N4 VSS sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM1 N3 VIP N7 VSS sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 VIN N7 VSS sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM13 N7 VCF1 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N7 VCF1 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM9 VOP A N5 VSS sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 VON N2 N6 VSS sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM15 N5 VCF2 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16 N6 VCF2 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}

* Power Supplies
VVDD VDD 0 1.8
VVSS VSS 0 0

* Biases
VVB4 VB4 0 0.99
VVB3 VB3 0 0.5
VVB2 VB2 0 1.2

* Ideal CMFB to set operating points
B1 VCF1 0 V='0.6 + 10*(v(A) + v(N2) - 1.2)'
B2 VCF2 0 V='1.8 + 10*(v(VOP) + v(VON) - 1.8)'

* Inputs (DC for OP/AC, Pulse for Tran)
VVIP VIP 0 DC 0.9 AC 0.5 PULSE(0.8 1.0 10n 1n 1n 40n 100n)
VVIN VIN 0 DC 0.9 AC -0.5 PULSE(1.0 0.8 10n 1n 1n 40n 100n)

* Loads and Compensation
CL1 VOP 0 4p
CL2 VON 0 4p
CC1 A VOP 1p
CC2 N2 VON 1p

.control
* DC Operating Point & Power
op
let power = -i(VVDD) * 1.8
print power
print v(VOP) v(VON) v(A) v(N2) v(VCF1) v(VCF2)

* AC Analysis
ac dec 100 1 10G
let vout_diff = v(VOP) - v(VON)
let gain_db = 20*log10(mag(vout_diff))
let phase = 180/PI * cph(vout_diff)
let pm = 180 + phase

meas ac dc_gain find gain_db at=10
meas ac gbw when gain_db=0 fall=1
meas ac phase_margin find pm when gain_db=0 fall=1

* Transient Analysis
tran 0.1n 100n
let vout_diff_tran = v(VOP) - v(VON)
meas tran t_rise trig vout_diff_tran val=-1.0 rise=1 targ vout_diff_tran val=1.0 rise=1
.endc
.end