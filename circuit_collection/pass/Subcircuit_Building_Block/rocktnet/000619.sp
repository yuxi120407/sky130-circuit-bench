* SER-Tolerant Latch Fragment Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9

XM1 GND GND LABEL_NET_0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 GND LABEL_NET_1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 GND N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 GND N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 GND VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

.control
op
let static_power = -i(VVDD) * 1.8
print static_power
print v(N0)
print v(N1)

tran 1n 1u
meas tran v_n0_avg avg v(N0)
meas tran v_n1_avg avg v(N1)
quit
.endc
.end