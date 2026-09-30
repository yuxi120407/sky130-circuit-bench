* Testbench for Dynamic Latch / Comparator
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

XM1 N3 N7 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N1 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 N7 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N5 N6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 N0 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 LABEL_NET_3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N4 N6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N3 LABEL_NET_5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N1 LABEL_NET_7 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}

* Power and Bias Sources
VVDD VDD 0 1.8
VN2 N2 0 1.8
VN7 N7 0 0.9
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_2 LABEL_NET_2 0 0.9
VLABEL_NET_3 LABEL_NET_3 0 0.9
VLABEL_NET_5 LABEL_NET_5 0 0.9
VLABEL_NET_6 N6 0 0.9
* Reset clock: High to short outputs, Low to evaluate
VLABEL_NET_7 LABEL_NET_7 0 PULSE(1.8 0 5n 0.1n 0.1n 10n 20n)

* Input Signal (AC and DC)
VCM VCM 0 0.9
VAC_DIFF IN_DIFF 0 DC 0.1 AC 1
E1 N0_DRIVE VCM IN_DIFF 0.5
E2 N1_DRIVE VCM IN_DIFF -0.5
R1 N0_DRIVE N0 100k
R2 N1_DRIVE N1 100k

* Load Capacitors
C1 N0 0 0.5p
C2 N1 0 0.5p

* Differential Output
E_diff OUT_DIFF 0 N0 N1 1

.control
* DC Operating Point
op
let power = -i(VVDD) * 1.8
print power

* AC Analysis
ac dec 100 1 1G
let gain_db = vdb(OUT_DIFF)
meas ac dc_gain find gain_db at=10
meas ac bandwidth when gain_db=0 fall=1

* Transient Analysis
tran 0.1n 40n
meas tran v_max max v(N0)
meas tran v_min min v(N0)
* Measure regeneration time: from clock falling (evaluation starts) to output reaching 1V difference
meas tran regen_time trig v(LABEL_NET_7) val=0.9 fall=1 targ v(OUT_DIFF) val=1.0 rise=1
quit
.endc
.end
