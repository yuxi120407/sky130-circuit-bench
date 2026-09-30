* Phase Interpolator Testbench
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
* Biases to keep tail current sources in saturation
VLABEL_NET_1 LABEL_NET_1 0 0.4
VLABEL_NET_7 LABEL_NET_7 0 1.2

* 1 GHz clock inputs (differential to allow proper push-pull operation)
Vclk clk 0 PULSE(0 1.8 0 50p 50p 450p 1n)
Vclkb clkb 0 PULSE(0 1.8 500p 50p 50p 450p 1n)

* Connect inputs to clock phases
R0 clk LABEL_NET_0 1
R2 clk LABEL_NET_2 1
R6 clk LABEL_NET_6 1
R4 clkb LABEL_NET_4 1
R5 clkb LABEL_NET_5 1

* DUT
XM1 N0 N0 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N2 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N5 LABEL_NET_0 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N4 LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 LABEL_NET_2 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 VDD N6 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 LABEL_NET_3 LABEL_NET_4 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N8 LABEL_NET_5 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N2 N2 N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N2 N2 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N2 N2 LABEL_NET_3 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N7 LABEL_NET_6 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 N6 LABEL_NET_7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 N0 N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}
XM17 N2 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm17} w={W_xm17}
XM18 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm18} w={W_xm18}

.control
tran 10p 5n

* Measure average power consumption
let power = -i(VVDD)*1.8
meas tran power_consumption avg power from=2n to=5n
print power_consumption

* Measure output voltage swing
let vdiff = v(N0) - v(N2)
meas tran v_diff_max max vdiff from=2n to=5n
meas tran v_diff_min min vdiff from=2n to=5n
let output_voltage_swing = v_diff_max - v_diff_min
print output_voltage_swing

* Measure propagation delay
meas tran v_n2_max max v(N2) from=2n to=5n
meas tran v_n2_min min v(N2) from=2n to=5n
let v_n2_mid = (v_n2_max + v_n2_min) / 2
meas tran propagation_delay trig v(clk) val=0.9 rise=3 targ v(N2) val=$&v_n2_mid td=1.9n cross=1
print propagation_delay

quit
.endc
.end