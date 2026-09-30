* Testbench for Quadrature Mixer and Cal Amp

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=50.0 L_xm1=0.15
.param W_xm2=50.0 L_xm2=0.15
.param W_xm3=50.0 L_xm3=0.15
.param W_xm4=50.0 L_xm4=0.15
.param W_xm5=50.0 L_xm5=0.15
.param W_xm6=50.0 L_xm6=0.15
.param W_xm7=50.0 L_xm7=0.15
.param W_xm8=50.0 L_xm8=0.15

* DUT
XM1 N3 VB2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N9 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N13 LO1I_MINUS N9 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N10 LO1Q_MINUS N2 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N12 LO1Q_PLUS N2 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N11 LO1I_PLUS N9 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 N7 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N2 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

* Sources
VVDD VDD 0 1.8
VRF N4 0 DC 0.7 SIN(0.7 0.01 1.8G)
VLOI_P LO1I_PLUS 0 DC 1.2 SIN(1.2 0.4 1.79G 0 0 0)
VLOI_M LO1I_MINUS 0 DC 1.2 SIN(1.2 0.4 1.79G 0 0 180)
VLOQ_P LO1Q_PLUS 0 DC 1.2 SIN(1.2 0.4 1.79G 0 0 90)
VLOQ_M LO1Q_MINUS 0 DC 1.2 SIN(1.2 0.4 1.79G 0 0 270)
VCAL N7 0 DC 0.7 AC 1
VVB2 VB2 0 DC 1.2
VN0 N0 0 DC 0

* Loads
R1 N11 VDD 1k
R2 N13 VDD 1k
R3 N12 VDD 1k
R4 N10 VDD 1k
R5 N3 VDD 1k

* Buffers and 2-stage RC Filters for IF I (fc = 159 MHz to remove LO/RF ripple)
E_buf1 N11_b 0 N11 0 1
R_f1a N11_b N11_i 1k
C_f1a N11_i 0 1p
R_f1b N11_i N11_f 1k
C_f1b N11_f 0 1p

E_buf2 N13_b 0 N13 0 1
R_f2a N13_b N13_i 1k
C_f2a N13_i 0 1p
R_f2b N13_i N13_f 1k
C_f2b N13_f 0 1p

* Buffers and 2-stage RC Filters for IF Q
E_buf3 N12_b 0 N12 0 1
R_f3a N12_b N12_i 1k
C_f3a N12_i 0 1p
R_f3b N12_i N12_f 1k
C_f3b N12_f 0 1p

E_buf4 N10_b 0 N10 0 1
R_f4a N10_b N10_i 1k
C_f4a N10_i 0 1p
R_f4b N10_i N10_f 1k
C_f4b N10_f 0 1p

.control
* DC Operating Point
op
let power = -i(VVDD) * 1.8
print power

* AC Analysis for Cal Amp
ac dec 10 100M 10G
let cal_gain = vdb(N3)
meas ac cal_gain_1_8G find cal_gain at=1.8G

* Transient Analysis for Mixer (IF = 10 MHz, Period = 100 ns)
tran 100p 300n

* Measure I-channel Conversion Gain
let if_i_diff = v(n11_f) - v(n13_f)
meas tran if_i_max max if_i_diff from=200n to=300n
meas tran if_i_min min if_i_diff from=200n to=300n
let if_i_amp = (if_i_max - if_i_min) / 2
let cg_i_linear = if_i_amp / 0.01
let cg_i_db = 20 * log10(cg_i_linear)
print cg_i_db

* Measure Q-channel Conversion Gain
let if_q_diff = v(n12_f) - v(n10_f)
meas tran if_q_max max if_q_diff from=200n to=300n
meas tran if_q_min min if_q_diff from=200n to=300n
let if_q_amp = (if_q_max - if_q_min) / 2
let cg_q_linear = if_q_amp / 0.01
let cg_q_db = 20 * log10(cg_q_linear)
print cg_q_db

quit
.endc
.end
