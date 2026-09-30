* Bias Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm5=5.0 L_xm5=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm2=5.0 L_xm2=0.5

VVDD VDD 0 1.8
VVBIAS1 VBIAS1 0 1.2

XM5 VDD VBIAS1 IBIAS 0 sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
R1 IBIAS 0 20k
XM4 VBIAS2 IBIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM1 VBIAS2 VBIAS2 0 0 sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM3 VBIAS3 IBIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM2 VBIAS3 VBIAS3 0 0 sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

.control
op
let Power_consumption = -i(VVDD) * 1.8
let VBIAS2_voltage = v(VBIAS2)
let VBIAS3_voltage = v(VBIAS3)
let IBIAS_voltage = v(IBIAS)

print Power_consumption
print VBIAS2_voltage
print VBIAS3_voltage
print IBIAS_voltage
quit
.endc
.end