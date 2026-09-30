* Testbench for Baker Fig 26.19 Fully-Differential Cascode Diff-Amp
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_n=0.5
.param L_p=0.5
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
.param L_xma3=0.5
.param L_xma4=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Parameter definitions for 10/1 NMOS and 20/1 PMOS devices (Baker Chapter 26)
.param W_n=10.0 L_n=1.0
.param W_p=20.0 L_p=1.0

.param W_xm1={W_n} L_xm1={L_n}
.param W_xm2={W_n} L_xm2={L_n}
.param W_xm3={W_p} L_xm3={L_p}
.param W_xm4={W_p} L_xm4={L_p}
.param W_xm5={W_n} L_xm5={L_n}
.param W_xm6={W_p} L_xm6={L_p}
.param W_xm7={W_p} L_xm7={L_p}
.param W_xm8={W_p} L_xm8={L_p}
.param W_xm9={W_p} L_xm9={L_p}
.param W_xm10={W_p} L_xm10={L_p}
.param W_xm11={W_p} L_xm11={L_p}
.param W_xm12={W_n} L_xm12={L_n}
.param W_xm13={W_n} L_xm13={L_n}
.param W_xm14={W_n} L_xm14={L_n}
.param W_xm15={W_n} L_xm15={L_n}
.param W_xm16={W_n} L_xm16={L_n}
.param W_xm17={W_n} L_xm17={L_n}
.param W_xm18={W_n} L_xm18={L_n}
.param W_xm19={W_n} L_xm19={L_n}
.param W_xm20={W_n} L_xm20={L_n}

.param W_xmsu1={W_n} L_xmsu1={L_n}
.param W_xmsu2={W_p} L_xmsu2={L_p}
.param W_xmsu3={W_n} L_xmsu3={L_n}
.param W_xma3={W_p} L_xma3={L_p}
.param W_xma4={W_p} L_xma4={L_p}

* DUT Circuit
VDD VDD 0 1.8
xm2 N001 N001 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 N001 N007 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 N001 Vbiasn N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 vom Vbiasn N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
VCM VCM 0 500m
X_U1 Vbiasn Vbiasp VDD 0 SUB_1
xm6 N001 Vbiasn N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
xm7 vop Vbiasn N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
xm9 N003 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
xm10 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
xm11 N004 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
xm12 vop N001 N008 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
xm13 vom N001 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
xm5 N010 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm14 N010 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
xm15 N009 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm15} l={L_xm15}
xm16 N009 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm16} l={L_xm16}
xm17 N008 VCM N009 0 sky130_fd_pr__nfet_01v8 w={W_xm17} l={L_xm17}
xm18 N005 Vinp N009 0 sky130_fd_pr__nfet_01v8 w={W_xm18} l={L_xm18}
xm19 N006 Vinp N010 0 sky130_fd_pr__nfet_01v8 w={W_xm19} l={L_xm19}
xm20 N007 VCM N010 0 sky130_fd_pr__nfet_01v8 w={W_xm20} l={L_xm20}

.subckt SUB_1 Vbiasn Vbiasp VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 Vbiasn GND 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  R1 N004 0 4k
  xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm5 N001 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
  xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xm2 Vbiasp Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  xm6 N003 N003 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
.ends SUB_1

* Input drive source for differential input Vinp
Vinp Vinp 0 dc 500m

.control
* 1. Operating Point Analysis
op
let idd_total = -i(vdd)
print idd_total
print v(vop) v(vom) v(vbiasn) v(vbiasp)

* 2. Differential DC Sweep (as in Fig 26.21)
dc Vinp 400m 600m 0.5m
let vdiff_out = v(vop) - v(vom)
let vdiff_in = v(vinp) - 500m
let vocm = 0.5 * (v(vop) + v(vom))
let gain_diff = deriv(vdiff_out)
let gain_diff_db = 20 * log10(abs(gain_diff))

meas dc max_gain_diff max gain_diff
meas dc max_gain_diff_db max gain_diff_db
meas dc v_ocm_at_zero find vocm at=500m
meas dc vop_max max v(vop)
meas dc vop_min min v(vop)
meas dc vdiff_max max vdiff_out
meas dc vdiff_min min vdiff_out
let swing_diff = vdiff_max - vdiff_min
print swing_diff

* 3. Common-Mode DC Sweep (as in Fig 26.20)
dc VCM 400m 600m 1m
let vocm_sweep = 0.5 * (v(vop) + v(vom))
let gain_cm = deriv(vocm_sweep)
meas dc cm_gain find gain_cm at=500m
let cm_gain_db = 20 * log10(abs(cm_gain))
print cm_gain cm_gain_db
let cmrr_calc = max_gain_diff / abs(cm_gain)
let cmrr_calc_db = 20 * log10(cmrr_calc)
print cmrr_calc cmrr_calc_db

quit
.endc
.end