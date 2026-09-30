* Fully Differential Telescopic Cascode OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
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
.param W_xm12=5.0 L_xm12=0.5

VVDD VDD 0 1.8
VINP INP 0 DC 0.95 AC 0.5 PULSE(0.45 1.45 10n 100p 100p 1u 2u)
VINM INM 0 DC 0.95 AC -0.5 PULSE(1.45 0.45 10n 100p 100p 1u 2u)

VBIAS1 BIAS1 0 1.08
VBIAS2 BIAS2 0 0.68
VBIAS3 BIAS3 0 0.75
VBIAS4 BIAS4 0 1.15
VCMREF CMREF 0 0.55
B_CMFB CMFB 0 V='0.55 + 1*(V(OUTP)+V(OUTM)-1.8)'

XM1 OUTP BIAS2 N10 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N10 BIAS1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 INM N5 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUTP BIAS4 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N5 BIAS3 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 OUTM BIAS4 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N7 BIAS1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 OUTM BIAS2 N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 CMFB GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N8 CMREF GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N6 INP N5 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N5 BIAS3 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}

CL1 OUTP 0 1p
CL2 OUTM 0 1p

B_diff OUT_DIFF 0 V='V(OUTP)-V(OUTM)'

.control
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

ac dec 100 1 10G
let gain_db = db(v(out_diff))
let phase_deg = 180/pi * ph(v(out_diff))
meas ac dc_gain find gain_db at=10
meas ac ugbw when gain_db=0 fall=1
meas ac pm find phase_deg when gain_db=0 fall=1
let phase_margin = 180 + $&pm
print dc_gain ugbw phase_margin

tran 1n 2u
meas tran t_rise trig v(out_diff) val=-0.2 rise=1 targ v(out_diff) val=0.2 rise=1
let slew_rate = 0.4 / $&t_rise / 1e6
print slew_rate
quit
.endc
.end