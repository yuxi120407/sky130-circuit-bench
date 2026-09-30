* Baker Ch 22 Diff-Amp CMRR Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm10_sub=0.5
.param L_xm11_sub=0.5
.param L_xm12_sub=0.5
.param L_xm13_sub=0.5
.param L_xm14_sub=0.5
.param L_xm15_sub=0.5
.param L_xm16_sub=0.5
.param L_xm17_sub=0.5
.param L_xm18_sub=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm6b=0.5
.param L_xm6t=0.5
.param L_xm7=0.5
.param L_xm7_sub=0.5
.param L_xm8=0.5
.param L_xm8_sub=0.5
.param L_xm9=0.5
.param L_xm9_sub=0.5
.param L_xma1=0.5
.param L_xma10=0.5
.param L_xma11=0.5
.param L_xma12=0.5
.param L_xma2=0.5
.param L_xma3=0.5
.param L_xma4=0.5
.param L_xma5=0.5
.param L_xma6=0.5
.param L_xma7=0.5
.param L_xma8=0.5
.param L_xma9=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param L_xmsu4=0.5

.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=10.0 L_xm2=1.0
.param W_xm3=10.0 L_xm3=1.0
.param W_xm4=10.0 L_xm4=1.0
.param W_xm5=10.0 L_xm5=1.0
.param W_xm6=10.0 L_xm6=1.0
.param W_xm7=10.0 L_xm7=1.0
.param W_xm8=10.0 L_xm8=1.0
.param W_xm6t=20.0 L_xm6t=1.0
.param W_xm6b=20.0 L_xm6b=1.0
.param W_xm9=20.0 L_xm9=1.0
.param W_xm10=20.0 L_xm10=1.0
.param W_xmsu1=5.0 L_xmsu1=1.0
.param W_xmsu2=5.0 L_xmsu2=1.0
.param W_xmsu3=5.0 L_xmsu3=1.0
.param W_xmsu4=5.0 L_xmsu4=1.0
.param W_xma1=10.0 L_xma1=1.0
.param W_xma2=10.0 L_xma2=1.0
.param W_xma3=10.0 L_xma3=1.0
.param W_xma4=10.0 L_xma4=1.0
.param W_xma5=10.0 L_xma5=1.0
.param W_xma6=10.0 L_xma6=1.0
.param W_xma7=10.0 L_xma7=1.0
.param W_xma8=10.0 L_xma8=1.0
.param W_xma9=10.0 L_xma9=1.0
.param W_xma10=10.0 L_xma10=1.0
.param W_xma11=10.0 L_xma11=1.0
.param W_xma12=10.0 L_xma12=1.0
.param W_xm7_sub=10.0 L_xm7_sub=1.0
.param W_xm8_sub=10.0 L_xm8_sub=1.0
.param W_xm9_sub=10.0 L_xm9_sub=1.0
.param W_xm10_sub=10.0 L_xm10_sub=1.0
.param W_xm11_sub=10.0 L_xm11_sub=1.0
.param W_xm12_sub=10.0 L_xm12_sub=1.0
.param W_xm13_sub=10.0 L_xm13_sub=1.0
.param W_xm14_sub=10.0 L_xm14_sub=1.0
.param W_xm15_sub=10.0 L_xm15_sub=1.0
.param W_xm16_sub=10.0 L_xm16_sub=1.0
.param W_xm17_sub=10.0 L_xm17_sub=1.0
.param W_xm18_sub=10.0 L_xm18_sub=1.0

* Power Supplies and Inputs
VDD VDD 0 1.8
VCM VCM 0 DC 0.7
V_VI1 VI1 VCM DC 0 AC 1
VI2 N003 VCM DC 0

* Load capacitances (Ex 22.6)
CLd Voutd 0 1p
CLc Voutc 0 1p

* Differential Pair (outputs Voutd)
xm2 Voutd N003 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 VI1 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 Voutd N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm6t N004 Vbias3 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm6t} l={L_xm6t}
xm6b N006 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6b} l={L_xm6b}

* Common-Mode Pair (outputs Voutc, both gates tied to VI1)
xm5 Voutc VI1 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 N002 VI1 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 Voutc N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
xm9 N005 Vbias3 N007 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm10 N007 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}

* Bias Generator Subcircuit
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1

