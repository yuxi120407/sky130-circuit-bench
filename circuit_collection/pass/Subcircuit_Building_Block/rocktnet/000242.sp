* Bias Generator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param W_xm1=5.0
.param L_xm2=0.5
.param W_xm2=5.0
.param L_xm3=0.5
.param W_xm3=5.0
.param L_xm4=0.5
.param W_xm4=5.0
.param L_xm5=0.5
.param W_xm5=5.0

VVDD VDD 0 1.8
VBIAS BIAS 0 0.6

XM1 N1 BIAS 0 0 sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N0 N1 0 sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 N0 N1 0 sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}

.control
op
let dc_current = -i(VVDD)
let power_consumption = dc_current * 1.8
let v_n0 = v(N0)
let v_n1 = v(N1)
let operating_frequency = 0
let efficiency = 0
let gain = 0

print operating_frequency
print efficiency
print gain
print dc_current
print v_n0
print v_n1
print power_consumption
quit
.endc
.end