* Retina Pixel Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm17=0.5
.param L_xm18=0.5
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
.param W_xm16=5.0 L_xm16=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm18=5.0 L_xm18=0.5

VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 PULSE(0 1.8 10n 1n 1n 40n 100n)
VN5 N5 0 PULSE(1.8 0 15n 1n 1n 40n 100n)
VN6 N6 0 0.9
VN7 N7 0 0.9

XM1 N8 GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 GND N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N10 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N9 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N10 N11 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 N4 N9 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 GND N9 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 VDD GND N1 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N10 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N1 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N0 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 N8 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 GND GND N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM15 GND N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}
XM16 N4 N10 N11 GND sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}
XM17 N11 N10 GND GND sky130_fd_pr__nfet_01v8 l={L_xm17} w={W_xm17}
XM18 N2 N4 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm18} w={W_xm18}

.ic v(N10)=0 v(N3)=0

.control
tran 1n 200n
let pwr = -i(VVDD)*1.8
meas tran power_avg avg pwr
meas tran delay_N5_N0 trig v(N5) val=0.9 fall=1 targ v(N0) val=0.9 fall=1
meas tran delay_LABEL_N1 trig v(LABEL_NET_0) val=0.9 fall=1 targ v(N1) val=0.9 rise=1
meas tran v_n1_max max v(N1)
print delay_N5_N0 delay_LABEL_N1 power_avg v_n1_max
quit
.endc
.end