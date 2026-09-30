* Charge Pump Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
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
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5

XM1 N2 DWB N8 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N6 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N8 VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N5 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 FROM_PUMP2 FROM_PUMP2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 PLLOUT FROM_PUMP2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N5 UPB N7 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N6 UP N7 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N7 VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N4 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 FROM_PUMP2 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 VBIAS VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 N4 DW N8 GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 PLLOUT N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}

IREF VDD VBIAS 50u

* Power Supply and Output Bias
VVDD VDD 0 1.8
VPLLOUT PLLOUT 0 0.9

* Input Stimulus (UP active 5n-15n, DW active 25n-35n)
VUP UP 0 pulse(0 1.8 5n 100p 100p 10n 40n)
VUPB UPB 0 pulse(1.8 0 5n 100p 100p 10n 40n)
VDW DW 0 pulse(0 1.8 25n 100p 100p 10n 40n)
VDWB DWB 0 pulse(1.8 0 25n 100p 100p 10n 40n)

.control
tran 100p 50n

* Measure UP current (sourcing, flows into VPLLOUT source)
meas tran i_up avg i(VPLLOUT) from=6n to=14n

* Measure DOWN current (sinking, flows out of VPLLOUT source)
meas tran i_dw avg i(VPLLOUT) from=26n to=34n

* Measure Average Power
let pwr = -i(VVDD) * 1.8
meas tran avg_pwr avg pwr from=0 to=50n

print i_up i_dw avg_pwr
quit
.endc
.end