* GE Folded Cascode Op-Amp Testbench
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
.param L_xm2=0.5
.param L_xm20=0.5
.param L_xm21=0.5
.param L_xm24=0.5
.param L_xm26=0.5
.param L_xm29=0.5
.param L_xm3=0.5
.param L_xm31=0.5
.param L_xm33=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xmfcnl1=0.5
.param L_xmfcnr1=0.5
.param L_xmfcpl1=0.5
.param L_xmfcpr1=0.5
.param L_xmon1=0.5
.param L_xmop1=0.5
.param W_xm10=5.0
.param W_xm11=5.0
.param W_xm12=5.0
.param W_xm13=5.0
.param W_xm14=5.0
.param W_xm15=5.0
.param W_xm16=5.0
.param W_xm17=5.0
.param W_xm2=5.0
.param W_xm20=5.0
.param W_xm21=5.0
.param W_xm24=5.0
.param W_xm26=5.0
.param W_xm29=5.0
.param W_xm3=5.0
.param W_xm31=5.0
.param W_xm33=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm9=5.0
.param W_xmfcnl1=5.0
.param W_xmfcnr1=5.0
.param W_xmfcpl1=5.0
.param W_xmfcpr1=5.0
.param W_xmon1=5.0
.param W_xmop1=5.0

* Define dummy parameters for parameterized W/L to ensure compilation
.param W_xm1=5 L_xm1=1 W_xm2=5 L_xm2=1 W_xm3=5 L_xm3=1 W_xm4=5 L_xm4=1 W_xm5=5 L_xm5=1 W_xm6=5 L_xm6=1 W_xm7=5 L_xm7=1 W_xm8=5 L_xm8=1 W_xm9=5 L_xm9=1 W_xm10=5 L_xm10=1 W_xm11=5 L_xm11=1 W_xm12=5 L_xm12=1 W_xm13=5 L_xm13=1 W_xm14=5 L_xm14=1 W_xm15=5 L_xm15=1 W_xm16=5 L_xm16=1 W_xmfcpl1=5 L_xmfcpl1=1 W_xmfcpr1=5 L_xmfcpr1=1 W_xmfcnr1=5 L_xmfcnr1=1 W_xmfcnl1=5 L_xmfcnl1=1 W_xmop1=20 L_xmop1=1 W_xmon1=10 L_xmon1=1 W_xm17=5 L_xm17=1 W_xm20=5 L_xm20=1 W_xm21=5 L_xm21=1 W_xm24=5 L_xm24=1 W_xm26=5 L_xm26=1 W_xm29=5 L_xm29=1 W_xm31=5 L_xm31=1 W_xm33=5 L_xm33=1

* Include DUT
VDD VDD 0 1.8
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
R1 Vm Vin 10000.0
R2 Vm Vout 10000.0
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
xm17 N010 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm17} l={L_xm17}
xm18 N009 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm17} l={L_xm17}
xm19 N011 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm17} l={L_xm17}
xm20 0 pp N010 VDD sky130_fd_pr__pfet_01v8 w={W_xm20} l={L_xm20}
xm21 N015 N010 N009 VDD sky130_fd_pr__pfet_01v8 w={W_xm21} l={L_xm21}
xm22 0 pm N011 VDD sky130_fd_pr__pfet_01v8 w={W_xm20} l={L_xm20}
xm23 pout N011 N009 VDD sky130_fd_pr__pfet_01v8 w={W_xm21} l={L_xm21}
xm24 pout N015 0 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
xm25 N015 N015 0 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
xm26 N013 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm26} l={L_xm26}
xm27 N014 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm26} l={L_xm26}
xm28 N012 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm26} l={L_xm26}
xm29 VDD np N012 0 sky130_fd_pr__nfet_01v8 w={W_xm29} l={L_xm29}
xm30 VDD nm N013 0 sky130_fd_pr__nfet_01v8 w={W_xm29} l={L_xm29}
xm31 N008 N012 N014 0 sky130_fd_pr__nfet_01v8 w={W_xm31} l={L_xm31}
xm32 nout N013 N014 0 sky130_fd_pr__nfet_01v8 w={W_xm31} l={L_xm31}
xm33 nout N008 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm33} l={L_xm33}
xm34 N008 N008 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm33} l={L_xm33}

