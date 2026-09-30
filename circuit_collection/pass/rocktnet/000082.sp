* PMOS Bias Sub-circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

* Voltage and Current Sources
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
I0 N0 0 10u
I2 N2 0 10u
V1 N1 0 0.9

.control
* DC Operating Point
op
print v(N0) v(N2) v(N1)
let power = -i(VVDD) * 1.8
print power

* DC Sweep to measure output current vs bias voltage
dc VLABEL_NET_0 0 1.8 0.01
meas dc i_out_0_9 find i(V1) at=0.9
meas dc i_vdd_0_9 find i(VVDD) at=0.9
let pwr_dc = -i_vdd_0_9 * 1.8
print pwr_dc

quit
.endc
.end
