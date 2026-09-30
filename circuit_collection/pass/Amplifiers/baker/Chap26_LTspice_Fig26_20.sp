* Testbench for Figure 26.19 / Figure 26.20 Cascode Diff-Amp
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
.param L_xm2_sub=0.5
.param L_xm3=0.5
.param L_xm3_sub=0.5
.param L_xm4=0.5
.param L_xm4_sub=0.5
.param L_xm5=0.5
.param L_xm5_sub=0.5
.param L_xm6=0.5
.param L_xm6_sub=0.5
.param L_xm7=0.5
.param L_xm7_sub=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xma3=0.5
.param L_xma4=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Device parameter sizing based on Baker Ch. 26 (NMOS: 10/1, PMOS: 20/1)
.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=10.0 L_xm2=1.0
.param W_xm3=20.0 L_xm3=1.0
.param W_xm4=20.0 L_xm4=1.0
.param W_xm5=10.0 L_xm5=1.0
.param W_xm6=20.0 L_xm6=1.0
.param W_xm7=20.0 L_xm7=1.0
.param W_xm8=20.0 L_xm8=1.0
.param W_xm9=20.0 L_xm9=1.0
.param W_xm10=20.0 L_xm10=1.0
.param W_xm11=20.0 L_xm11=1.0
.param W_xm12=10.0 L_xm12=1.0
.param W_xm13=10.0 L_xm13=1.0
.param W_xm14=10.0 L_xm14=1.0
.param W_xm15=10.0 L_xm15=1.0
.param W_xm16=10.0 L_xm16=1.0
.param W_xm17=10.0 L_xm17=1.0
.param W_xm18=10.0 L_xm18=1.0
.param W_xm19=10.0 L_xm19=1.0
.param W_xm20=10.0 L_xm20=1.0

* Subcircuit device parameters
.param W_xmsu1=10.0 L_xmsu1=1.0
.param W_xmsu2=20.0 L_xmsu2=1.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xm1_sub=10.0 L_xm1_sub=1.0
.param W_xm2_sub=10.0 L_xm2_sub=1.0
.param W_xm3_sub=20.0 L_xm3_sub=1.0
.param W_xm4_sub=20.0 L_xm4_sub=1.0
.param W_xm5_sub=10.0 L_xm5_sub=1.0
.param W_xm6_sub=10.0 L_xm6_sub=1.0
.param W_xm7_sub=20.0 L_xm7_sub=1.0
.param W_xma3=20.0 L_xma3=1.0
.param W_xma4=20.0 L_xma4=1.0

* Circuit Netlist (DUT)
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
xm18 N005 VCM N009 0 sky130_fd_pr__nfet_01v8 w={W_xm18} l={L_xm18}
xm19 N006 VCM N010 0 sky130_fd_pr__nfet_01v8 w={W_xm19} l={L_xm19}
xm20 N007 VCM N010 0 sky130_fd_pr__nfet_01v8 w={W_xm20} l={L_xm20}

.subckt SUB_1 Vbiasn Vbiasp VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 Vbiasn GND 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3_sub} l={L_xm3_sub}
  xm4 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4_sub} l={L_xm4_sub}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1_sub} l={L_xm1_sub}
  R1 N004 0 4k
  xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm5 N001 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5_sub} l={L_xm5_sub}
  xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7_sub} l={L_xm7_sub}
  xm2 Vbiasp Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2_sub} l={L_xm2_sub}
  xm6 N003 N003 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm6_sub} l={L_xm6_sub}
.ends SUB_1

* Control Block
.control
  op
  let p_diss = -i(VDD) * 1.8
  print p_diss

  dc VCM 0.4 0.6 0.002
  let vocm = (v(vop) + v(vom)) / 2
  meas dc vocm_nominal find vocm at=0.5
  meas dc vocm_low find vocm at=0.4
  meas dc vocm_high find vocm at=0.6
  let delta_vocm = abs(vocm_high - vocm_low)
  let acm = (vocm_high - vocm_low) / 0.2
  print vocm_nominal vocm_low vocm_high delta_vocm acm
  quit
.endc

.end