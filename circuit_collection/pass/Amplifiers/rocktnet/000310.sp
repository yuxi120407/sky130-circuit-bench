* Class-AB OTA Testbench

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

.subckt opamp IN_PLUS IN_MINUS OUT IBIAS VDD VSS GND
XM1 N3 N3 VSS GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N7 N7 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 OUT N7 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N7 N0 VSS GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 OUT N7 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 N0 VSS GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N7 N7 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N6 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N7 IN_PLUS N8 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N0 IN_MINUS N8 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N8 IBIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N1 N3 VSS GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N4 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 IBIAS IBIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
.ends

VVDD VDD 0 1.8
VVSS VSS 0 0
VIBIAS IBIAS 0 0.99

* AC Testbench (Open Loop with DC feedback)
Xac IN_PLUS_AC IN_MINUS_AC OUT_AC IBIAS VDD VSS 0 opamp
Vac IN_PLUS_AC 0 DC 0.7 AC 1
Lac OUT_AC IN_MINUS_AC 1T
Cac IN_MINUS_AC 0 1T
CLac OUT_AC 0 10p

* TRAN Testbench (Unity Gain Buffer)
Xtran IN_PLUS_TRAN OUT_TRAN OUT_TRAN IBIAS VDD VSS 0 opamp
Vtran IN_PLUS_TRAN 0 DC 0.7 PULSE(0.5 0.9 10u 10n 10n 1m 2m)
CLtran OUT_TRAN 0 10p

.control
op
let power_consumption = -i(VVDD) * 1.8 / 2
print power_consumption

ac dec 100 1 1G
let gain_db = db(v(OUT_AC))
let pm = 180 + ph(v(OUT_AC)) * 180 / pi
meas ac dc_gain find gain_db at=1
meas ac ugbw when gain_db=0 fall=1
meas ac phase_margin find pm when gain_db=0 fall=1
print dc_gain ugbw phase_margin

tran 1u 2.5m
meas tran sr_rise_time trig v(OUT_TRAN) val=0.6 rise=1 targ v(OUT_TRAN) val=0.8 rise=1
let slew_rate = 0.2 / (sr_rise_time * 1e6)
print slew_rate

quit
.endc
.end