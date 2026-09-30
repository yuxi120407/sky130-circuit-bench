* VCO Delay Cell Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
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

XM1 N6 N4 N9 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N6 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N6 N6 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N9 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N6 VC N10 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 VN1 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N4 N6 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N4 N4 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 VN1 VN1 VN2 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 VN2 VN2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N6 VC N8 VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}

VVDD VDD 0 1.8
VVC VC 0 0.9
VIN N4 0 PULSE(0 1.8 0 100p 100p 1n 2n)

* Prevent floating node errors for varactors
R_N8 N8 0 1G
R_N10 N10 0 1G

* Load capacitance
C_load N6 0 10f

.control
tran 10p 6n

meas tran v_max_N6 max v(N6) from=2n to=6n
meas tran v_min_N6 min v(N6) from=2n to=6n
let voltage_swing = v_max_N6 - v_min_N6
print voltage_swing

meas tran delay_fall trig v(N4) val=0.9 rise=2 targ v(N6) val=0.6 fall=2
meas tran delay_rise trig v(N4) val=0.9 fall=2 targ v(N6) val=0.6 rise=2
let propagation_delay = (delay_fall + delay_rise) / 2
print propagation_delay

meas tran avg_Ivdd avg i(VVDD) from=2n to=6n
let power_consumption = -avg_Ivdd * 1.8
print power_consumption

meas tran bias_voltage_vn1 avg v(VN1) from=2n to=6n
print bias_voltage_vn1

quit
.endc
.end