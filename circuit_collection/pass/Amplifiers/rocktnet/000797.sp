* Folded Cascode OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm0=0.5
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
.param W_xm4=5.0 L_xm4=0.5
.param W_xm0=5.0 L_xm0=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm8=5.0 L_xm8=0.5

* DUT
XM1 N4 IN_PLUS N7 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM4 N12 CMFB GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM0 N7 VB1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm0} w={W_xm0}
XM6 OUT_PLUS VB2 N12 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM2 N1 IN_MINUS N7 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM10 N1 VB4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM3 N11 CMFB GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM5 OUT_MINUS VB2 N11 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
* NOTE: XM7 was extracted as NMOS in the prompt, which breaks the folded cascode. 
* Corrected to PMOS to match the symmetric XM8.
XM7 OUT_MINUS VB3 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM9 N4 VB4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM8 OUT_PLUS VB3 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

* Biasing and Sources
VVDD VDD 0 1.8
VVB1 VB1 0 0.8
VVB2 VB2 0 1.1
VVB3 VB3 0 0.2
VVB4 VB4 0 0.6

* Common-mode extraction and CMFB
B_OUT_CM OUT_CM 0 V=(v(OUT_PLUS)+v(OUT_MINUS))/2
V_CMFB_BIAS CMFB_BIAS 0 0.8
V_REF VREF 0 0.9
E_CMFB CMFB CMFB_BIAS OUT_CM VREF 10

* Inputs
VIN_CM IN_CM 0 1.0
VIN_DIFF IN_DIFF 0 DC 0 AC 1 pulse(-0.5 0.5 100n 10p 10p 1u 2u)
E_IN_PLUS IN_PLUS IN_CM IN_DIFF 0 0.5
E_IN_MINUS IN_MINUS IN_CM IN_DIFF 0 -0.5

* Load capacitors
CL1 OUT_PLUS 0 100f
CL2 OUT_MINUS 0 100f

.control
* Operating Point
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

* AC Analysis
ac dec 100 1 10G
let gain_mag = mag(v(OUT_PLUS) - v(OUT_MINUS))
let gain_db = 20 * log10(gain_mag)
let phase = 180/PI * cph(v(OUT_PLUS) - v(OUT_MINUS))
let pm = 180 + phase

meas ac dc_gain find gain_db at=10
meas ac ugbw when gain_db=0 fall=1
meas ac phase_margin find pm when gain_db=0 fall=1

* Transient Analysis
tran 10p 2.5u
let vout_diff_tran = v(OUT_PLUS) - v(OUT_MINUS)
meas tran t_rise trig vout_diff_tran val=-0.5 rise=1 targ vout_diff_tran val=0.5 rise=1
meas tran t_fall trig vout_diff_tran val=0.5 fall=1 targ vout_diff_tran val=-0.5 fall=1
let sr_rise = 1.0 / t_rise / 1e6
let sr_fall = 1.0 / t_fall / 1e6
let slew_rate = (sr_rise + sr_fall) / 2
print slew_rate

quit
.endc
.end