* Testbench for Baker Fig. 24.48 Rail-to-Rail Op-Amp
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm10_b=0.5
.param L_xm11=0.5
.param L_xm11_b=0.5
.param L_xm12=0.5
.param L_xm12_b=0.5
.param L_xm13=0.5
.param L_xm13_b=0.5
.param L_xm14=0.5
.param L_xm14_b=0.5
.param L_xm15=0.5
.param L_xm15_b=0.5
.param L_xm16=0.5
.param L_xm16_b=0.5
.param L_xm17=0.5
.param L_xm17_b=0.5
.param L_xm18=0.5
.param L_xm18_b=0.5
.param L_xm19=0.5
.param L_xm1_b=0.5
.param L_xm2=0.5
.param L_xm20=0.5
.param L_xm21=0.5
.param L_xm22=0.5
.param L_xm23=0.5
.param L_xm24=0.5
.param L_xm2_b=0.5
.param L_xm3=0.5
.param L_xm3_b=0.5
.param L_xm4=0.5
.param L_xm4_b=0.5
.param L_xm5=0.5
.param L_xm5_b=0.5
.param L_xm6=0.5
.param L_xm6_b=0.5
.param L_xm7=0.5
.param L_xm7_b=0.5
.param L_xm8=0.5
.param L_xm8_b=0.5
.param L_xm9=0.5
.param L_xm9_b=0.5
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

* Parameter definitions for Sky130 transistors
.param Lmin=0.15u
.param W_xm1=15.0 L_xm1=0.15
.param W_xm2=7.5 L_xm2=0.15
.param W_xm3=7.5 L_xm3=0.15
.param W_xm4=7.5 L_xm4=0.15
.param W_xm5=7.5 L_xm5=0.15
.param W_xm6=7.5 L_xm6=0.15
.param W_xm7=7.5 L_xm7=0.15
.param W_xm8=7.5 L_xm8=0.15
.param W_xm9=7.5 L_xm9=0.15
.param W_xm10=7.5 L_xm10=0.15
.param W_xm11=7.5 L_xm11=0.15
.param W_xm12=15.0 L_xm12=0.15
.param W_xm13=15.0 L_xm13=0.15
.param W_xm14=15.0 L_xm14=0.15
.param W_xm15=7.5 L_xm15=0.15
.param W_xm16=7.5 L_xm16=0.15
.param W_xm17=15.0 L_xm17=0.15
.param W_xm18=15.0 L_xm18=0.15
.param W_xm19=7.5 L_xm19=0.15
.param W_xm20=7.5 L_xm20=0.15
.param W_xm21=15.0 L_xm21=0.15
.param W_xm22=15.0 L_xm22=0.15
.param W_xm23=7.5 L_xm23=0.15
.param W_xm24=7.5 L_xm24=0.15
.param W_xmfcpl1=7.5 L_xmfcpl1=0.15
.param W_xmfcpr1=7.5 L_xmfcpr1=0.15
.param W_xmfcnr1=3.75 L_xmfcnr1=0.15
.param W_xmfcnl1=3.75 L_xmfcnl1=0.15
.param W_xmop1=150.0 L_xmop1=0.15
.param W_xmon1=75.0 L_xmon1=0.15

