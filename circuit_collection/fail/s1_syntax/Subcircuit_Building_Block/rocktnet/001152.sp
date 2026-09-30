* Testbench for Gated Current Mirror
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

XM1 N4 OUT N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VDD N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 N1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}

VVDD VDD 0 1.8
V_N1 N1 0 DC 1.8 PULSE(0 1.8 5n 0.1n 0.1n 10n 20n)
V_OUT OUT 0 DC 1.8

* Load to prevent floating and allow discharge
Rload N3 0 100k
Cload N3 0 10f

.control
tran 0.1n 40n
meas tran avg_power avg (-i(VVDD)*1.8)
meas tran v_n4_min min v(N4)
meas tran v_n3_max max v(N3)
meas tran t_rise_n3 trig v(N1) val=0.9 rise=1 targ v(N3) val=0.9 rise=1
meas tran t_fall_n4 trig v(N1) val=0.9 rise=1 targ v(N4) val=0.9 fall=1

dc V_N1 0 1.8 0.05
meas dc v_n4_active find v(N4) when v(N1)=1.8
meas dc v_n3_active find v(N3) when v(N1)=1.8

quit
.endc
.end