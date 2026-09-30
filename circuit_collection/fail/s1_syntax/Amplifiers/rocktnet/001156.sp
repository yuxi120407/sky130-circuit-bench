* Telescopic OTA Testbench
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

* Corrected DUT (Fixed extraction errors: diode-connected cascodes, missing VDD)
XM1 N4 VB4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 VB4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 VO_MINUS VB3 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 CM_REF CM_REF GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VO_PLUS VB3 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 VO_MINUS VB2 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 VO_PLUS VB2 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N2 CMFB GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N8 VIN_MINUS N2 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N6 VIN_PLUS N2 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Biasing
VVDD VDD 0 1.8
VVB4 VB4 0 0.94
VVB3 VB3 0 0.5
VVB2 VB2 0 1.3

* Ideal CMFB
E_CMFB CMFB 0 vol='0.7 + 10*((v(VO_PLUS)+v(VO_MINUS))/2 - 0.9)'

* Inputs
VCM VCM 0 0.9
V_IN_DIFF VIN_DIFF 0 DC 0 AC 1 PULSE(-0.5 0.5 5n 100p 100p 20n 50n)
E_VIN_PLUS VIN_PLUS 0 vol='v(VCM) + v(VIN_DIFF)/2'
E_VIN_MINUS VIN_MINUS 0 vol='v(VCM) - v(VIN_DIFF)/2'

* Load capacitance
CL1 VO_PLUS 0 1p
CL2 VO_MINUS 0 1p

.control
op
let power = -i(VVDD) * 1.8
print power

ac dec 50 1k 10G
let vout_diff = v(VO_PLUS) - v(VO_MINUS)
let gain_db = 20 * log10(mag(vout_diff))
let phase = 180/PI * cph(vout_diff)

meas ac dc_gain find gain_db at=1k
meas ac ugf when gain_db=0 fall=1
meas ac phase_margin find phase when gain_db=0 fall=1

tran 10p 50n
meas tran t_rise trig v(VO_PLUS) val=0.8 rise=1 targ v(VO_PLUS) val=1.0 rise=1
let slew_rate_vus = 0.2 / t_rise / 1e6
print slew_rate_vus

quit
.endc
.end
