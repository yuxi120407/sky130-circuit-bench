* 40-GHz Transimpedance Amplifier (SKY130 Port)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_m=0.5

.param W_m1=20.0 L_m=0.15
.param W_m2=10.0
.param W_m3=10.0
.param W_d=20.0
.param R_l=500
.param R_f=1k
.param R_e1=1k
.param R_e2=500
.param R_s=10k
.param C_e=1p
.param I_bias=0

* DUT Transistors (NPNs mapped to NMOS, Diodes to diode-connected NMOS)
XM3 N6 N3 OUT VEE sky130_fd_pr__nfet_01v8 W={W_m3} L={L_m}
XM1 N2 IN N1 VEE sky130_fd_pr__nfet_01v8 W={W_m1} L={L_m}
XM2 N5 N2 N3 VEE sky130_fd_pr__nfet_01v8 W={W_m2} L={L_m}
CE N1 VEE {C_e}
RL N2 VCC {R_l}
XD1 VCC VCC N5 VEE sky130_fd_pr__nfet_01v8 W={W_d} L={L_m}
XD2 N8 N8 N6 VEE sky130_fd_pr__nfet_01v8 W={W_d} L={L_m}
RE1 N3 VEE {R_e1}
XD3 N1 N1 N9 VEE sky130_fd_pr__nfet_01v8 W={W_d} L={L_m}
RS IN VEE {R_s}
XD4 VCC VCC N8 VEE sky130_fd_pr__nfet_01v8 W={W_d} L={L_m}
RE2 OUT VEE {R_e2}
XD5 N9 N9 VEE VEE sky130_fd_pr__nfet_01v8 W={W_d} L={L_m}
RF IN N3 {R_f}

* Sources
VCC VCC 0 DC 1.8
VEE VEE 0 DC -1.8
* Input current source: DC for self-bias, AC=1 for Zt measurement, SIN for transient
IIN IN 0 DC {I_bias} AC 1 SIN({I_bias} 10u 1G)

.control
* DC Operating Point & Power
op
let power_dissipation = abs(i(VCC)*1.8) + abs(i(VEE)*1.8)
print power_dissipation

* AC Analysis for Transimpedance Gain and Bandwidth
ac dec 100 1M 100G
meas ac transimpedance_gain find vdb(OUT) at=1M
meas ac bandwidth_3db when vdb(OUT)='transimpedance_gain - 3' fall=last
print transimpedance_gain bandwidth_3db

* Transient Analysis for Output Swing
tran 10p 5n
meas tran output_voltage_swing pp v(OUT) from=2n to=5n
print output_voltage_swing

quit
.endc
.end