.subckt SUB_1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w=2 l=1
  xmsu1 N002 N003 0 0 sky130_fd_pr__nfet_01v8 w=2 l=1
  xmsu3 Vbiasp N002 N003 0 sky130_fd_pr__nfet_01v8 w=2 l=1
  xm3 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w=2 l=1
  xm4 N004 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w=2 l=1
  xm1 N003 N003 0 0 sky130_fd_pr__nfet_01v8 w=2 l=1
  xm2 N004 N004 N005 0 sky130_fd_pr__nfet_01v8 w=2 l=1
  R1 N005 GND 5.5k
  xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w=2 l=1
  xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w=2 l=1
  xm5 N001 N004 0 0 sky130_fd_pr__nfet_01v8 w=2 l=1
  xm6 Vbiasp N003 0 0 sky130_fd_pr__nfet_01v8 w=2 l=1
  xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w=2 l=1
  xma1 Vbias3 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w=2 l=1
  xma2 Vbias4 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w=2 l=1
  xmsu4 Vbias3 Vbias3 0 0 sky130_fd_pr__nfet_01v8 w=2 l=1
  xm8 Vbias4 Vbias3 Vlow 0 sky130_fd_pr__nfet_01v8 w=2 l=1
  xm9 Vlow Vbias4 0 0 sky130_fd_pr__nfet_01v8 w=2 l=1
  xm10 Vpcas Vbias3 N009 0 sky130_fd_pr__nfet_01v8 w=2 l=1
  xm11 N009 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w=2 l=1
  xm12 Vbias2 Vbias3 N010 0 sky130_fd_pr__nfet_01v8 w=2 l=1
  xm13 N010 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w=2 l=1
  xm14 Vbias1 Vbias3 N011 0 sky130_fd_pr__nfet_01v8 w=2 l=1
  xm15 N011 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w=2 l=1
  xma5 Vpcas Vpcas N006 VDD sky130_fd_pr__pfet_01v8 w=2 l=1
  xma6 N006 Vbias2 N007 VDD sky130_fd_pr__pfet_01v8 w=2 l=1
  xma7 N007 N006 VDD VDD sky130_fd_pr__pfet_01v8 w=2 l=1
  xma8 Vbias2 Vbias2 VDD VDD sky130_fd_pr__pfet_01v8 w=2 l=1
  xma9 Vbias1 Vbias2 Vhigh VDD sky130_fd_pr__pfet_01v8 w=2 l=1
  xma10 Vhigh Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w=2 l=1
  xma11 Vncas Vbias2 N008 VDD sky130_fd_pr__pfet_01v8 w=2 l=1
  xma12 N008 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w=2 l=1
  xm16 Vncas Vncas N012 0 sky130_fd_pr__nfet_01v8 w=2 l=1
  xm17 N012 Vbias3 P001 0 sky130_fd_pr__nfet_01v8 w=2 l=1
  xm18 P001 N012 0 0 sky130_fd_pr__nfet_01v8 w=2 l=1
.ends SUB_1

* Stimulus
Vvp vp 0 DC 0.9
Vin Vin 0 DC 0.9 AC 1 PULSE(0.8 1.0 10n 1n 1n 500n 1u)

.control
  * DC Operating Point
  op
  let power = -i(VDD) * 1.8
  print power

  * AC Analysis for Open-Loop Characteristics (measured in closed-loop)
  ac dec 100 1 1G
  * A_OL = - Vout / Vm (since Vp is AC ground)
  let mag_Vout = mag(v(Vout))
  let mag_Vm = mag(v(Vm))
  let gain_mag = mag_Vout / mag_Vm
  let gain_db = 20 * log10(gain_mag)
  * Phase margin is directly the phase difference between Vout and Vm
  let phase_deg = 180/PI * (cph(v(Vout)) - cph(v(Vm)))
  
  meas ac dc_gain find gain_db at=10
  meas ac f_un when gain_db=0 fall=1
  meas ac pm find phase_deg when gain_db=0 fall=1

  * Transient Analysis for Slew Rate
  tran 1n 1.5u
  * Measure falling edge (Vin goes 0.8->1.0, Vout goes 1.0->0.8)
  meas tran t_fall trig v(Vout) val=0.95 fall=1 targ v(Vout) val=0.85 fall=1
  * Measure rising edge (Vin goes 1.0->0.8, Vout goes 0.8->1.0)
  meas tran t_rise trig v(Vout) val=0.85 rise=1 targ v(Vout) val=0.95 rise=1
  
  let sr_fall_V_us = 0.1 / (t_fall * 1e6)
  let sr_rise_V_us = 0.1 / (t_rise * 1e6)
  print sr_fall_V_us sr_rise_V_us
  quit
.endc
.end