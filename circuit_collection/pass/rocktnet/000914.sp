* Level Shifter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
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
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5

VVDD VDD 0 1.8
VIN_SRC VNI_OR_VPI 0 PULSE(0 1.8 10n 1n 1n 40n 100n)

* Note: The original netlist had an extraction error where the intermediate node was shorted to GND.
* 'GND' has been replaced with 'VIN' for the drains of XM5/XM12 and gates of XM2/XM8/XM9 to restore functionality.
* Actual ground connections are tied to '0'.
XM1 N1 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 VIN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 N3 0 0 sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 VIN VNI_OR_VPI VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 VQN_OR_VQP N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 VIN 0 0 sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N4 VIN 0 0 sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N1 N4 0 0 sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 VQN_OR_VQP N2 0 0 sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 VIN VNI_OR_VPI 0 0 sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}

.control
tran 100p 300n

* Measure delay
meas tran t_delay_rise trig v(VNI_OR_VPI) val=0.9 rise=1 targ v(VQN_OR_VQP) val=0.9 rise=1
meas tran t_delay_fall trig v(VNI_OR_VPI) val=0.9 fall=1 targ v(VQN_OR_VQP) val=0.9 fall=1

* Measure rise/fall times
meas tran t_rise trig v(VQN_OR_VQP) val=0.36 rise=1 targ v(VQN_OR_VQP) val=1.44 rise=1
meas tran t_fall trig v(VQN_OR_VQP) val=1.44 fall=1 targ v(VQN_OR_VQP) val=0.36 fall=1

* Measure power
let inst_power = -i(VVDD) * 1.8
meas tran avg_power avg inst_power from=0 to=300n

print t_delay_rise t_delay_fall t_rise t_fall avg_power
quit
.endc
.end
