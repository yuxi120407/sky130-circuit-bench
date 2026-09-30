* Testbench for Telescopic Cascode Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.param W_xm5=10.0 L_xm5=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm6=10.0 L_xm6=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm7=10.0 L_xm7=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm10=5.0 L_xm10=0.5

* DUT
XM5 VO_N VCF3 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM3 VO_N VB3 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM6 VO_P VCF3 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM4 N7 VI_N N2 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM7 N5 VB2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM1 N8 VI_P N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM10 VO_P VB3 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Fix floating nodes from extraction
Vshort1 N5 N2 0
Vshort2 N1 VDD 0

* Supplies and Biases
VVDD VDD 0 1.8
VVB2 VB2 0 0.6
VVB3 VB3 0 1.2

* Ideal CMFB to set output common-mode to 0.9V
R1 VO_P VO_CM 1Meg
R2 VO_N VO_CM 1Meg
Bcmfb VCF3 0 V=1.1 + 100*(V(VO_CM) - 0.9)

* Input Signals
VCM VCM 0 0.9
Vd Vd 0 dc 0 ac 1 pulse(-0.2 0.2 1n 10p 10p 10n 20n)
E1 VI_P VCM Vd 0 0.5
E2 VI_N VCM Vd 0 -0.5

* Load Capacitance
CL1 VO_P 0 200f
CL2 VO_N 0 200f

.control
op
let power = -i(VVDD) * 1.8
print power

ac dec 100 1 10G
let vout_diff = v(VO_P) - v(VO_N)
let gain_db = vdb(vout_diff)
let phase = 180/PI * cph(vout_diff)

meas ac dc_gain find gain_db at=10
meas ac ugbw when gain_db=0 fall=1
meas ac pm find phase when gain_db=0 fall=1
let phase_margin = pm + 180
print phase_margin

tran 10p 20n
let vout_diff_tran = v(VO_P) - v(VO_N)
meas tran t_rise trig vout_diff_tran val=-0.1 rise=1 targ vout_diff_tran val=0.1 rise=1
let sr_rise = 0.2 / t_rise
print sr_rise

quit
.endc
.end