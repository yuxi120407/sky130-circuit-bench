* Differential Amplifier with Current Mirror Load - Baker Fig 22.17
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
.param L_xm1_sub=0.5
.param L_xm2=0.5
.param L_xm2_sub=0.5
.param L_xm3=0.5
.param L_xm3_sub=0.5
.param L_xm4=0.5
.param L_xm4_sub=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm6b=0.5
.param L_xm6t=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
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

* Transistor sizing parameters
.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=10.0 L_xm2=1.0
.param W_xm3=30.0 L_xm3=1.0
.param W_xm4=30.0 L_xm4=1.0
.param W_xm6t=100.0 L_xm6t=1.0
.param W_xm6b=100.0 L_xm6b=1.0

* Bias generator SUB_1 transistor sizing parameters
.param W_xmsu1=10.0 L_xmsu1=1.0
.param W_xmsu2=30.0 L_xmsu2=1.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xmsu4=10.0 L_xmsu4=1.0
.param W_xm1_sub=10.0 L_xm1_sub=1.0
.param W_xm2_sub=10.0 L_xm2_sub=1.0
.param W_xm3_sub=30.0 L_xm3_sub=1.0
.param W_xm4_sub=30.0 L_xm4_sub=1.0
.param W_xm5=10.0 L_xm5=1.0
.param W_xm6=10.0 L_xm6=1.0
.param W_xm7=30.0 L_xm7=1.0
.param W_xm8=10.0 L_xm8=1.0
.param W_xm9=10.0 L_xm9=1.0
.param W_xm10=10.0 L_xm10=1.0
.param W_xm11=10.0 L_xm11=1.0
.param W_xm12=10.0 L_xm12=1.0
.param W_xm13=10.0 L_xm13=1.0
.param W_xm14=10.0 L_xm14=1.0
.param W_xm15=10.0 L_xm15=1.0
.param W_xm16=10.0 L_xm16=1.0
.param W_xm17=10.0 L_xm17=1.0
.param W_xm18=10.0 L_xm18=1.0
.param W_xma1=30.0 L_xma1=1.0
.param W_xma2=30.0 L_xma2=1.0
.param W_xma3=30.0 L_xma3=1.0
.param W_xma4=30.0 L_xma4=1.0
.param W_xma5=30.0 L_xma5=1.0
.param W_xma6=30.0 L_xma6=1.0
.param W_xma7=30.0 L_xma7=1.0
.param W_xma8=30.0 L_xma8=1.0
.param W_xma9=30.0 L_xma9=1.0
.param W_xma10=30.0 L_xma10=1.0
.param W_xma11=30.0 L_xma11=1.0
.param W_xma12=30.0 L_xma12=1.0

* DUT Circuit
VDD VDD 0 DC 1.8
VC N002 0 DC 0.6 AC 0
Itest Vout 0 DC 0 AC 0
xm2 Vout N002 N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 N002 N003 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 Vout N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xm6t N003 Vbias3 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm6t} l={L_xm6t}
xm6b N004 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6b} l={L_xm6b}
CL Vout 0 1p

