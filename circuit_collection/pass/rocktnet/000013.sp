* Serial Link Receiver Summer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm1=10.0 L_xm1=0.15
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.15
.param W_xm4=10.0 L_xm4=0.15
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.15
.param W_xm7=5.0 L_xm7=0.15
.param W_xm8=10.0 L_xm8=0.15
.param W_xm9=5.0 L_xm9=0.15
.param W_xm10=5.0 L_xm10=0.15
.param W_xm11=5.0 L_xm11=0.15
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.15
.param W_xm15=5.0 L_xm15=0.15
.param W_xm16=5.0 L_xm16=0.15
.param W_xm17=10.0 L_xm17=0.15
.param W_xm18=5.0 L_xm18=0.15
.param W_xm19=5.0 L_xm19=0.15
.param W_xm20=5.0 L_xm20=0.15

VVDD VDD 0 DC 1.8
V_N12 N12 0 DC 1.0
V_N13 N13 0 DC 0.0
V_N8 N8 0 DC 0.0
V_LABEL_NET_0 LABEL_NET_0 0 DC 0.0
V_LABEL_NET_4 LABEL_NET_4 0 DC 0.0
V_LABEL_NET_5 LABEL_NET_5 0 DC 0.0
V_LABEL_NET_6 LABEL_NET_6 N11 DC 0
V_LABEL_NET_7 LABEL_NET_7 N7 DC 0
V_LABEL_NET_8 LABEL_NET_8 0 DC 1.8
V_LABEL_NET_9 LABEL_NET_9 0 DC 0.0
V_LABEL_NET_10 LABEL_NET_10 0 DC 1.8
V_LABEL_NET_11 LABEL_NET_11 0 DC 0.0

V_INP N14 0 DC 0.9 AC 1 PULSE(0.8 1.0 100p 20p 20p 400p 1n)
V_INN N9 0 DC 0.9 AC -1 PULSE(1.0 0.8 100p 20p 20p 400p 1n)

XM1 N3 N13 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N12 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VDD LABEL_NET_0 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 N13 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 N12 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N5 LABEL_NET_4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N11 N14 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N6 LABEL_NET_5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N4 VDD N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N11 LABEL_NET_6 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 N7 LABEL_NET_7 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 N4 LABEL_NET_8 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM15 N4 LABEL_NET_9 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16 N5 LABEL_NET_10 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}
XM17 N7 N9 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm17} w={W_xm17}
XM18 N1 N9 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm18} w={W_xm18}
XM19 N3 LABEL_NET_11 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm19} w={W_xm19}
XM20 N3 N3 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm20} w={W_xm20}

E_diff OUT_DIFF 0 N7 N11 1.0

.control
op
let power = -i(VVDD)*1.8
print power

ac dec 100 1M 100G
let gain_db = db(v(OUT_DIFF)) - 6.02
meas ac dc_gain find gain_db at=1M
meas ac bandwidth when gain_db='dc_gain-3' fall=1
print dc_gain bandwidth

tran 1p 2n
meas tran delay trig v(N14) val=0.9 rise=1 targ v(OUT_DIFF) val=0 rise=1
print delay
quit
.endc
.end