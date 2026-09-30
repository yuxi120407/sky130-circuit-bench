* Testbench for Baker CMOS Chapter 22 - NMOS Differential Amplifier (Fig 22.2)
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
.param L_xm1_sub=0.5
.param L_xm2=0.5
.param L_xm20=0.5
.param L_xm21=0.5
.param L_xm22=0.5
.param L_xm23=0.5
.param L_xm24=0.5
.param L_xm25=0.5
.param L_xm26=0.5
.param L_xm2_sub=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm6b=0.5
.param L_xm6t=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Parameter definitions for DUT
.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=10.0 L_xm2=1.0
.param W_xm6t=20.0 L_xm6t=1.0
.param W_xm6b=20.0 L_xm6b=1.0

* Bias generator parameters (SUB_1)
.param W_xmsu1=5.0 L_xmsu1=1.0
.param W_xmsu2=5.0 L_xmsu2=1.0
.param W_xmsu3=5.0 L_xmsu3=1.0
.param W_xm1_sub=10.0 L_xm1_sub=1.0
.param W_xm2_sub=10.0 L_xm2_sub=1.0
.param W_xm3=10.0 L_xm3=1.0
.param W_xm4=10.0 L_xm4=1.0
.param W_xm5=10.0 L_xm5=1.0
.param W_xm6=10.0 L_xm6=1.0
.param W_xm7=10.0 L_xm7=1.0
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
.param W_xm19=10.0 L_xm19=1.0
.param W_xm20=10.0 L_xm20=1.0
.param W_xm21=10.0 L_xm21=1.0
.param W_xm22=10.0 L_xm22=1.0
.param W_xm23=10.0 L_xm23=1.0
.param W_xm24=10.0 L_xm24=1.0
.param W_xm25=10.0 L_xm25=1.0
.param W_xm26=10.0 L_xm26=1.0

* Power Supplies and Inputs
VDD VDD 0 1.8
VCM VCM 0 dc 0.9
VI1_diff VI1_diff 0 dc 0 ac 1
E1 N001 N002 VI1_diff 0 1.0
E2 N002 0 VCM 0 1.0

* Circuit Under Test (Figure 22.2)
xm6b N004 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6b} l={L_xm6b}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xm6t N003 Vbias3 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm6t} l={L_xm6t}
xm1 VDD N001 N003 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 VDD N002 N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}

.subckt SUB_1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD GND
  xmsu2 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N001 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 N002 N001 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1_sub} l={L_xm1_sub}
  xm2 N002 Vbiasn N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2_sub} l={L_xm2_sub}
  R1 N003 0 6.5k
  xm5 Vbias2 Vbias2 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
  xm6 Vbias2 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
  xm7 N005 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xm8 Vbias1 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
  xm9 Vbias1 Vbias2 N005 VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
  xm10 Vhigh Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
  xm11 Vncas Vbias2 Vhigh VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
  xm12 Vncas Vncas N009 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
  xm13 N009 Vbias3 N010 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
  xm14 N010 N009 GND 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
  xm15 N006 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm15} l={L_xm15}
  xm16 Vbias3 Vbias2 N006 VDD sky130_fd_pr__pfet_01v8 w={W_xm16} l={L_xm16}
  xm17 N007 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm17} l={L_xm17}
  xm18 Vbias4 Vbias2 N007 VDD sky130_fd_pr__pfet_01v8 w={W_xm18} l={L_xm18}
  xm19 N008 N004 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm19} l={L_xm19}
  xm20 N004 Vbias2 N008 VDD sky130_fd_pr__pfet_01v8 w={W_xm20} l={L_xm20}
  xm21 Vpcas Vpcas N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm21} l={L_xm21}
  xm22 Vbias3 Vbias3 0 0 sky130_fd_pr__nfet_01v8 w={W_xm22} l={L_xm22}
  xm23 Vpcas Vbias3 N011 0 sky130_fd_pr__nfet_01v8 w={W_xm23} l={L_xm23}
  xm24 N011 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
  xm25 Vbias4 Vbias3 Vlow 0 sky130_fd_pr__nfet_01v8 w={W_xm25} l={L_xm25}
  xm26 Vlow Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm26} l={L_xm26}
.ends SUB_1

.control
save all @m.xm1.msky130_fd_pr__nfet_01v8[id] @m.xm2.msky130_fd_pr__nfet_01v8[id] @m.xm6t.msky130_fd_pr__nfet_01v8[id]
save @m.xm1.msky130_fd_pr__nfet_01v8[vdsat] @m.xm6t.msky130_fd_pr__nfet_01v8[vdsat] @m.xm1.msky130_fd_pr__nfet_01v8[gm]

* 1. OP Analysis
op
let tail_current_iss = @m.xm6t.msky130_fd_pr__nfet_01v8[id]
let small_signal_transconductance = @m.xm1.msky130_fd_pr__nfet_01v8[gm]
print tail_current_iss small_signal_transconductance

* 2. DC Sweep for differential characteristics
dc VI1_diff -0.9 0.9 0.001
let id1 = @m.xm1.msky130_fd_pr__nfet_01v8[id]
let id2 = @m.xm2.msky130_fd_pr__nfet_01v8[id]
let iss = id1 + id2
let id1_frac = id1 / iss

meas dc quiescent_branch_current find id1 at=0
meas dc vi1_max_steering find v(N001) when id1_frac=0.99
meas dc vi1_min_steering find v(N001) when id1_frac=0.01
print quiescent_branch_current vi1_max_steering vi1_min_steering

* 3. DC Sweep for common-mode characteristics
dc VCM 0 2.5 0.001
let vds_m1 = v(VDD) - v(N003)
let vdsat_m1 = @m.xm1.msky130_fd_pr__nfet_01v8[vdsat]
let sat_margin_m1 = vds_m1 - vdsat_m1

let vds_m6t = v(N003) - v(N004)
let vdsat_m6t = @m.xm6t.msky130_fd_pr__nfet_01v8[vdsat]
let sat_margin_m6t = vds_m6t - vdsat_m6t

meas dc vcm_max find v(N001) when sat_margin_m1=0 fall=1
meas dc vcm_min find v(N001) when sat_margin_m6t=0 rise=1

print vcm_max vcm_min

* 4. AC Analysis
ac dec 10 1k 100k

quit
.endc
.end