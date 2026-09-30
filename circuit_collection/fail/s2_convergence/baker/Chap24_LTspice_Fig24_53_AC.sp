* Testbench for Gain-Enhanced Folded-Cascode Op-Amp
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
.param L_xm2=0.5
.param L_xm20=0.5
.param L_xm21=0.5
.param L_xm22=0.5
.param L_xm23=0.5
.param L_xm24=0.5
.param L_xm25=0.5
.param L_xm26=0.5
.param L_xm3=0.5
.param L_xm3lb=0.5
.param L_xm3lt=0.5
.param L_xm3rb=0.5
.param L_xm3rt=0.5
.param L_xm4=0.5
.param L_xm4_b=0.5
.param L_xm5=0.5
.param L_xm5_b=0.5
.param L_xm5l=0.5
.param L_xm5r=0.5
.param L_xm6=0.5
.param L_xm6_b=0.5
.param L_xm6l=0.5
.param L_xm6r=0.5
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
.param L_xmfcnl=0.5
.param L_xmfcnr=0.5
.param L_xmfcpl=0.5
.param L_xmfcpr=0.5
.param L_xmon=0.5
.param L_xmop=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param L_xmsu4=0.5

* Parameter definitions for device sizes
.param W_xm6r=5.0 L_xm6r=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3rt=2.5 L_xm3rt=0.5
.param W_xm3rb=2.5 L_xm3rb=0.5
.param W_xm3lt=2.5 L_xm3lt=0.5
.param W_xm3lb=2.5 L_xm3lb=0.5
.param W_xm10=2.5 L_xm10=0.5
.param W_xm12=2.5 L_xm12=0.5
.param W_xm9=2.5 L_xm9=0.5
.param W_xm11=2.5 L_xm11=0.5
.param W_xm6l=5.0 L_xm6l=0.5
.param W_xm5l=5.0 L_xm5l=0.5
.param W_xm5r=5.0 L_xm5r=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xmfcpl=2.5 L_xmfcpl=0.5
.param W_xmfcpr=2.5 L_xmfcpr=0.5
.param W_xmfcnr=1.25 L_xmfcnr=0.5
.param W_xmfcnl=1.25 L_xmfcnl=0.5
.param W_xmop=10.0 L_xmop=0.5
.param W_xmon=5.0 L_xmon=0.5

* GE diff-amp parameters
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=2.5 L_xm16=0.5
.param W_xm17=2.5 L_xm17=0.5
.param W_xm18=2.5 L_xm18=0.5
.param W_xm19=2.5 L_xm19=0.5
.param W_xm20=2.5 L_xm20=0.5
.param W_xm21=2.5 L_xm21=0.5
.param W_xm22=2.5 L_xm22=0.5
.param W_xm23=2.5 L_xm23=0.5
.param W_xm24=2.5 L_xm24=0.5
.param W_xm25=5.0 L_xm25=0.5
.param W_xm26=5.0 L_xm26=0.5

* Bias generator parameters
.param W_xmsu2=5.0 L_xmsu2=0.5
.param W_xmsu1=2.5 L_xmsu1=0.5
.param W_xmsu3=2.5 L_xmsu3=0.5
.param W_xmsu4=2.5 L_xmsu4=0.5
.param W_xma1=5.0 L_xma1=0.5
.param W_xma2=5.0 L_xma2=0.5
.param W_xma3=5.0 L_xma3=0.5
.param W_xma4=5.0 L_xma4=0.5
.param W_xma5=5.0 L_xma5=0.5
.param W_xma6=5.0 L_xma6=0.5
.param W_xma7=5.0 L_xma7=0.5
.param W_xma8=5.0 L_xma8=0.5
.param W_xma9=5.0 L_xma9=0.5
.param W_xma10=5.0 L_xma10=0.5
.param W_xma11=5.0 L_xma11=0.5
.param W_xma12=5.0 L_xma12=0.5
.param W_xm1=2.5 L_xm1=0.5
.param W_xm2=10.0 L_xm2=0.5
.param W_xm4_b=5.0 L_xm4_b=0.5
.param W_xm5_b=2.5 L_xm5_b=0.5
.param W_xm6_b=2.5 L_xm6_b=0.5
.param W_xm7_b=5.0 L_xm7_b=0.5
.param W_xm8_b=2.5 L_xm8_b=0.5
.param W_xm9_b=2.5 L_xm9_b=0.5
.param W_xm10_b=2.5 L_xm10_b=0.5
.param W_xm11_b=2.5 L_xm11_b=0.5
.param W_xm12_b=2.5 L_xm12_b=0.5
.param W_xm13_b=2.5 L_xm13_b=0.5
.param W_xm14_b=2.5 L_xm14_b=0.5
.param W_xm15_b=2.5 L_xm15_b=0.5
.param W_xm16_b=2.5 L_xm16_b=0.5
.param W_xm17_b=2.5 L_xm17_b=0.5
.param W_xm18_b=2.5 L_xm18_b=0.5

