* High-Frequency CML Clock Divider Testbench
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

XM1 N4 N9 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N9 N4 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 LABEL_NET_0 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 LABEL_NET_1 N10 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N9 LABEL_NET_2 N10 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N8 N8 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 N0 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 LABEL_NET_3 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N10 LABEL_NET_4 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N0 N0 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N3 GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N7 LABEL_NET_5 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N5 LABEL_NET_6 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N6 N6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}

* Power Supply
VVDD VDD 0 1.8
V_N0 N0 0 1.8

* CML Load Resistors (Required for operation, assuming ideal loads)
R1 VDD N4 1k
R2 VDD N9 1k

* Feedback connections for dynamic divide-by-2 operation
* Connect outputs to inputs for negative feedback
Vfb1 LABEL_NET_1 N4 0
Vfb2 LABEL_NET_2 N9 0

* Clock Input (1 GHz)
VCLK LABEL_NET_4 0 PULSE(0 1.8 0 50p 50p 100p 1n)

* DC Bias for unused inputs
VLABEL_NET_0 LABEL_NET_0 0 0
VLABEL_NET_3 LABEL_NET_3 0 0
VLABEL_NET_5 LABEL_NET_5 0 0
VLABEL_NET_6 LABEL_NET_6 0 0

* Differential output for robust zero-crossing measurement
E_diff N_diff 0 N4 N9 1

.ic v(N4)=1.8 v(N9)=0

.control
* Run transient analysis for 30ns
tran 10p 30n

* Measure Power Consumption
meas tran pwr_avg avg i(VVDD) from=15n to=30n
let power_consumption = -pwr_avg * 1.8
print power_consumption

* Measure Input Clock Frequency
meas tran t_in_1 trig v(LABEL_NET_4) val=0.9 rise=20 targ v(LABEL_NET_4) val=0.9 rise=21
let operating_frequency = 1 / t_in_1
print operating_frequency

* Measure Output Frequency (Differential zero crossing)
meas tran t_out_1 trig v(N_diff) val=0 rise=10 targ v(N_diff) val=0 rise=11
let f_out = 1 / t_out_1
let divide_ratio = operating_frequency / f_out
print divide_ratio

* Measure Output Swing (Single-ended)
meas tran v_max max v(N4) from=15n to=30n
meas tran v_min min v(N4) from=15n to=30n
let output_swing = v_max - v_min
print output_swing

quit
.endc
.end