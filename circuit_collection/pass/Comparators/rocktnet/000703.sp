* StrongARM Latch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
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

VVDD VDD 0 1.8
VCLK CLK 0 PULSE(0 1.8 2n 50p 50p 4n 10n)

* Connect all clock labels to the main CLK source
V0 LABEL_NET_0 CLK 0
V3 LABEL_NET_3 CLK 0
V4 LABEL_NET_4 CLK 0
V5 LABEL_NET_5 CLK 0
V6 LABEL_NET_6 CLK 0

* Differential inputs flipping at 9ns
VINP LABEL_NET_1 0 PWL(0 0.95 9n 0.95 9.1n 0.85 30n 0.85)
VINN LABEL_NET_2 0 PWL(0 0.85 9n 0.85 9.1n 0.95 30n 0.95)

XM1 N2 N0 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 LABEL_NET_1 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 LABEL_NET_2 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 LABEL_NET_3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N3 LABEL_NET_4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 LABEL_NET_5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N2 LABEL_NET_6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N2 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N0 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}

.control
tran 10p 30n

* Cycle 1: INP > INN -> N2 falls, N0 stays high
meas tran tdelay_clk_to_n2_fall trig v(CLK) val=0.9 rise=1 targ v(n2) val=0.9 fall=1
meas tran n0_high_1 max v(n0) from=3n to=5n
meas tran n2_low_1 min v(n2) from=3n to=5n

* Cycle 2: INP < INN -> N0 falls, N2 stays high
meas tran tdelay_clk_to_n0_fall trig v(CLK) val=0.9 rise=2 targ v(n0) val=0.9 fall=1
meas tran n0_low_2 min v(n0) from=13n to=15n
meas tran n2_high_2 max v(n2) from=13n to=15n

* Average Power Calculation
meas tran avg_current avg i(VVDD) from=0 to=30n
let avg_power = -avg_current * 1.8
print avg_power

quit
.endc
.end
