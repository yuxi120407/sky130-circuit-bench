* Testbench for Digital Logic Block
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
.param L_xm19=0.5
.param L_xm2=0.5
.param L_xm20=0.5
.param L_xm21=0.5
.param L_xm22=0.5
.param L_xm23=0.5
.param L_xm24=0.5
.param L_xm25=0.5
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
.param W_xm19=5.0 L_xm19=0.5
.param W_xm20=5.0 L_xm20=0.5
.param W_xm21=5.0 L_xm21=0.5
.param W_xm22=5.0 L_xm22=0.5
.param W_xm23=5.0 L_xm23=0.5
.param W_xm24=5.0 L_xm24=0.5
.param W_xm25=5.0 L_xm25=0.5

* DUT
XM1 N9 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N10 N8 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 LABEL_NET_0 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N13 N18 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N15 N18 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 N12 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N16 N8 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 N17 N9 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N0 N17 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N12 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N17 LABEL_NET_1 N11 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N11 N7 N10 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N17 LABEL_NET_2 N16 VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 N18 N6 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM15 N0 N2 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16 N3 LABEL_NET_3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}
XM17 N0 LABEL_NET_4 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm17} w={W_xm17}
XM18 N5 N18 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm18} w={W_xm18}
XM19 N18 N14 N15 GND sky130_fd_pr__nfet_01v8 l={L_xm19} w={W_xm19}
XM20 N18 LABEL_NET_5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm20} w={W_xm20}
XM21 N16 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm21} w={W_xm21}
XM22 N13 N18 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm22} w={W_xm22}
XM23 N12 N0 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm23} w={W_xm23}
XM24 N18 N6 N18 GND sky130_fd_pr__nfet_01v8 l={L_xm24} w={W_xm24}
XM25 N18 N14 N12 VDD sky130_fd_pr__pfet_01v8 l={L_xm25} w={W_xm25}

* Load Capacitors
C1 N12 0 10f
C2 N13 0 10f

* Sources
VVDD VDD 0 1.8
VN4 N4 0 0
VLABEL_NET_0 LABEL_NET_0 0 PULSE(0 1.8 0 50p 50p 1n 2n)
VLABEL_NET_1 LABEL_NET_1 0 PULSE(0 1.8 0 50p 50p 2n 4n)
VLABEL_NET_2 LABEL_NET_2 0 PULSE(0 1.8 0 50p 50p 3n 6n)
VLABEL_NET_3 LABEL_NET_3 0 PULSE(0 1.8 0 50p 50p 4n 8n)
VLABEL_NET_4 LABEL_NET_4 0 PULSE(0 1.8 0 50p 50p 5n 10n)
VLABEL_NET_5 LABEL_NET_5 0 PULSE(0 1.8 0 50p 50p 6n 12n)
VN2 N2 0 PULSE(0 1.8 0 50p 50p 7n 14n)
VN6 N6 0 PULSE(0 1.8 0 50p 50p 8n 16n)
VN7 N7 0 PULSE(0 1.8 0 50p 50p 9n 18n)
VN8 N8 0 PULSE(0 1.8 0 50p 50p 10n 20n)
VN14 N14 0 PULSE(0 1.8 0 50p 50p 11n 22n)

.control
tran 10p 50n
meas tran avg_I avg i(VVDD)
print avg_I

* Measure rise and fall times for N12 (if it switches)
meas tran t_rise_n12 trig v(N12) val=0.36 rise=1 targ v(N12) val=1.44 rise=1
meas tran t_fall_n12 trig v(N12) val=1.44 fall=1 targ v(N12) val=0.36 fall=1

* Measure rise and fall times for N13 (if it switches)
meas tran t_rise_n13 trig v(N13) val=0.36 rise=1 targ v(N13) val=1.44 rise=1
meas tran t_fall_n13 trig v(N13) val=1.44 fall=1 targ v(N13) val=0.36 fall=1

quit
.endc
.end
