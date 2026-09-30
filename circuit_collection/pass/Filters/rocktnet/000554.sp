* Testbench for BFSK Modulator Loop Filter
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0

VVDD VDD 0 1.8
VN1 N1 0 1.8
VVCTRL VCTRL 0 dc 0.0 ac 1
VVMOD VMOD 0 dc 0.0 ac 0

XM1 N0 N0 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N0 0 0 sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VCTRL N0 VMOD 0 sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VMOD N0 VCTRL 0 sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VCTRL N0 VCTRL 0 sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VCTRL N0 VCTRL 0 sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 N0 0 0 sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 N0 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

.control
op
let Power_DC = -(i(vvdd) + i(vn1)) * 1.8
let V_N0 = v(n0)
print Power_DC V_N0

ac dec 10 1 1G
let g_mod = abs(real(i(vvmod))) + 1e-20
let r_mod_vec = 1/g_mod
let c_ctrl_vec = abs(imag(i(vvctrl)))/(2*pi*frequency)

meas ac R_mod find r_mod_vec at=10
meas ac C_ctrl find c_ctrl_vec at=100MEG

print R_mod C_ctrl
quit
.endc
.end