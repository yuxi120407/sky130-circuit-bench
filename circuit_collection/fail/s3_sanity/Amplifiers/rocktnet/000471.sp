* Telescopic Cascode OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=20.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=20.0 L_xm4=0.5
.param W_xm5=20.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=20.0 L_xm8=0.5

* DUT
XM1 N0 LABEL_NET_1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 LABEL_NET_2 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 LABEL_NET_4 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 LABEL_NET_5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N5 LABEL_NET_6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 N8 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N7 N6 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N7 LABEL_NET_7 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

* Power Supply
VVDD VDD 0 1.8

* Biases (Adjusted for SKY130 saturation)
B_PBIAS1 LABEL_NET_5 0 V='0.7 + 1e7 * I(VCM)'
B_PBIAS2 LABEL_NET_6 0 V='0.7 + 1e7 * I(VCM)'
V_PCAS1 LABEL_NET_2 0 0.4
V_PCAS2 LABEL_NET_7 0 0.4
V_NCAS1 N8 0 1.2
V_NCAS2 N6 0 1.2
I_TAIL N1 0 100u

* Inputs (DC 0.9V, AC 1Vpp diff, 2mVpp diff for Tran to improve SNR)
V_INP LABEL_NET_1 0 dc 0.9 ac 0.5 sin(0.9 1m 1Meg 0 0 0)
V_INN LABEL_NET_4 0 dc 0.9 ac -0.5 sin(0.9 1m 1Meg 0 0 180)

* DC Stabilization (Huge Inductors to set output CM to 0.9V)
L1 N3 VCM 1G
L2 N7 VCM 1G
VCM VCM 0 0.9

* Load Capacitors
C1 N3 0 1p
C2 N7 0 1p

* Differential Output
Bdiff OUT_DIFF 0 V=V(N7)-V(N3)

.control
op
let power = -i(VVDD) * 1.8 - i(VCM) * 0.9
print power

ac dec 100 1 1G
let gain_db = vdb(OUT_DIFF)
let phase = 180/PI * cph(v(OUT_DIFF))
let pm = 180 + phase

meas ac dc_gain find gain_db at=10
print dc_gain
meas ac gbw when gain_db=0 fall=1
print gbw
meas ac phase_margin find pm when gain_db=0 fall=1
print phase_margin

let phase_rad = cph(v(OUT_DIFF))
let gd = -deriv(phase_rad) / (2 * 3.14159265359)
meas ac gd_max max gd from=1k to=10k
meas ac gd_min min gd from=1k to=10k
let group_delay_ripple = (gd_max - gd_min) / gd_max * 100
print group_delay_ripple

tran 1n 20u
linearize v(OUT_DIFF)
set specwindow=blackman
fft v(OUT_DIFF)
let vout_mag = mag(v(OUT_DIFF))
meas ac fund MAX vout_mag from=0.9Meg to=1.1Meg
meas ac h2 MAX vout_mag from=1.9Meg to=2.1Meg
meas ac h3 MAX vout_mag from=2.9Meg to=3.1Meg
meas ac h4 MAX vout_mag from=3.9Meg to=4.1Meg
meas ac h5 MAX vout_mag from=4.9Meg to=5.1Meg
let thd = 20 * log10( sqrt(h2*h2 + h3*h3 + h4*h4 + h5*h5) / fund )
print thd

quit
.endc
.end