* Bias generator parameters (SUB_1)
.param W_xmsu1=7.5 L_xmsu1=0.15
.param W_xmsu2=15.0 L_xmsu2=0.15
.param W_xmsu3=7.5 L_xmsu3=0.15
.param W_xmsu4=7.5 L_xmsu4=0.15
.param W_xm1_b=7.5 L_xm1_b=0.15
.param W_xm2_b=7.5 L_xm2_b=0.15
.param W_xm3_b=15.0 L_xm3_b=0.15
.param W_xm4_b=15.0 L_xm4_b=0.15
.param W_xm5_b=7.5 L_xm5_b=0.15
.param W_xm6_b=7.5 L_xm6_b=0.15
.param W_xm7_b=15.0 L_xm7_b=0.15
.param W_xm8_b=7.5 L_xm8_b=0.15
.param W_xm9_b=7.5 L_xm9_b=0.15
.param W_xm10_b=7.5 L_xm10_b=0.15
.param W_xm11_b=7.5 L_xm11_b=0.15
.param W_xm12_b=7.5 L_xm12_b=0.15
.param W_xm13_b=7.5 L_xm13_b=0.15
.param W_xm14_b=7.5 L_xm14_b=0.15
.param W_xm15_b=7.5 L_xm15_b=0.15
.param W_xm16_b=7.5 L_xm16_b=0.15
.param W_xm17_b=7.5 L_xm17_b=0.15
.param W_xm18_b=7.5 L_xm18_b=0.15
.param W_xma1=15.0 L_xma1=0.15
.param W_xma2=15.0 L_xma2=0.15
.param W_xma3=15.0 L_xma3=0.15
.param W_xma4=15.0 L_xma4=0.15
.param W_xma5=15.0 L_xma5=0.15
.param W_xma6=15.0 L_xma6=0.15
.param W_xma7=15.0 L_xma7=0.15
.param W_xma8=15.0 L_xma8=0.15
.param W_xma9=15.0 L_xma9=0.15
.param W_xma10=15.0 L_xma10=0.15
.param W_xma11=15.0 L_xma11=0.15
.param W_xma12=15.0 L_xma12=0.15

* Power Supplies
VDD VDD 0 1.8

* DUT Circuit
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xm1 N003 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
xm2 N002 vout N008 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 N003 vin N008 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 N008 Vbias3 N014 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm5 N014 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 N008 Vbias3 N013 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 N013 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
xm8 N010 Vbias3 N011 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
xm9 N011 N009 0 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm10 N009 Vbias3 N012 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
xm11 N012 N009 0 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
xm12 N003 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm12} l={L_xm12}
xm13 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm13} l={L_xm13}
xm14 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm14} l={L_xm14}
xm15 N004 Vbias2 N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm15} l={L_xm15}
xm16 N001 Vbias2 N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm16} l={L_xm16}
Cload1 Vout 0 1e-11
xmfcpl1 N009 Vpcas N001 VDD sky130_fd_pr__pfet_01v8 w={W_xmfcpl1} l={L_xmfcpl1}
xmfcpr1 N010 Vpcas N004 VDD sky130_fd_pr__pfet_01v8 w={W_xmfcpr1} l={L_xmfcpr1}
xmfcnr1 N004 Vncas N010 0 sky130_fd_pr__nfet_01v8 w={W_xmfcnr1} l={L_xmfcnr1}
xmfcnl1 N001 Vncas N009 0 sky130_fd_pr__nfet_01v8 w={W_xmfcnl1} l={L_xmfcnl1}
xmop1 Vout N004 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmop1} l={L_xmop1}
xmon1 Vout N010 0 0 sky130_fd_pr__nfet_01v8 w={W_xmon1} l={L_xmon1}
Cc1 Vout N011 2.4e-13
xm17 N005 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm17} l={L_xm17}
xm18 N006 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm18} l={L_xm18}
xm19 N007 Vbias2 N005 VDD sky130_fd_pr__pfet_01v8 w={W_xm19} l={L_xm19}
xm20 N007 Vbias2 N006 VDD sky130_fd_pr__pfet_01v8 w={W_xm20} l={L_xm20}
xm21 N012 vout N007 VDD sky130_fd_pr__pfet_01v8 w={W_xm21} l={L_xm21}
xm22 N011 vin N007 VDD sky130_fd_pr__pfet_01v8 w={W_xm22} l={L_xm22}
xm23 N012 N009 0 0 sky130_fd_pr__nfet_01v8 w={W_xm23} l={L_xm23}
xm24 N011 N009 0 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
R1 Vout 0 1000.0

