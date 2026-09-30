* Bias Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 VBN VBN GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VBN GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VBN VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 VBN VBP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

VVDD VDD 0 1.8
VVBP VBP 0 0.99

.control
op
let i_bias = -i(VVDD)
let vbn_dc = v(VBN)
let power = i_bias * 1.8

print i_bias
print vbn_dc
print power

* DC sweep to characterize VBP to VBN transfer
dc VVBP 0 1.8 0.01
meas dc vbn_at_vbp99 find v(VBN) when v(VBP)=0.99

quit
.endc
.end