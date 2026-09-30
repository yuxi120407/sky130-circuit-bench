* Testbench for Write Reference Voltage Generator
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

XM1 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VDD VDD VWR_REF GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VWR_REF N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

VVDD VDD 0 1.8
Ibias VDD N0 10u

.control
op
let vref = v(VWR_REF)
let power = -i(VVDD)*1.8
print vref power

dc VVDD 0 1.8 0.01
meas dc vref_1_8 find v(VWR_REF) at=1.8
meas dc vref_1_7 find v(VWR_REF) at=1.7
let line_reg = (vref_1_8 - vref_1_7)/0.1
print line_reg
quit
.endc
.end