* Bias Circuit Subcircuit
.subckt SUB_1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 N003 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3_sub} l={L_xm3_sub}
  xm4 N004 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4_sub} l={L_xm4_sub}
  xm1 N003 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1_sub} l={L_xm1_sub}
  xm2 N004 N004 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm2_sub} l={L_xm2_sub}
  R1 N005 GND 5.5k
  xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm5 N001 N004 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
  xm6 Vbiasp N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
  xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xma1 Vbias3 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma1} l={L_xma1}
  xma2 Vbias4 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma2} l={L_xma2}
  xmsu4 Vbias3 Vbias3 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu4} l={L_xmsu4}
  xm8 Vbias4 Vbias3 Vlow 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
  xm9 Vlow Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
  xm10 Vpcas Vbias3 N009 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
  xm11 N009 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
  xm12 Vbias2 Vbias3 N010 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
  xm13 N010 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
  xm14 Vbias1 Vbias3 N011 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
  xm15 N011 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm15} l={L_xm15}
  xma5 Vpcas Vpcas N006 VDD sky130_fd_pr__pfet_01v8 w={W_xma5} l={L_xma5}
  xma6 N006 Vbias2 N007 VDD sky130_fd_pr__pfet_01v8 w={W_xma6} l={L_xma6}
  xma7 N007 N006 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma7} l={L_xma7}
  xma8 Vbias2 Vbias2 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma8} l={L_xma8}
  xma9 Vbias1 Vbias2 Vhigh VDD sky130_fd_pr__pfet_01v8 w={W_xma9} l={L_xma9}
  xma10 Vhigh Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma10} l={L_xma10}
  xma11 Vncas Vbias2 N008 VDD sky130_fd_pr__pfet_01v8 w={W_xma11} l={L_xma11}
  xma12 N008 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma12} l={L_xma12}
  xm16 Vncas Vncas N012 0 sky130_fd_pr__nfet_01v8 w={W_xm16} l={L_xm16}
  xm17 N012 Vbias3 P001 0 sky130_fd_pr__nfet_01v8 w={W_xm17} l={L_xm17}
  xm18 P001 N012 0 0 sky130_fd_pr__nfet_01v8 w={W_xm18} l={L_xm18}
.ends SUB_1

.control
* 1. DC Operating Point
op
let vout_dc = v(Vout)
print vout_dc
let gm1_val = @m.xm1.msky130_fd_pr__nfet_01v8[gm]
set gm1_var = $&gm1_val

* 2. AC Analysis for Zout and diff_gain
alter Itest ac=1
alter VC ac=0
ac dec 10 1 100Meg
let vout_mag = mag(v(Vout))
meas ac zout_dc find vout_mag at=1
let diff_gain_mag = abs($gm1_var) * zout_dc
let diff_gain_ad = 20 * log10(diff_gain_mag)
print diff_gain_ad
set diff_gain_ad_var = $&diff_gain_ad

let zout_3db = zout_dc / sqrt(2)
set zout_3db_val = $&zout_3db
meas ac bandwidth_3db when vout_mag = $zout_3db_val
print bandwidth_3db

* 3. AC Analysis for Common-Mode Gain
alter Itest ac=0
alter VC ac=1
ac dec 10 1 100Meg
let vout_mag_cm = mag(v(Vout))
meas ac cm_gain_mag find vout_mag_cm at=1
let cm_gain_ac = 20 * log10(cm_gain_mag)
print cm_gain_ac
set cm_gain_ac_var = $&cm_gain_ac

* 4. CMRR
let cmrr = $diff_gain_ad_var - $cm_gain_ac_var
print cmrr

* 5. DC Sweep for vcm_output_variation
dc VC 500m 700m 1m
meas dc vout_500 find v(Vout) at=500m
meas dc vout_700 find v(Vout) at=700m
let vcm_output_variation = abs(vout_700 - vout_500)
print vcm_output_variation

* 6. DC Sweep for vcm_max and vcm_min
dc VC 0 1.8 0.01
let vgd1 = v(N002) - v(N001)
meas dc vcm_max when vgd1 = 0.4

let vgd_tail = v(Vbias3) - v(N003)
meas dc vcm_min when vgd_tail = 0.4

* 7. DC Sweep for vout_max and vout_min
dc Itest -200u 200u 1u
let vdg4 = v(Vout) - v(N001)
meas dc vout_max find v(Vout) when vdg4 = 0.4

let vgd2 = v(N002) - v(Vout)
meas dc vout_min find v(Vout) when vgd2 = 0.4

* 8. DC Sweep for vdd_min
dc VDD 1.8 0 -0.01
let vgd1_vdd = v(N002) - v(N001)
meas dc vdd_min when vgd1_vdd = 0.4

quit
.endc
.end