* Fully Differential Telescopic Cascode Op-Amp Testbench
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

XM1 VDD VIP N3 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VDD VIN N4 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N5 N3 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N6 N4 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VON VB3 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VOP VB3 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 VON VB2 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 VOP VB2 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N2 VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N3 VB5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N7 VB5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N7 VCMFB GND GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N4 VB5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}

VVDD VDD 0 1.8
VVIP VIP 0 DC 1.5 AC 0.5 SIN(1.5 0.001 10MEG)
VVIN VIN 0 DC 1.5 AC -0.5 SIN(1.5 -0.001 10MEG)

VVB3 VB3 0 1.2
VVB2 VB2 0 0.5
VVB1 VB1 0 1.0
VVB5 VB5 0 0.6

* Ideal CMFB to hold output common-mode at 0.9V
Bcmfb VCMFB 0 V='0.6 + (V(VOP)+V(VON)-1.8)*50'

* Load capacitance
CL1 VOP 0 1p
CL2 VON 0 1p

.control
op
let power = -i(VVDD) * 1.8
print power

ac dec 100 10 10G
let vdiff = v(VOP) - v(VON)
let gain_db = db(vdiff)
let phase = ph(vdiff)

meas ac dc_gain find gain_db at=10
meas ac ugbw when gain_db=0 fall=1
meas ac phase_at_ugbw find phase when gain_db=0 fall=1
meas ac pm param='180 + phase_at_ugbw'
print dc_gain ugbw pm

tran 100p 200n
let vdiff_tran = v(VOP) - v(VON)
meas tran vdiff_max max vdiff_tran
meas tran vdiff_min min vdiff_tran
.endc
.end