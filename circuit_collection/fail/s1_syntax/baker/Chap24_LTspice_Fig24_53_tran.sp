* Testbench for Folded-Cascode Op-Amp with Class AB Output
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
.param L_xm29=0.5
.param L_xm3=0.5
.param L_xm30=0.5
.param L_xm31=0.5
.param L_xm32=0.5
.param L_xm33=0.5
.param L_xm34=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
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
.param L_xmfcnl1=0.5
.param L_xmfcnr1=0.5
.param L_xmfcpl1=0.5
.param L_xmfcpr1=0.5
.param L_xmon1=0.5
.param L_xmop1=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param L_xmsu4=0.5
.param W_xm1=5.0
.param W_xm10=5.0
.param W_xm11=5.0
.param W_xm12=5.0
.param W_xm13=5.0
.param W_xm14=5.0
.param W_xm15=5.0
.param W_xm16=5.0
.param W_xm17=5.0
.param W_xm18=5.0
.param W_xm19=5.0
.param W_xm2=5.0
.param W_xm20=5.0
.param W_xm21=5.0
.param W_xm22=5.0
.param W_xm23=5.0
.param W_xm24=5.0
.param W_xm25=5.0
.param W_xm26=5.0
.param W_xm27=5.0
.param W_xm28=5.0
.param W_xm29=5.0
.param W_xm3=5.0
.param W_xm30=5.0
.param W_xm31=5.0
.param W_xm32=5.0
.param W_xm33=5.0
.param W_xm34=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm9=5.0
.param W_xma1=5.0
.param W_xma10=5.0
.param W_xma11=5.0
.param W_xma12=5.0
.param W_xma2=5.0
.param W_xma3=5.0
.param W_xma4=5.0
.param W_xma5=5.0
.param W_xma6=5.0
.param W_xma7=5.0
.param W_xma8=5.0
.param W_xma9=5.0
.param W_xmfcnl1=5.0
.param W_xmfcnr1=5.0
.param W_xmfcpl1=5.0
.param W_xmfcpr1=5.0
.param W_xmon1=5.0
.param W_xmop1=5.0
.param W_xmsu1=5.0
.param W_xmsu2=5.0
.param W_xmsu3=5.0
.param W_xmsu4=5.0

* --- DUT Netlist ---
VDD VDD 0 1.8
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
R1 Vm Vin 10000.0
R2 Vm Vout 10000.0
xm17 N010 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm17} l={L_xm17}
xm18 N009 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm18} l={L_xm18}
xm19 N011 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm19} l={L_xm19}
xm20 0 pp N010 VDD sky130_fd_pr__pfet_01v8 w={W_xm20} l={L_xm20}
xm21 N015 N010 N009 VDD sky130_fd_pr__pfet_01v8 w={W_xm21} l={L_xm21}
xm22 0 pm N011 VDD sky130_fd_pr__pfet_01v8 w={W_xm22} l={L_xm22}
xm23 pout N011 N009 VDD sky130_fd_pr__pfet_01v8 w={W_xm23} l={L_xm23}
xm24 pout N015 0 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
xm25 N015 N015 0 0 sky130_fd_pr__nfet_01v8 w={W_xm25} l={L_xm25}
xm26 N013 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm26} l={L_xm26}
xm27 N014 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm27} l={L_xm27}
xm28 N012 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm28} l={L_xm28}
xm29 VDD np N012 0 sky130_fd_pr__nfet_01v8 w={W_xm29} l={L_xm29}
xm30 VDD nm N013 0 sky130_fd_pr__nfet_01v8 w={W_xm30} l={L_xm30}
xm31 N008 N012 N014 0 sky130_fd_pr__nfet_01v8 w={W_xm31} l={L_xm31}
xm32 nout N013 N014 0 sky130_fd_pr__nfet_01v8 w={W_xm32} l={L_xm32}
xm33 nout N008 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm33} l={L_xm33}
xm34 N008 N008 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm34} l={L_xm34}
xm1 nm N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
xm2 np vm N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 nm vp N003 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 N003 Vbias3 N007 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm5 N007 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 N003 Vbias3 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 N006 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
xm8 N005 pout pm 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
xm9 pm N004 0 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm10 N004 Vbias3 pp 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
xm11 pp N004 0 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
xm12 nm N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm12} l={L_xm12}
xm13 np N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm13} l={L_xm13}
xm14 np N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm14} l={L_xm14}
xm15 N002 nout nm VDD sky130_fd_pr__pfet_01v8 w={W_xm15} l={L_xm15}
xm16 N001 Vbias2 np VDD sky130_fd_pr__pfet_01v8 w={W_xm16} l={L_xm16}
Cload1 Vout 0 1e-12
xmfcpl1 N004 Vpcas N001 VDD sky130_fd_pr__pfet_01v8 w={W_xmfcpl1} l={L_xmfcpl1}
xmfcpr1 N005 Vpcas N002 VDD sky130_fd_pr__pfet_01v8 w={W_xmfcpr1} l={L_xmfcpr1}
xmfcnr1 N002 Vncas N005 0 sky130_fd_pr__nfet_01v8 w={W_xmfcnr1} l={L_xmfcnr1}
xmfcnl1 N001 Vncas N004 0 sky130_fd_pr__nfet_01v8 w={W_xmfcnl1} l={L_xmfcnl1}
xmop1 Vout N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmop1} l={L_xmop1}
xmon1 Vout N005 0 0 sky130_fd_pr__nfet_01v8 w={W_xmon1} l={L_xmon1}
Cc1 Vout pm 2.4e-13
C1 nout 0 2.4e-13
C2 pout 0 2.4e-13
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
* --- End of DUT Netlist ---

* Stimulus and Bias
Vvp vp 0 dc 0.9
Vvin Vin 0 dc 0.9 ac 1 pulse(0.1 0.9 10n 1n 1n 200n 400n)

.control
  * 1. DC Operating Point for Power
  op
  let power = -i(VDD) * 1.8
  print power
  let meas_power = power

  * 2. AC Analysis for Open-Loop Gain, Unity-Gain Frequency, and Phase Margin
  ac dec 100 1 1G
  * Vout/Vm gives the negative of the open-loop gain
  let gain_db = vdb(Vout) - vdb(Vm)
  * Phase of Vout/Vm is the phase margin directly (starts at 180 at DC, drops to PM at fun)
  let phase_deg = 180/3.14159265 * (cph(v(Vout)) - cph(v(Vm)))
  
  meas ac Aol_DC find gain_db at=10
  meas ac fun when gain_db=0 fall=1
  meas ac pm find phase_deg when gain_db=0 fall=1

  * 3. Transient Analysis for Slew Rate
  tran 1n 600n
  * Measure falling slew rate (output goes from 1.7V to 0.9V)
  meas tran t1_f when v(Vout)=1.5 fall=1
  meas tran t2_f when v(Vout)=1.1 fall=1
  let sr_fall = (1.5 - 1.1) / (t2_f - t1_f)
  
  * Measure rising slew rate (output goes from 0.9V to 1.7V)
  meas tran t1_r when v(Vout)=1.1 rise=1
  meas tran t2_r when v(Vout)=1.5 rise=1
  let sr_rise = (1.5 - 1.1) / (t2_r - t1_r)
  
  print meas_power Aol_DC fun pm sr_fall sr_rise
  quit
.endc
.end
