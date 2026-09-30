* Testbench for Fully Differential Class-AB Op-Amp

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm18=0.5
.param L_xm19=0.5
.param L_xm2=0.5
.param L_xm20=0.5
.param L_xm21=0.5
.param L_xm22=0.5
.param L_xm25=0.5
.param L_xm26=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm22=5.0 L_xm22=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm18=5.0 L_xm18=0.5
.param W_xm25=5.0 L_xm25=0.5
.param W_xm26=5.0 L_xm26=0.5
.param W_xm19=5.0 L_xm19=0.5
.param W_xm20=5.0 L_xm20=0.5
.param W_xm21=5.0 L_xm21=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm12=5.0 L_xm12=0.5

* DUT
XM22 VO_MINUS N_M18_D VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm22} w={W_xm22}
XM16 N_M16_D VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}
XM18 N_M18_D VB2 N_M16_D VDD sky130_fd_pr__pfet_01v8 l={L_xm18} w={W_xm18}
XM25 N_M19_D VB4 N_M18_D VDD sky130_fd_pr__pfet_01v8 l={L_xm25} w={W_xm25}
XM26 N_M18_D VB3 N_M19_D GND sky130_fd_pr__nfet_01v8 l={L_xm26} w={W_xm26}
XM19 N_M19_D VB5 N_M19_S GND sky130_fd_pr__nfet_01v8 l={L_xm19} w={W_xm19}
XM20 N_M19_S VB6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm20} w={W_xm20}
XM21 VO_MINUS N_M19_D GND GND sky130_fd_pr__nfet_01v8 l={L_xm21} w={W_xm21}
XM4 N_M19_S VB6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM1 N_M19_S VI_MINUS N_M5_D VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM5 N_M5_D VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM2 N_M9_S VI_PLUS N_M5_D VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N_M9_S VB6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM10 N_M9_S VB6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 VO_PLUS N_M9_D GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM9 N_M9_D VB5 N_M9_S GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM15 N_M9_D VB4 N_M8_D VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}
XM14 N_M8_D VB3 N_M9_D GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM8 N_M8_D VB2 N_M6_D VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM6 N_M6_D VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM12 VO_PLUS N_M8_D VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}

* Miller Compensation Capacitors
CC1 VO_MINUS N_M18_D 1p
CC2 VO_MINUS N_M19_D 1p
CC3 VO_PLUS N_M8_D 1p
CC4 VO_PLUS N_M9_D 1p

* Power and Fixed Biases
VVDD VDD 0 1.8
VVB1 VB1 0 0.8
VVB2 VB2 0 0.4
VVB4 VB4 0 0.0
VVB3 VB3 0 1.8
VVB5 VB5 0 1.3

* CMFB Loop for VB6 (Sets output common-mode to 0.9V)
E_cm_err CM_ERR 0 vol='v(VO_PLUS) + v(VO_MINUS) - 1.8'
R_cm_lp CM_ERR CM_ERR_LP 1G
C_cm_lp CM_ERR_LP 0 1G
Bcmfb VB6 0 V=0.8 - 1.0 * v(CM_ERR_LP)

* Differential DC Feedback Loop (Forces DC differential output to 0V)
E_diff_err DIFF_ERR 0 vol='v(VO_PLUS) - v(VO_MINUS)'
R_diff_lp DIFF_ERR DIFF_ERR_LP 1G
C_diff_lp DIFF_ERR_LP 0 1G

* AC Input Source
Vac IN_AC 0 dc 0 ac 1

* Input Biasing and Feedback (Input CM = 0.9V)
B_in_plus VI_PLUS 0 V=0.9 + 0.5*v(IN_AC) - 1.0 * v(DIFF_ERR_LP)
B_in_minus VI_MINUS 0 V=0.9 - 0.5*v(IN_AC) + 1.0 * v(DIFF_ERR_LP)

* Output Differential Node for Measurement
E_out_diff OUT_DIFF 0 vol='v(VO_PLUS) - v(VO_MINUS)'

* Load Capacitors
CL1 VO_PLUS 0 1p
CL2 VO_MINUS 0 1p

* Initial conditions to aid convergence of the high-impedance DC loops
.ic v(CM_ERR_LP)=0 v(DIFF_ERR_LP)=0 v(VO_PLUS)=0.9 v(VO_MINUS)=0.9

.control
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

ac dec 100 1 1G
let gain_db = db(v(OUT_DIFF))
let phase = 180/PI * cph(v(OUT_DIFF))
let phase_shifted = phase - phase[0]
let pm = 180 + phase_shifted

meas ac dc_gain find gain_db at=1
meas ac ugf when gain_db=0 fall=1
meas ac phase_margin find pm when gain_db=0 fall=1

print dc_gain
print ugf
print phase_margin

quit
.endc
.end