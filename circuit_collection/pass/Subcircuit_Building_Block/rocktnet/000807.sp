* Bias Generator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
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

XM1 GND LABEL_NET_0 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N0 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 LABEL_NET_2 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 LABEL_NET_3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 GND N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N0 N0 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}

VVDD VDD 0 1.8
* Sleep mode initially, then active mode at 50us
V0 LABEL_NET_0 0 PWL(0 0 50u 0 50.01u 1.8)
V1 LABEL_NET_1 0 PWL(0 1.8 50u 1.8 50.01u 0)
V2 LABEL_NET_2 0 PWL(0 1.8 50u 1.8 50.01u 0)
V3 LABEL_NET_3 0 PWL(0 1.8 50u 1.8 50.01u 0)

.control
tran 10n 200u
meas tran v_ref_n0 avg v(N0) from=150u to=200u
meas tran v_ref_n1 avg v(N1) from=150u to=200u
meas tran v_ref_n2 avg v(N2) from=150u to=200u
meas tran t_startup trig v(LABEL_NET_2) val=0.9 fall=1 targ v(N1) val=0.8 rise=1
let power = -i(VVDD) * 1.8
meas tran power_dc avg power from=150u to=200u
print v_ref_n0 v_ref_n1 v_ref_n2 t_startup power_dc
quit
.endc
.end