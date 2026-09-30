* Testbench for SC switch and buffer
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm1=5.0 L_xm1=0.15
.param W_xm2=5.0 L_xm2=0.15
.param W_xm3=5.0 L_xm3=0.15
.param W_xm4=5.0 L_xm4=0.15
.param W_xm5=5.0 L_xm5=0.15
.param W_xm6=5.0 L_xm6=0.15

XM1 N2 LABEL_NET_1 LABEL_NET_0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VDD LABEL_NET_3 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 N1 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 LABEL_NET_4 N0 LABEL_NET_5 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

* DC Sources
VVDD VDD 0 1.8
VLABEL_NET_3 LABEL_NET_3 0 1.8
VLABEL_NET_4 LABEL_NET_4 0 0.1
VLABEL_NET_0 LABEL_NET_0 0 0.1

* 80 MHz Clocks (T = 12.5ns)
VCLK N1 0 PULSE(0 1.8 0 100p 100p 6.15n 12.5n)
VCLK1 LABEL_NET_1 0 PULSE(0 1.8 0 100p 100p 6.15n 12.5n)
VCLK2 LABEL_NET_2 0 PULSE(1.8 0 0 100p 100p 6.15n 12.5n)

* Load capacitors to simulate next stage
C1 LABEL_NET_5 0 1p
C2 N2 0 1p

.control
tran 50p 50n

* Measure buffer delay (N1 fall -> N0 rise)
meas tran buffer_delay trig v(N1) val=0.9 fall=2 targ v(N0) val=0.5 rise=2

* Measure max voltage of buffered clock
meas tran buffer_voh max v(N0) from=20n to=50n

* Measure power consumption
let power = -i(VVDD)*1.8
meas tran power_consumption avg power from=20n to=50n

print buffer_delay buffer_voh power_consumption
quit
.endc
.end