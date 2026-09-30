* Testbench for extracted op-amp subcircuit
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
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

XM1 N1 VI_PLUS N4 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 VI_MINUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 VO_MINUS N5 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 LABEL_NET_2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 VO_PLUS N6 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 LABEL_NET_3 VO_MINUS VO_MINUS sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 N1 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 N1 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 VO_PLUS LABEL_NET_5 N1 N6 sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Power and Bias
VVDD VDD 0 1.8
VLABEL_NET_2 LABEL_NET_2 0 0
VLABEL_NET_3 LABEL_NET_3 0 0.9
VLABEL_NET_5 LABEL_NET_5 0 1.0

* Fix floating nodes to prevent singular matrix
R_N4 N4 0 1m
V_N5 N5 0 0.9
V_N6 N6 0 0.9

* Input Signals
VCM VCM 0 0.9
V_INP_AC VI_AC 0 dc 0 ac 1.0 sin(0 1m 1Meg)
C_couple VI_AC VI_PLUS 1
R_bias VO_PLUS VI_PLUS 100Meg

V_INN VI_MINUS VCM dc 0 ac 0 sin(0 -1m 1Meg)

* Loads
R_OUTP VO_PLUS 0 1Meg
R_OUTN VO_MINUS 0 1Meg
C_OUTP VO_PLUS 0 1p
C_OUTN VO_MINUS 0 1p

* Differential Output
E_diff VDIFF 0 VO_PLUS VO_MINUS 1.0

.control
op
let Power_Consumption = -i(VVDD)*1.8
print Power_Consumption

ac dec 20 1 1G
let gain_db = db(v(VDIFF))
let phase = 180/PI * ph(v(VDIFF))
meas ac DC_Gain find gain_db at=10
let gain_3db = $&DC_Gain - 3
meas ac f_3db when gain_db=gain_3db fall=1
meas ac Unity_Gain_Frequency when gain_db=0 fall=1
meas ac Phase_Margin find phase when gain_db=0 fall=1

print DC_Gain f_3db Unity_Gain_Frequency Phase_Margin

tran 1n 5u
meas tran vout_max max v(VDIFF)
meas tran vout_min min v(VDIFF)
meas tran vout_pp pp v(VDIFF)

quit
.endc
.end