* Subcircuit definition for bias circuit
.subckt SUB_1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 N003 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3_b} l={L_xm3_b}
  xm4 N004 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4_b} l={L_xm4_b}
  xm1 N003 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1_b} l={L_xm1_b}
  xm2 N004 N004 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm2_b} l={L_xm2_b}
  R1 N005 GND 5.5k
  xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm5 N001 N004 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5_b} l={L_xm5_b}
  xm6 Vbiasp N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6_b} l={L_xm6_b}
  xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7_b} l={L_xm7_b}
  xma1 Vbias3 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma1} l={L_xma1}
  xma2 Vbias4 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma2} l={L_xma2}
  xmsu4 Vbias3 Vbias3 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu4} l={L_xmsu4}
  xm8 Vbias4 Vbias3 Vlow 0 sky130_fd_pr__nfet_01v8 w={W_xm8_b} l={L_xm8_b}
  xm9 Vlow Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm9_b} l={L_xm9_b}
  xm10 Vpcas Vbias3 N009 0 sky130_fd_pr__nfet_01v8 w={W_xm10_b} l={L_xm10_b}
  xm11 N009 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm11_b} l={L_xm11_b}
  xm12 Vbias2 Vbias3 N010 0 sky130_fd_pr__nfet_01v8 w={W_xm12_b} l={L_xm12_b}
  xm13 N010 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm13_b} l={L_xm13_b}
  xm14 Vbias1 Vbias3 N011 0 sky130_fd_pr__nfet_01v8 w={W_xm14_b} l={L_xm14_b}
  xm15 N011 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm15_b} l={L_xm15_b}
  xma5 Vpcas Vpcas N006 VDD sky130_fd_pr__pfet_01v8 w={W_xma5} l={L_xma5}
  xma6 N006 Vbias2 N007 VDD sky130_fd_pr__pfet_01v8 w={W_xma6} l={L_xma6}
  xma7 N007 N006 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma7} l={L_xma7}
  xma8 Vbias2 Vbias2 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma8} l={L_xma8}
  xma9 Vbias1 Vbias2 Vhigh VDD sky130_fd_pr__pfet_01v8 w={W_xma9} l={L_xma9}
  xma10 Vhigh Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma10} l={L_xma10}
  xma11 Vncas Vbias2 N008 VDD sky130_fd_pr__pfet_01v8 w={W_xma11} l={L_xma11}
  xma12 N008 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma12} l={L_xma12}
  xm16 Vncas Vncas N012 0 sky130_fd_pr__nfet_01v8 w={W_xm16_b} l={L_xm16_b}
  xm17 N012 Vbias3 P001 0 sky130_fd_pr__nfet_01v8 w={W_xm17_b} l={L_xm17_b}
  xm18 P001 N012 0 0 sky130_fd_pr__nfet_01v8 w={W_xm18_b} l={L_xm18_b}
.ends SUB_1

* Signal source for transient follower test (Fig. 24.49: 100 mV to 900 mV pulse)
Vin_src vin 0 pulse(0.1 0.9 505n 1n 1n 40n 100n) dc 0.9 ac 1

.control
* 1. Operating point
op
let idd_tot = -i(VDD)
print idd_tot

* 2. AC Analysis for open loop gain and phase margin
ac dec 100 1k 2G
let aol_db = vdb(vout)
let phase = 180 / PI * cph(v(vout))

meas ac gain_dc find aol_db at=1k
meas ac f_ugb when aol_db=0 fall=1
meas ac phase_ugb find phase when aol_db=0 fall=1
let pm = 180 + phase_ugb
print gain_dc f_ugb pm

* 3. Transient Analysis (Baker simulation: .tran 0 600n 500n uic)
tran 0.1n 600n 500n
meas tran v_max max v(vout)
meas tran v_min min v(vout)
meas tran t_rise trig v(vout) val=0.18 rise=1 targ v(vout) val=0.82 rise=1
meas tran t_fall trig v(vout) val=0.82 fall=1 targ v(vout) val=0.18 fall=1
let sr_rise = (0.82 - 0.18) / (t_rise * 1e6)
let sr_fall = (0.82 - 0.18) / (t_fall * 1e6)
print sr_rise sr_fall

quit
.endc
.end