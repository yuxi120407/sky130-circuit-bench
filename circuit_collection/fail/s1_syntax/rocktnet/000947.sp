* Dual-Path OTA Testbench

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

* DUT
XM1 N3 N8 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N6 N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 LABEL_NET_0 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N10 N9 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 LABEL_NET_2 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N4 N0 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N10 N11 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N7 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N4 N5 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N5 N9 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N3 LABEL_NET_3 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 N5 N11 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 N1 LABEL_NET_5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}

* Fix missing connection from OCR (LABEL_NET_3 is the symmetric counterpart to N5)
Vshort LABEL_NET_3 N10 0

* Power supply
VVDD VDD 0 1.8

* Biases
Vbias_tail LABEL_NET_1 0 0.7
Vbias_casc N9 0 1.1
Vbias_ptail LABEL_NET_5 0 1.0

* Ideal CMFB for main outputs (N4, N3) to hold CM at 0.9V
Ecmfb1_1 LABEL_NET_0 0 vol='1.0 + 5*( (v(N4)+v(N3))/2 - 0.9 )'
Ecmfb1_2 LABEL_NET_2 0 vol='1.0 + 5*( (v(N4)+v(N3))/2 - 0.9 )'

* Ideal CMFB for aux outputs (N5, N10) to hold CM at 0.9V
Ecmfb2 N11 0 vol='1.0 + 5*( (v(N5)+v(N10))/2 - 0.9 )'

* Inputs (Combined AC and Tran)
Vac_p in_ac_p 0 dc 0 ac 0.5
Vac_n in_ac_n 0 dc 0 ac -0.5

Vtran_p in_tran_p 0 pulse(0 0.5 1n 10p 10p 10n 20n)
Vtran_n in_tran_n 0 pulse(0 -0.5 1n 10p 10p 10n 20n)

E_inp N8 0 vol='0.9 + v(in_ac_p) + v(in_tran_p)'
E_inn N0 0 vol='0.9 + v(in_ac_n) + v(in_tran_n)'

* Differential output
Ediff out_diff 0 vol='v(N4) - v(N3)'

* Load capacitors
Cload1 N4 0 100f
Cload2 N3 0 100f

.control
* 1. DC Operating Point & Power
op
let power = -i(VVDD) * 1.8
print power

* 2. AC Analysis (Gain, UGF, Phase Margin)
ac dec 100 1k 10G
let gain_db = vdb(out_diff)
let phase = 180/PI * cph(v(out_diff))
meas ac dc_gain find gain_db at=1k
meas ac ugf when gain_db=0 fall=1
meas ac phase_at_ugf find phase when gain_db=0 fall=1
let pm = phase_at_ugf + 180
print dc_gain ugf pm

* 3. Transient Analysis (Slew Rate)
tran 10p 20n
meas tran t_rise trig v(out_diff) val=-0.5 rise=1 targ v(out_diff) val=0.5 rise=1
let sr_rise = 1.0 / t_rise
meas tran t_fall trig v(out_diff) val=0.5 fall=1 targ v(out_diff) val=-0.5 fall=1
let sr_fall = 1.0 / t_fall
print sr_rise sr_fall

quit
.endc
.end