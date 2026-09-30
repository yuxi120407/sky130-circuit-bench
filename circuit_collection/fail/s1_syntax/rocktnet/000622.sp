* VCO Tuning / Bias Sub-circuit Testbench
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

* Sources
VVDD VDD 0 1.8
VGND GND 0 0
VVCTRL VCTRL 0 0.9
VCOARSE COARSE_CONTROL 0 0

* DUT
XM1 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N5 GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 COARSE_CONTROL N2 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 VCTRL N0 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N4 GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N1 VCTRL N1 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Dummy resistors to prevent floating nodes
R1 N1 GND 1G
R2 N2 GND 1G
R3 N3 GND 1G
R4 N4 GND 1G
R5 N5 GND 1G

.control
* DC Operating Point Analysis
op
let bias_voltage_n0 = v(N0)
let power_consumption = -i(VVDD) * 1.8

print bias_voltage_n0
print power_consumption

* DC Sweep to observe VCTRL effect on N1
dc VVCTRL 0 1.8 0.1
print v(N1)

quit
.endc
.end