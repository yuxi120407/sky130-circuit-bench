* CML Divide-by-2 Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
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

* DUT
XM1 N4 LABEL_NET_0 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N8 LABEL_NET_1 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N6 N2 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 N2 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 N1 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 N3 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 N3 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 N6 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 N6 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N6 N1 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N5 LABEL_NET_2 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N0 LABEL_NET_3 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}

* Power Supply and CML Loads
VVDD VDD 0 1.8
R1 N1 VDD 500
R2 N2 VDD 500
R3 N3 VDD 500
R4 N6 VDD 500
VN7 N7 0 0

* Clock Sources (2.4 GHz)
* Period = 416.67ps, Half-period = 208.33ps
VCLK CLK 0 dc 0.9 pulse(1.8 0 0 60p 60p 148.33p 416.67p)
VCLKB CLKB 0 dc 0.9 pulse(0 1.8 0 60p 60p 148.33p 416.67p)

* Clock Connections to DUT
* Master Track / Slave Hold
V1 LABEL_NET_2 CLK 0
V2 LABEL_NET_1 CLK 0
* Master Hold / Slave Track
V3 LABEL_NET_0 CLKB 0
V4 LABEL_NET_3 CLKB 0

* Initial Conditions to speed up startup
.ic v(N1)=1.8 v(N6)=1.0 v(N2)=1.0 v(N3)=1.8

.control
tran 2p 10n uic

* Measure Power
meas tran I_vdd avg i(VVDD) from=5n to=10n
let power_consumption = -I_vdd * 1.8
print power_consumption

* Measure Input Frequency
meas tran t_in trig v(CLK) val=0.9 rise=1 targ v(CLK) val=0.9 rise=2 from=5n
let input_frequency = 1 / t_in
print input_frequency

* Measure Output Swing
let vout_diff = v(N1) - v(N6)
meas tran vdiff_max max vout_diff from=5n to=10n
meas tran vdiff_min min vout_diff from=5n to=10n
let output_swing = vdiff_max - vdiff_min
print output_swing

* Measure Output Frequency (Differential to reject common-mode clock feedthrough)
let vdiff_mid = (vdiff_max + vdiff_min) / 2
meas tran t_out trig vout_diff val=$&vdiff_mid rise=1 targ vout_diff val=$&vdiff_mid rise=2 from=5n
let output_frequency = 1 / t_out
print output_frequency

quit
.endc
.end