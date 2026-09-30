* Fully Differential Folded-Cascode OTA Testbench
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

* DUT
XM1 N4 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N6 LABEL_NET_0 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N7 LABEL_NET_1 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 LABEL_NET_2 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N6 LABEL_NET_3 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N8 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N7 LABEL_NET_4 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N3 LABEL_NET_5 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N3 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}

* Power Supply and Biases
VDD VDD 0 1.8
VBN1 N0 0 0.6
VBN2_0 LABEL_NET_0 0 0.9
VBN2_4 LABEL_NET_4 0 0.9
VBP2_1 LABEL_NET_1 0 0.5
VBP2_3 LABEL_NET_3 0 0.5

* Ideal Common-Mode Feedback (CMFB) to stabilize outputs to 0.9V
Bcmfb N5 0 V=0.88+20*((v(N6)+v(N7))/2-0.9)

* Input Signals
VCM VCM 0 0.9
VIND VIND 0 dc 0 ac 1 pulse(-0.5 0.5 5n 100p 100p 20n 40n)
E_INP LABEL_NET_2 VCM VIND 0 0.5
E_INN LABEL_NET_5 VCM VIND 0 -0.5

* Load Capacitors (1 pF as per paper)
CL1 N6 0 1p
CL2 N7 0 1p

.control
* 1. DC Operating Point & Power
op
let power = -i(VDD) * 1.8
print power

* 2. AC Analysis (Gain, GBW, Phase Margin)
ac dec 20 10 10G
let vout_diff = v(N7) - v(N6)
let gain_db = 20*log10(mag(vout_diff))
let phase = 180/PI * cph(vout_diff)
meas ac dc_gain find gain_db at=10
meas ac gbw when gain_db=0 fall=1
meas ac phase_at_gbw find phase when gain_db=0 fall=1
let pm = 180 + phase_at_gbw
print pm

* 3. Transient Analysis (Slew Rate)
tran 10p 50n
* Measure rise slew rate on OUTP (N7)
meas tran t_rise trig v(N7) val=0.6 rise=1 targ v(N7) val=1.2 rise=1
let sr_rise = (1.2 - 0.6) / t_rise
print sr_rise
* Measure fall slew rate on OUTN (N6)
meas tran t_fall trig v(N6) val=1.2 fall=1 targ v(N6) val=0.6 fall=1
let sr_fall = (1.2 - 0.6) / t_fall
print sr_fall

quit
.endc
.end