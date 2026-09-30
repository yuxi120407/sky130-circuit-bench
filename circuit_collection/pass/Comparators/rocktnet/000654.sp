* Testbench for Dynamic Latch / Comparator
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm1a=0.5
.param L_xm1b=0.5
.param L_xm2=0.5
.param L_xm2a=0.5
.param L_xm2b=0.5
.param L_xm3=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1b=5.0 L_xm1b=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm2a=5.0 L_xm2a=0.5
.param W_xm1a=5.0 L_xm1a=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm2b=5.0 L_xm2b=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5

VVDD VDD 0 1.8
VINN INN 0 DC 0.9 AC 0
VINP INP 0 DC 0.9 AC 1
VC1 C1 0 DC 1.8

* Inject a tiny current to break symmetry so the isolated latch resolves, and pulse it to measure swing
I_break_sym OUTP 0 DC 1u PWL(0 1u 1n 1u 1.5n -2m 2.5n 0 10n 0 10.5n 2m 11.5n 0 20n 0)

XM1B N7 INN GND GND sky130_fd_pr__nfet_01v8 l={L_xm1b} w={W_xm1b}
XM2 OUTP OUTN N3 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 P P N9 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM2A N9 C1 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm2a} w={W_xm2a}
XM1A N8 INP GND GND sky130_fd_pr__nfet_01v8 l={L_xm1a} w={W_xm1a}
XM6 P P N10 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N3 P GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N6 P GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 OUTN OUTP N6 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM2B N10 C1 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm2b} w={W_xm2b}
XM11 P C1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 OUTN OUTP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 OUTP OUTN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 P P VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}

.control
* DC Operating Point
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

* AC Analysis
ac dec 100 1k 100G
let gain_db = vdb(P)
meas ac gain_to_bias_node max gain_db
let target_gain = gain_to_bias_node - 3
meas ac bandwidth when gain_db=target_gain fall=1
print gain_to_bias_node bandwidth

* Transient Analysis
tran 100p 20n
meas tran v_outp_high max v(OUTP) from=5n to=10n
meas tran v_outp_low min v(OUTP) from=15n to=20n
let output_swing = v_outp_high - v_outp_low
print output_swing

quit
.endc
.end