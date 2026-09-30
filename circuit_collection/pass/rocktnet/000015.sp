* Dead-Zone Bias Circuit Testbench
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
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5

VVDD VDD 0 1.8
VCTRL NCTRL 0 0.6

* Short control inputs to VCTRL
V1 NCTRL N7 0
V2 NCTRL N5 0
V3 NCTRL N4 0

* DUT
XM1 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N1 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N8 N7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 N0 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 N6 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N6 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N2 GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

.control
* DC Operating Point
op
let power = -i(VVDD) * 1.8
let v_out = v(N0)
print power
print v_out

* DC Sweep for Sensitivity
dc VCTRL 0 1.8 0.01
meas dc v_out_0_6 find v(N0) at=0.6
meas dc v_out_0_8 find v(N0) at=0.8
let sensitivity = (v_out_0_8 - v_out_0_6) / 0.2
print sensitivity

quit
.endc
.end
