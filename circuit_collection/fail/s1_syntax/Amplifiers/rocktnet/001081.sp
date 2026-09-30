* Testbench for Fully Differential Two-Stage Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm17=0.5
.param L_xm18=0.5
.param L_xm19=0.5
.param L_xm2=0.5
.param L_xm20=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Parameters
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
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm18=5.0 L_xm18=0.5
.param W_xm19=5.0 L_xm19=0.5
.param W_xm20=5.0 L_xm20=0.5

* DUT
XM1 N10 BIAS3 N13 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUT_PLUS BIAS3 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N15 BIAS1 VDDA VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUT_MINUS BIAS2 N15 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N4 BIAS3 N14 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 OUT_PLUS BIAS2 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N10 BIAS2 N16 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 OUT_MINUS BIAS3 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N14 IN_MINUS N9 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N0 N10 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N4 BIAS2 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N13 IN_PLUS N9 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N3 BIAS1 VDDA VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 N6 BIAS1 VDDA VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM15 N2 N4 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16 N16 BIAS1 VDDA VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}
XM17 N9 CM_BIAS1 VSSA GND sky130_fd_pr__nfet_01v8 l={L_xm17} w={W_xm17}
XM18 N1 CM_BIAS2 VSSA GND sky130_fd_pr__nfet_01v8 l={L_xm18} w={W_xm18}
XM19 N26 VDDA N4 GND sky130_fd_pr__nfet_01v8 l={L_xm19} w={W_xm19}
XM20 N5 VDDA N10 GND sky130_fd_pr__nfet_01v8 l={L_xm20} w={W_xm20}

* Supplies
VVDD VDD 0 1.8
VVDDA VDDA 0 1.8
VVSSA VSSA 0 0

* Fixed Biases
VBIAS1 BIAS1 0 1.0
VBIAS2 BIAS2 0 0.6
VBIAS3 BIAS3 0 1.2

* Ideal CMFB for tail currents to set output CM to 0.9V
Bcmfb1 CM_BIAS1 0 V='0.7 + 10*(v(N10)+v(N4)-1.8)'
Bcmfb2 CM_BIAS2 0 V='0.7 + 10*(v(OUT_PLUS)+v(OUT_MINUS)-1.8)'

* Inputs (Differential AC = 1V)
VCM VCM 0 0.9
VIN_PLUS IN_PLUS VCM DC 0 AC 0.5
VIN_MINUS IN_MINUS VCM DC 0 AC -0.5

* Differential Output
Eout OUT_DIFF 0 vol='v(OUT_PLUS)-v(OUT_MINUS)'

.control
* DC Operating Point & Power
op
let power = -(i(VVDD) + i(VVDDA)) * 1.8
print power
print v(N10) v(N4) v(OUT_PLUS) v(OUT_MINUS)
print v(CM_BIAS1) v(CM_BIAS2)

* AC Analysis
ac dec 100 1k 10G
let gain_db = vdb(OUT_DIFF)
let phase = 180/PI * cph(v(OUT_DIFF))

meas ac dc_gain find gain_db at=1k
meas ac ugf when gain_db=0 fall=1
meas ac phase_at_ugf find phase when gain_db=0 fall=1

* Phase margin calculation (assuming non-inverting DC phase = 0)
let pm = 180 + phase_at_ugf
print pm

quit
.endc
.end