.subckt SUB_1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 N003 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 N004 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm1 N003 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm2 N004 N004 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  R1 N005 GND 5.5k
  xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm5 N001 N004 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
  xm6 Vbiasp N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
  xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7_sub} l={L_xm7_sub}
  xma1 Vbias3 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma1} l={L_xma1}
  xma2 Vbias4 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma2} l={L_xma2}
  xmsu4 Vbias3 Vbias3 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu4} l={L_xmsu4}
  xm8 Vbias4 Vbias3 Vlow 0 sky130_fd_pr__nfet_01v8 w={W_xm8_sub} l={L_xm8_sub}
  xm9 Vlow Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm9_sub} l={L_xm9_sub}
  xm10 Vpcas Vbias3 N009 0 sky130_fd_pr__nfet_01v8 w={W_xm10_sub} l={L_xm10_sub}
  xm11 N009 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm11_sub} l={L_xm11_sub}
  xm12 Vbias2 Vbias3 N010 0 sky130_fd_pr__nfet_01v8 w={W_xm12_sub} l={L_xm12_sub}
  xm13 N010 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm13_sub} l={L_xm13_sub}
  xm14 Vbias1 Vbias3 N011 0 sky130_fd_pr__nfet_01v8 w={W_xm14_sub} l={L_xm14_sub}
  xm15 N011 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm15_sub} l={L_xm15_sub}
  xma5 Vpcas Vpcas N006 VDD sky130_fd_pr__pfet_01v8 w={W_xma5} l={L_xma5}
  xma6 N006 Vbias2 N007 VDD sky130_fd_pr__pfet_01v8 w={W_xma6} l={L_xma6}
  xma7 N007 N006 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma7} l={L_xma7}
  xma8 Vbias2 Vbias2 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma8} l={L_xma8}
  xma9 Vbias1 Vbias2 Vhigh VDD sky130_fd_pr__pfet_01v8 w={W_xma9} l={L_xma9}
  xma10 Vhigh Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma10} l={L_xma10}
  xma11 Vncas Vbias2 N008 VDD sky130_fd_pr__pfet_01v8 w={W_xma11} l={L_xma11}
  xma12 N008 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma12} l={L_xma12}
  xm16 Vncas Vncas N012 0 sky130_fd_pr__nfet_01v8 w={W_xm16_sub} l={L_xm16_sub}
  xm17 N012 Vbias3 P001 0 sky130_fd_pr__nfet_01v8 w={W_xm17_sub} l={L_xm17_sub}
  xm18 P001 N012 0 0 sky130_fd_pr__nfet_01v8 w={W_xm18_sub} l={L_xm18_sub}
.ends SUB_1

.control
* Run Operating Point
op

* Run AC Analysis
ac dec 100 1k 1G
let ad_db = db(v(Voutd))
let ac_db = db(v(Voutc))
let cmrr_db = db(v(Voutd)) - db(v(Voutc))

meas ac differential_gain find ad_db at=1k
meas ac common_mode_gain find ac_db at=1k
meas ac common_mode_rejection_ratio find cmrr_db at=1k

meas ac ad_max max ad_db
let ad_max_3 = ad_max - 3
meas ac 3db_frequency when ad_db=$&ad_max_3 fall=last

print differential_gain common_mode_gain common_mode_rejection_ratio 3db_frequency

* Run DC sweep for differential input range and output swing
dc V_VI1 -0.5 0.5 0.001
meas dc vout_max max v(Voutd)
meas dc vout_min min v(Voutd)

let dvoutd = deriv(v(Voutd))
meas dc max_gain max dvoutd
let gain_thresh = max_gain * 0.1
meas dc v_in_high when dvoutd=$&gain_thresh cross=last
meas dc v_in_low when dvoutd=$&gain_thresh cross=1
let differential_input_range = v_in_high - v_in_low

print vout_max vout_min differential_input_range

* Run DC sweep for common-mode limits
dc VCM 0 1.8 0.01
let dv_n004 = deriv(v(N004))
meas dc max_dv max dv_n004
let dv_thresh = max_dv * 0.5
meas dc vcm_min when dv_n004=$&dv_thresh cross=1
meas dc vcm_max when dv_n004=$&dv_thresh cross=last

print vcm_min vcm_max

quit
.endc
.end