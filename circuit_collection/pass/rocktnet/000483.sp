* Dynamic Comparator Testbench
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
XM1 N2 N0 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N8 N2 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N7 N5 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N5 N1 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N6 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 N5 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N2 N0 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N5 N2 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N5 N1 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N6 LABEL_NET_3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}

* Power Supplies
VVDD VDD 0 1.8
VVDD_N4 N4 0 1.8

* Clocks (80 MHz -> 12.5ns period)
VCLK0 LABEL_NET_0 0 PULSE(0 1.8 2n 0.1n 0.1n 6n 12.5n)
VCLK1 LABEL_NET_1 0 PULSE(0 1.8 2n 0.1n 0.1n 6n 12.5n)
VCLK2 LABEL_NET_2 0 PULSE(0 1.8 2n 0.1n 0.1n 6n 12.5n)
VCLK3 LABEL_NET_3 0 PULSE(0 1.8 2n 0.1n 0.1n 6n 12.5n)

* Inputs (VCM = 0.9V, VDM = 100mV)
VINP N0 0 0.95
VINN N1 0 0.85

* Load Capacitance
CL1 N2 0 10f
CL2 N5 0 10f

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

.tran 10p 30n

.control
run
* Measure delay from CLK rising to OUT- (N2) falling to 0.9V
meas tran delay_fall trig v(LABEL_NET_0) val=0.9 rise=1 targ v(N2) val=0.9 fall=1

* Measure average power
let power = -i(VVDD_N4) * 1.8 - i(VVDD) * 1.8
meas tran avg_power avg power from=0 to=25n

print delay_fall avg_power
quit
.endc
.end
