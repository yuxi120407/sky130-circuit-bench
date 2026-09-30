* TCAM Search Line Load Testbench
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

* DUT
XM1 GND QN SBL_U_BAR GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 SBL_U QN GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 Q LABEL_NET_0 Q GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 SBL_U_BAR QN SBL_U_BAR VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 SBL_U_BAR Q SBL_U_BAR GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 SBL_U QN SBL_U VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 SBL_U Q SBL_U GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 SBL_U_BAR LABEL_NET_1 SBL_U_BAR GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

* DC Sources
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9
VQ Q 0 0

* Pull-up resistors to precharge search lines
R1 VDD SBL_U 100k
R2 VDD SBL_U_BAR 100k

* Input Pulse
VQN QN 0 PULSE(0 1.8 2n 0.1n 0.1n 5n 20n)

* AC Sources for Capacitance Measurement
Iac1 SBL_U 0 AC 1
Iac2 SBL_U_BAR 0 AC 1

.control
* Transient Analysis
tran 10p 10n
meas tran t_fall_sbl_u trig v(QN) val=0.9 rise=1 targ v(SBL_U) val=0.9 fall=1
meas tran t_fall_sbl_u_bar trig v(QN) val=0.9 rise=1 targ v(SBL_U_BAR) val=0.9 fall=1
meas tran avg_power avg -i(VVDD)*1.8 from=0 to=10n

* AC Analysis
ac dec 10 1G 10G
meas ac vdb_sbl_u find vdb(SBL_U) at=1G
meas ac vdb_sbl_u_bar find vdb(SBL_U_BAR) at=1G
let v_mag_sbl_u = 10^(vdb_sbl_u / 20)
let v_mag_sbl_u_bar = 10^(vdb_sbl_u_bar / 20)
let cap_sbl_u = 1 / (2 * 3.1415926535 * 1e9 * v_mag_sbl_u)
let cap_sbl_u_bar = 1 / (2 * 3.1415926535 * 1e9 * v_mag_sbl_u_bar)
print cap_sbl_u cap_sbl_u_bar

quit
.endc
.end
