* Adaptive Supply Bias Circuit
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
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
.param W_xm10=5.0 L_xm10=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm6=5.0 L_xm6=0.5

XM1 N2 GND V VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 GND N4 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 V_PRIME DN V_PRIME GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 GND N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 V_PRIME GND V_PRIME GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM10 GND GND N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM7 N2 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 GND V_PRIME VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 GND VCTRL N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM6 GND VDD N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}

VVDD VDD 0 1.8
VV V 0 1.8
VV_PRIME V_PRIME 0 1.8
VVCTRL VCTRL 0 0.9
VDN DN 0 0.9
VN3 N3 0 0.9
VN4 N4 0 0.9

.control
op
let power = (-i(VVDD) - i(VV) - i(VV_PRIME)) * 1.8
print power

dc VVCTRL 0 1.8 0.01
meas dc v_n0 find v(N0) at=0.9
meas dc v_n2 find v(N2) at=0.9
meas dc v_n0_1 find v(N0) at=0.8
meas dc v_n0_2 find v(N0) at=1.0
let sensitivity_n0 = (v_n0_2 - v_n0_1) / 0.2
print sensitivity_n0
quit
.endc
.end