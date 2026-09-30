* Testbench for Fully Differential Folded Cascode Op-Amp

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Adjusted W/L to balance PMOS and NMOS drive strengths
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=25.0 L_xm5=0.5
.param W_xm6=25.0 L_xm6=0.5
.param W_xm7=25.0 L_xm7=0.5
.param W_xm8=25.0 L_xm8=0.5
.param W_xm9=25.0 L_xm9=0.5
.param W_xm10=25.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5

* DUT
XM1 N1 VIP N3 GNDA sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 VIN N3 GNDA sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 VCMFB GNDA GNDA sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 VB5 GNDA GNDA sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 VB1 VDDA VDDA sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 VB1 VDDA VDDA sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N4 VB2 N1 VDDA sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N5 VB2 N2 VDDA sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 VON VB3 N4 VDDA sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 VOP VB3 N5 VDDA sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 VON VB4 N6 GNDA sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 VOP VB4 N7 GNDA sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N6 VB5 GNDA GNDA sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N7 VB5 GNDA GNDA sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}

* Power Supplies
VDDA VDDA 0 1.8
VGNDA GNDA 0 0

* Biasing (Optimized for SKY130 1.8V)
VVB1 VB1 0 1.15
VVB2 VB2 0 0.85
VVB3 VB3 0 0.65
VVB4 VB4 0 0.9
VVB5 VB5 0 0.6

* Ideal Common-Mode Feedback (Regulates output CM to 0.9V)
Bcmfb VCMFB 0 V='0.6 + (v(VOP)+v(VON)-1.8)*10'

* Input Signals
VVIP VIP 0 DC 0.8 AC 0.5
VVIN VIN 0 DC 0.8 AC 0.5 180

* Load Capacitance
CL1 VOP 0 1p
CL2 VON 0 1p

* Differential Output Voltage
Bout VOUT 0 V='v(VOP)-v(VON)'

.control
* DC Operating Point
op
let power_consumption = -i(VDDA) * 1.8
print power_consumption

* AC Analysis
ac dec 100 1 1G
let gain_db = db(v(VOUT))
let phase = 180/PI * cph(v(VOUT))
let pm = 180 + phase
meas ac dc_gain find gain_db at=10
meas ac gbw when gain_db=0 fall=1
meas ac phase_margin find pm when gain_db=0 fall=1

print dc_gain gbw phase_margin
quit
.endc
.end