* Power Supplies
VDD VDD 0 DC 1.8

* Bias Circuit Subcircuit
.subckt SUB_1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 N003 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 N004 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4_b} l={L_xm4_b}
  xm1 N003 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm2 N004 N004 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
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

* Instantiate Bias Circuit
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1

* DUT Circuit
xm6r nm NC_01 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6r} l={L_xm6r}
xm1 np vm N003 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 nm vp N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3rt N003 Vbias3 N007 0 sky130_fd_pr__nfet_01v8 w={W_xm3rt} l={L_xm3rt}
xm3rb N007 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm3rb} l={L_xm3rb}
xm3lt N003 Vbias3 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm3lt} l={L_xm3lt}
xm3lb N006 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm3lb} l={L_xm3lb}
xm10 N005 pout pm 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
xm12 pm N004 0 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
xm9 N004 Vbias3 pp 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm11 pp N004 0 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
xm6l nm N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6l} l={L_xm6l}
xm5l np N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5l} l={L_xm5l}
xm5r np N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5r} l={L_xm5r}
xm8 N002 nout nm VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
xm7 N001 Vbias2 np VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
Cload Vout 0 1e-12
xmfcpl N004 Vpcas N001 VDD sky130_fd_pr__pfet_01v8 w={W_xmfcpl} l={L_xmfcpl}
xmfcpr N005 Vpcas N002 VDD sky130_fd_pr__pfet_01v8 w={W_xmfcpr} l={L_xmfcpr}
xmfcnr N002 Vncas N005 0 sky130_fd_pr__nfet_01v8 w={W_xmfcnr} l={L_xmfcnr}
xmfcnl N001 Vncas N004 0 sky130_fd_pr__nfet_01v8 w={W_xmfcnl} l={L_xmfcnl}
xmop Vout N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmop} l={L_xmop}
xmon Vout N005 0 0 sky130_fd_pr__nfet_01v8 w={W_xmon} l={L_xmon}
Cc Vout pm 2.4e-13

* AC Open-Loop Feedback Network
Cbig1 vm 0 0.0001
Rbig1 vm Vout 100000000.0

* Gain-Enhancement Diff-Amps (Fig. 24.50)
xm3 N010 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 N009 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm5 N011 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
xm6 0 pp N010 VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
xm13 N015 N010 N009 VDD sky130_fd_pr__pfet_01v8 w={W_xm13} l={L_xm13}
xm14 0 pm N011 VDD sky130_fd_pr__pfet_01v8 w={W_xm14} l={L_xm14}
xm15 pout N011 N009 VDD sky130_fd_pr__pfet_01v8 w={W_xm15} l={L_xm15}
xm16 pout N015 0 0 sky130_fd_pr__nfet_01v8 w={W_xm16} l={L_xm16}
xm17 N015 N015 0 0 sky130_fd_pr__nfet_01v8 w={W_xm17} l={L_xm17}
xm18 N013 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm18} l={L_xm18}
xm19 N014 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm19} l={L_xm19}
xm20 N012 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm20} l={L_xm20}
xm21 VDD np N012 0 sky130_fd_pr__nfet_01v8 w={W_xm21} l={L_xm21}
xm22 VDD nm N013 0 sky130_fd_pr__nfet_01v8 w={W_xm22} l={L_xm22}
xm23 N008 N012 N014 0 sky130_fd_pr__nfet_01v8 w={W_xm23} l={L_xm23}
xm24 nout N013 N014 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
xm25 nout N008 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm25} l={L_xm25}
xm26 N008 N008 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm26} l={L_xm26}
C1 nout 0 2.4e-13
C2 pout 0 2.4e-13

* AC Input Source (Common-mode DC = 0.9V)
Vin vp 0 DC 0.9 AC 1.0

.control
* Run Operating Point Analysis
op
let p_diss = -i(VDD) * 1.8
print p_diss

* Run AC Analysis
ac dec 100 1k 1G

let gain_db = vdb(Vout)
let phase_deg = 180 + (180 / PI) * cph(v(Vout))
let ge_gain_db = vdb(nout) - vdb(nm)

meas ac a_oldc_ge find gain_db at=1k
meas ac f_unity when gain_db=0 fall=1
meas ac pm find phase_deg when gain_db=0 fall=1
meas ac a_ge find ge_gain_db at=1k

print a_oldc_ge f_unity pm a_ge

quit
.endc
.end
