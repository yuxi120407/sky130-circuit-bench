* Sense Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* DUT Parameters
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

* DUT Instantiation
XM1 N0 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N4 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N6 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 GND LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 N4 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N6 LABEL_NET_2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 LABEL_NET_3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N6 N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N1 N4 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N0 N6 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N5 LABEL_NET_4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N0 VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}

* Fix for missing precharge on N0 (XM13 gate likely mis-extracted as VDD)
XMPRE N0 N4 VDD VDD sky130_fd_pr__pfet_01v8 l=0.5 w=5.0

* Voltage Sources
VVDD VDD 0 1.8
VCLK N4 0 PULSE(0 1.8 1n 50p 50p 1n 2n)
VCLK2 LABEL_NET_2 0 PULSE(0 1.8 1n 50p 50p 1n 2n)
VINP LABEL_NET_0 0 1.0
VINN LABEL_NET_4 0 0.8
VREF LABEL_NET_3 0 0
VDUM LABEL_NET_1 0 0

* Load Capacitors
C1 N0 0 10f
C2 N6 0 10f

* Analysis
.control
tran 10p 5n
* Measure delay from CLK rising to N6 falling (since VINP > VINN)
meas tran delay_N6 trig v(N4) val=0.9 rise=1 targ v(N6) val=0.9 fall=1
* Measure average current from VDD over one full clock cycle (1n to 3n)
meas tran i_vdd avg i(VVDD) from=1n to=3n
* Calculate energy per operation (Power * Period)
let energy_per_op = -i_vdd * 1.8 * 2e-9
print delay_N6 energy_per_op
quit
.endc
.end
