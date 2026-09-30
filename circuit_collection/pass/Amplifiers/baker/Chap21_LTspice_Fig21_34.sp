* Sky130 Two-Stage Amplifier Testbench
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
.param L_xma=0.5
.param L_xmb=0.5
.param L_xmc=0.5
.param L_xmd=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Parameter definitions for DUT
.param W_xma=10.0 L_xma=1.0
.param W_xmb=10.0 L_xmb=1.0
.param W_xmc=30.0 L_xmc=1.0
.param W_xmd=30.0 L_xmd=1.0
.param W_xmsu1=10.0 L_xmsu1=1.0
.param W_xmsu2=30.0 L_xmsu2=1.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=10.0 L_xm2=1.0
.param W_xm3=30.0 L_xm3=1.0
.param W_xm4=30.0 L_xm4=1.0
.param W_xm5=30.0 L_xm5=1.0
.param W_xm6=10.0 L_xm6=1.0
.param W_xm7=30.0 L_xm7=1.0
.param W_xm8=10.0 L_xm8=1.0
.param W_xm9=30.0 L_xm9=1.0
.param W_xm10=30.0 L_xm10=1.0
.param W_xm11=30.0 L_xm11=1.0
.param W_xm12=10.0 L_xm12=1.0
.param W_xm13=10.0 L_xm13=1.0
.param W_xm14=10.0 L_xm14=1.0
.param W_xm15=30.0 L_xm15=1.0
.param W_xm16=30.0 L_xm16=1.0
.param W_xm17=30.0 L_xm17=1.0
.param W_xm18=30.0 L_xm18=1.0
.param W_xm19=30.0 L_xm19=1.0
.param W_xm20=30.0 L_xm20=1.0
.param W_xm21=30.0 L_xm21=1.0
.param W_xm22=10.0 L_xm22=1.0
.param W_xm23=10.0 L_xm23=1.0
.param W_xm24=10.0 L_xm24=1.0
.param W_xm25=10.0 L_xm25=1.0
.param W_xm26=10.0 L_xm26=1.0

* DUT Netlist
VDD VDD 0 1.8
xma n1 Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xma} l={L_xma}
xmc n1 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmc} l={L_xmc}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
R1 Vin n1 1000000000.0
C2 Vs Vin 1e-06
xmb Vout n1 0 0 sky130_fd_pr__nfet_01v8 w={W_xmb} l={L_xmb}
xmd Vout Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmd} l={L_xmd}
Cc1 N001 Vout 1e-12
Rz N001 n1 6500.0

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

* Input Source and Load
Vs Vs 0 dc 0 ac 1 pulse(-0.05 0.05 100n 1n 1n 100n 200n)
CL Vout 0 1p
Iout Vout 0 dc 0 ac 0

.control
  op
  let power_dissipation = abs(i(VDD) * 1.8)
  let bias_current = abs(@m.xmc.msky130_fd_pr__pfet_01v8[id])
  print power_dissipation bias_current

  * AC Analysis for Gain, UGF, PM
  ac dec 100 10 1G
  let gain_db = vdb(Vout)
  let phase_deg = 180/3.141592653589793 * vp(Vout)
  meas ac voltage_gain find gain_db at=1k
  meas ac unity_gain_frequency when gain_db=0 fall=1
  meas ac phase_at_ugf find phase_deg when gain_db=0 fall=1
  let phase_margin = phase_at_ugf + 180
  print voltage_gain unity_gain_frequency phase_margin

  * Transient Analysis for Slew Rate
  tran 0.1n 300n
  meas tran t_diff trig v(Vout) val=0.6 rise=1 targ v(Vout) val=1.2 rise=1
  let slew_rate = 0.6 / (t_diff * 1e6)
  print slew_rate

  * AC Analysis for Output Resistance
  alter Vs ac=0
  alter Iout ac=1
  ac dec 10 1 100
  let rout = abs(v(Vout))
  meas ac output_resistance find rout at=10
  print output_resistance

  quit
.endc
.end