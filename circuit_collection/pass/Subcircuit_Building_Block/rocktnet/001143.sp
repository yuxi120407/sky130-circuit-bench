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

XM1 VBIAS VBIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 VBIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 VBIAS N0 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Voltage Sources
VVDD VDD 0 1.8
VVBIAS VBIAS 0 0.99
VN1 N1 0 0
VN3 N3 0 0

.control
* DC Operating Point Analysis
op

* Calculate and print metrics
let v_n0 = v(N0)
let power = -i(VVDD) * 1.8
let i_bias = i(VN1)

print v_n0
print i_bias
print power

* Transient Analysis for steady-state verification
tran 1n 100n
meas tran v_n0_avg avg v(N0)
meas tran i_vdd_avg avg i(VVDD)

quit
.endc
.end