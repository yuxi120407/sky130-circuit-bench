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

XM1 N4 N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 LABEL_NET_0 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N4 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 LABEL_NET_1 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 LABEL_NET_2 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 N0 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 LABEL_NET_3 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 N4 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 LABEL_NET_4 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N5 LABEL_NET_5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N3 LABEL_NET_6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N2 LABEL_NET_7 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}

VVDD VDD 0 1.8
VN6 N6 0 1.8

* 200 MHz Clock
VCLK CLK 0 PULSE(0 1.8 0 100p 100p 2.4n 5n)
E_CLK0 LABEL_NET_0 0 CLK 0 1
E_CLK1 LABEL_NET_1 0 CLK 0 1
E_CLK5 LABEL_NET_5 0 CLK 0 1
E_CLK6 LABEL_NET_6 0 CLK 0 1

* Differential Inputs
* VIP - VIN = 0.2V, VREFP - VREFN = 0.0V
* Comparator should evaluate N4 to 0V and N0 to 1.8V
VVIP LABEL_NET_3 0 1.0
VVIN LABEL_NET_7 0 0.8
VVREFP LABEL_NET_2 0 0.9
VVREFN LABEL_NET_4 0 0.9

* Load Capacitance
C0 N0 0 10f
C4 N4 0 10f

.control
tran 10p 15n
* Measure delay from 2nd clock rising edge to N4 falling edge
meas tran delay_fall trig v(CLK) val=0.9 rise=2 targ v(N4) val=0.9 fall=2

* Measure average power over two clock cycles
let pwr = -i(VVDD)*1.8 - i(VN6)*1.8
meas tran avg_power avg pwr from=5n to=15n

print delay_fall avg_power
quit
.endc
.end
