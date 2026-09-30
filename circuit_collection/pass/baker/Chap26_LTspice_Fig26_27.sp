* Testbench for Two-Stage Op-Amp with CMFB Input (Fig 26.26 / Fig 26.27)
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
.param L_xm21=0.5
.param L_xm22=0.5
.param L_xm23=0.5
.param L_xm24=0.5
.param L_xm25=0.5
.param L_xm26=0.5
.param L_xm27=0.5
.param L_xm28=0.5
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

* DUT Parameters
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
.param W_xm21=20.0 L_xm21=1.0
.param W_xm22=20.0 L_xm22=1.0
.param W_xm23=10.0 L_xm23=1.0
.param W_xm24=10.0 L_xm24=1.0
.param W_xm25=20.0 L_xm25=1.0
.param W_xm26=20.0 L_xm26=1.0
.param W_xm27=10.0 L_xm27=1.0
.param W_xm28=10.0 L_xm28=1.0

.param W_xmsu1=10.0 L_xmsu1=1.0
.param W_xmsu2=20.0 L_xmsu2=1.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xma3=20.0 L_xma3=1.0
.param W_xma4=20.0 L_xma4=1.0

* Power Supplies and Bias
VDD VDD 0 1.8
VCM VCM 0 0.5
VCMFB VCMFB 0 0.5

* DUT Instantiation
xm2 N001 N001 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 N001 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 N001 Vbiasn N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 vodm Vbiasn N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
X_U1 Vbiasn Vbiasp VDD 0 SUB_1
xm6 N001 Vbiasn N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
xm7 vodp Vbiasn N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
xm9 N003 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
xm10 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
xm11 N004 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
xm12 vodp N001 ncr 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
xm13 vodm N001 ncl 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
xm5 N008 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm14 N008 VCMFB 0 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
xm15 N007 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm15} l={L_xm15}
xm16 N007 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm16} l={L_xm16}
xm17 ncr VCM N007 0 sky130_fd_pr__nfet_01v8 w={W_xm17} l={L_xm17}
xm18 ncl VCM N007 0 sky130_fd_pr__nfet_01v8 w={W_xm18} l={L_xm18}
xm19 N005 VCM N008 0 sky130_fd_pr__nfet_01v8 w={W_xm19} l={L_xm19}
xm20 N006 VCM N008 0 sky130_fd_pr__nfet_01v8 w={W_xm20} l={L_xm20}
xm21 vom vodp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm21} l={L_xm21}
xm22 N010 vodm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm22} l={L_xm22}
xm23 vom N010 0 0 sky130_fd_pr__nfet_01v8 w={W_xm23} l={L_xm23}
xm24 N010 N010 0 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
C1 vom ncr 5e-14
xm25 vop vodm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm25} l={L_xm25}
xm26 N009 vodp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm26} l={L_xm26}
xm27 vop N009 0 0 sky130_fd_pr__nfet_01v8 w={W_xm27} l={L_xm27}
xm28 N009 N009 0 0 sky130_fd_pr__nfet_01v8 w={W_xm28} l={L_xm28}
C2 vop ncl 5e-14

* Subcircuit Definition
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

* Simulation Control
.control
  op
  let idd = -i(VDD)
  print idd
  let pwr = idd * 1.8
  print pwr

  dc VCMFB 0.2 1.2 0.002
  let d_vop = deriv(v(vop))
  let abs_gain = abs(d_vop)

  meas dc voh max v(vop)
  meas dc vol min v(vop)
  meas dc max_gain max abs_gain
  meas dc vcmfb_trans when abs_gain=max_gain

  print voh vol max_gain vcmfb_trans
  quit
.endc

.end