* Multilevel Voltage Wave-Shaping Display Driver Switch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5

XM1 N1 LABEL_NET_0 N4 N4 sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 LABEL_NET_3 N1 N1 sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 LABEL_NET_4 LABEL_NET_5 N2 LABEL_NET_5 sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N4 N4 N4 N4 sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 N4 N4 N4 sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N3 N3 N0 N0 sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}

* Power supply and load
VDD VDD 0 1.8
V_meas VDD VDD_meas 0
R_pullup VDD_meas LABEL_NET_4 10k
C_load LABEL_NET_4 0 1p

* Gate drives
V_g1 LABEL_NET_1 0 PULSE(0 1.8 2n 0.1n 0.1n 10n 20n)
V_g2 LABEL_NET_0 0 PULSE(0 1.8 2n 0.1n 0.1n 10n 20n)
V_g3 LABEL_NET_3 0 PULSE(0 1.8 2n 0.1n 0.1n 10n 20n)
V_g4 LABEL_NET_5 0 PULSE(0 1.8 2n 0.1n 0.1n 10n 20n)

* Dummy resistors for floating nodes (artifacts from extraction)
R_dummy1 N3 0 1G
R_dummy2 N0 0 1G

.control
tran 10p 20n

* Measure ON and OFF voltages
meas tran v_out_off find v(LABEL_NET_4) at=1n
meas tran v_out_on find v(LABEL_NET_4) at=10n

* Measure currents (Note: I(V_meas) is negative when flowing from VDD to circuit)
meas tran i_leak find i(V_meas) at=1n
meas tran i_on find i(V_meas) at=10n

* Measure fall time (target 1.4V due to bulk diode clamping artifact on XM4)
meas tran t_fall trig v(LABEL_NET_1) val=0.9 rise=1 targ v(LABEL_NET_4) val=1.4 fall=1

quit
.endc
.end
