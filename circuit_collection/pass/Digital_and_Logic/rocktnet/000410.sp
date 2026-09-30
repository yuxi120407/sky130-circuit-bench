* Testbench for Level Shifter
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm8=1.0 L_xm8=0.5
.param W_xm13=1.0 L_xm13=0.5
.param W_xm7=1.0 L_xm7=0.5
.param W_xm14=1.0 L_xm14=0.5

.param W_xm5=5.0 L_xm5=0.15
.param W_xm6=5.0 L_xm6=0.15
.param W_xm11=5.0 L_xm11=0.15
.param W_xm12=5.0 L_xm12=0.15

.param W_xm3=5.0 L_xm3=0.15
.param W_xm4=5.0 L_xm4=0.15
.param W_xm10=5.0 L_xm10=0.15
.param W_xm9=5.0 L_xm9=0.15

XM8 R_C P_C V_BOOT V_BOOT sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM13 D_C R_C V_BOOT V_BOOT sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM7 S_C D_C V_BOOT V_BOOT sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM14 P_C S_C V_BOOT V_BOOT sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM5 S_B V_OUT S_C V_BOOT sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 R_B V_OUT R_C V_BOOT sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM11 D_B V_OUT D_C V_BOOT sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 P_B V_OUT P_C V_BOOT sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM3 S_B SET GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 R_B RESET GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM10 P_B PRECHARGE GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM9 D_B DISCHARGE GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}

VBOOT V_BOOT 0 3.3
VOUT V_OUT 0 1.8

VRESET RESET 0 PULSE(0 1.8 10n 0.1n 0.1n 10n 100n)
VSET SET 0 PULSE(0 1.8 35n 0.1n 0.1n 10n 100n)
VPRE PRECHARGE 0 PULSE(0 1.8 60n 0.1n 0.1n 10n 100n)
VDIS DISCHARGE 0 PULSE(0 1.8 85n 0.1n 0.1n 10n 100n)

C1 S_C 0 10f
C2 R_C 0 10f
C3 D_C 0 10f
C4 P_C 0 10f

.control
tran 0.1n 250n
meas tran tdelay_set trig v(set) val=0.9 td=120n rise=1 targ v(p_c) val=2.8 td=120n rise=1
meas tran vmin_sc min v(s_c)
meas tran avg_i_vboot avg i(VBOOT)
meas tran avg_i_vout avg i(VOUT)
let power_consumption = -(avg_i_vboot * 3.3 + avg_i_vout * 1.8)
print tdelay_set vmin_sc power_consumption
quit
.endc
.end