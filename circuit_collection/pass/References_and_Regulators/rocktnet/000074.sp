* CAM Bias Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

XM1 N0 N0 LABEL_NET_0 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N0 LABEL_NET_1 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}

VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9

.control
* 1. DC Operating Point for Bias Voltage and Power
op
print v(N0)
let static_power = -i(VVDD)*1.8 - i(VLABEL_NET_0)*0.9 - i(VLABEL_NET_1)*0.9
print static_power

* 2. DC Sweep for Sensitivity Analysis
dc VLABEL_NET_0 0 1.8 0.01
meas dc v_n0_at_0_9 find v(N0) at=0.9
meas dc v_n0_at_1_0 find v(N0) at=1.0
let sensitivity = (v_n0_at_1_0 - v_n0_at_0_9) / 0.1
print sensitivity

quit
.endc
.end
