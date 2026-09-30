* Sense Amplifier Testbench
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

VVDD VDD 0 1.8
VVDD_INV VDD_INV 0 1.8
* SAE signal (active low)
VSAE LABEL_NET_3 0 PULSE(1.8 0 1n 20p 20p 5n 10n)
* Input coupling signals to create initial differential
VINP LABEL_NET_0 0 PULSE(1.8 0 0.5n 20p 20p 10n 20n)
VINN LABEL_NET_5 0 1.8

* SAE Inverter
XM_INV_P SAE_INV LABEL_NET_3 VDD_INV VDD_INV sky130_fd_pr__pfet_01v8 w=5.0 l=0.15
XM_INV_N SAE_INV LABEL_NET_3 GND GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.15

* DUT
XM1 N4 VDD N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N6 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N6 VDD N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 LABEL_NET_0 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N5 SAE_INV GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 VDD VDD N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 VDD N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N4 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N0 N1 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N1 N0 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N0 VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 N1 LABEL_NET_5 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}

* Load capacitors and pull-up resistors for open-drain outputs
C0 N0 0 10f
C1 N1 0 10f
R1 N4 VDD 10k
R2 N6 VDD 10k

* Initial conditions for precharged internal nodes
.ic v(N0)=1.8 v(N1)=1.8 v(N5)=1.8

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

.control
tran 10p 3n

* Measure delay from SAE falling to internal nodes resolving
meas tran delay_sense_n1 trig v(LABEL_NET_3) val=0.9 fall=1 targ v(N1) val=0.9 cross=1
meas tran delay_sense_n0 trig v(LABEL_NET_3) val=0.9 fall=1 targ v(N0) val=0.9 cross=1

* Measure delay to buffered outputs
meas tran delay_out_n4 trig v(LABEL_NET_3) val=0.9 fall=1 targ v(N4) val=0.9 cross=1
meas tran delay_out_n6 trig v(LABEL_NET_3) val=0.9 fall=1 targ v(N6) val=0.9 cross=1

* Measure final voltage swing
meas tran v_n0_final find v(N0) at=2.5n
meas tran v_n1_final find v(N1) at=2.5n
let v_swing = abs(v_n0_final - v_n1_final)
print v_swing

* Measure average power consumption during sensing
meas tran avg_current avg i(VVDD) from=1n to=3n
let avg_power = -avg_current * 1.8
print avg_power

quit
.endc
.end