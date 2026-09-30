* CS Amplifier Testbench
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
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param W_xm10=5.0
.param W_xm12=5.0
.param W_xm13=5.0
.param W_xm14=5.0
.param W_xm16=5.0
.param W_xm17=5.0
.param W_xm18=5.0
.param W_xm20=5.0
.param W_xm21=5.0
.param W_xm22=5.0
.param W_xm24=5.0
.param W_xm25=5.0
.param W_xm26=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm8=5.0
.param W_xm9=5.0
.param W_xmsu1=5.0
.param W_xmsu3=5.0

* Define parameters for the parameterized netlist
.param W_xm1=10 L_xm1=1
.param W_xm2=20 L_xm2=1
.param W_xmsu2=10 L_xmsu2=1 W_xmsu1=10 L_xmsu1=1 W_xmsu3=10 L_xmsu3=1
.param W_xm3=10 L_xm3=1 W_xm4=10 L_xm4=1 W_xm5=10 L_xm5=1 W_xm6=10 L_xm6=1
.param W_xm7=10 L_xm7=1 W_xm8=10 L_xm8=1 W_xm9=10 L_xm9=1 W_xm10=10 L_xm10=1
.param W_xm11=10 L_xm11=1 W_xm12=10 L_xm12=1 W_xm13=10 L_xm13=1 W_xm14=10 L_xm14=1
.param W_xm15=10 L_xm15=1 W_xm16=10 L_xm16=1 W_xm17=10 L_xm17=1 W_xm18=10 L_xm18=1
.param W_xm19=10 L_xm19=1 W_xm20=10 L_xm20=1 W_xm21=10 L_xm21=1 W_xm22=10 L_xm22=1
.param W_xm23=10 L_xm23=1 W_xm24=10 L_xm24=1 W_xm25=10 L_xm25=1 W_xm26=10 L_xm26=1

* Input sources
V1 Vin 0 dc 0.9 ac 1 sin(0.9 1m 1Meg)

* DUT
VDD VDD 0 1.8
xm1 Vout Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 Vout Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
C1 Vout 0 1e-12

.subckt SUB_1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD GND
  xmsu2 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N001 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 N002 N001 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm2 N002 Vbiasn N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
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
  * Find DC bias point where Vout = 0.9V
  dc V1 0 1.8 0.01
  meas dc vin_bias find v(Vin) when v(Vout)=0.9
  
  * Set bias for AC and Tran
  alter @V1[dc] = vin_bias
  alter @V1[sin] = [ $&vin_bias 1m 1Meg ]
  
  * AC Analysis
  ac dec 100 1 10G
  let gain_db = vdb(Vout)
  let phase = 180/PI * cph(v(Vout))
  
  meas ac low_freq_gain max gain_db
  let gain_3db = low_freq_gain - 3
  meas ac f_3db when gain_db=gain_3db fall=1
  meas ac f_un when gain_db=0 fall=1
  meas ac phase_margin find phase when gain_db=0 fall=1
  
  * Transient Analysis
  tran 1n 5u
  meas tran vout_max max v(Vout)
  meas tran vout_min min v(Vout)
  let vout_ptp = vout_max - vout_min
  let gain_tran = vout_ptp / 2m
  print gain_tran
  
  * Operating Point
  op
  let power = -i(VDD) * 1.8
  print power
  
  quit
.endc
.end