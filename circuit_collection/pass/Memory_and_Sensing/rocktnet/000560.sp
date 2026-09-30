* SRAM Cell Static Leakage Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xmacc=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xmacc=5.0 L_xmacc=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

XM1 N1 GND VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 GND N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XMACC GND GND GND GND sky130_fd_pr__nfet_01v8 l={L_xmacc} w={W_xmacc}
XM4 N1 GND VDDL GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 GND N1 VDDL GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 GND VDD GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

VVDD VDD 0 1.8
VVDDL VDDL 0 0.0

.control
tran 1n 10n

meas tran node_n1_voltage avg v(N1) from=2n to=8n
meas tran i_vdd_avg avg i(VVDD) from=2n to=8n

let static_power = -i_vdd_avg * 1.8
print static_power
print node_n1_voltage

.endc
.end