* Testbench for Baker Fig 24.21 Indirect Compensation Op-Amp
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
.param L_xm3b=0.5
.param L_xm3t=0.5
.param L_xm4=0.5
.param L_xm4b=0.5
.param L_xm4t=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm6b=0.5
.param L_xm6t=0.5
.param L_xm7=0.5
.param L_xm7b=0.5
.param L_xm7t=0.5
.param L_xm8=0.5
.param L_xm8b=0.5
.param L_xm8t=0.5
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

* Parameters from Table 9.2 / Figure 24.21
.param W_xm1=50.0   L_xm1=2.0
.param W_xm2=50.0   L_xm2=2.0
.param W_xm3t=100.0 L_xm3t=1.0
.param W_xm3b=100.0 L_xm3b=1.0
.param W_xm4t=100.0 L_xm4t=1.0
.param W_xm4b=100.0 L_xm4b=1.0
.param W_xm6t=100.0 L_xm6t=2.0
.param W_xm6b=100.0 L_xm6b=2.0
.param W_xm7t=100.0 L_xm7t=1.0
.param W_xm7b=100.0 L_xm7b=1.0
.param W_xm8t=50.0  L_xm8t=2.0
.param W_xm8b=50.0  L_xm8b=2.0

* Bias generator parameters (Fig. 20.47)
.param W_xmsu1=50.0 L_xmsu1=2.0
.param W_xmsu2=50.0 L_xmsu2=2.0
.param W_xmsu3=50.0 L_xmsu3=2.0
.param W_xmsu4=50.0 L_xmsu4=2.0
.param W_xm3=100.0  L_xm3=2.0
.param W_xm4=100.0  L_xm4=2.0
.param W_xm1_sub=50.0 L_xm1_sub=2.0
.param W_xm2_sub=50.0 L_xm2_sub=2.0
.param W_xma4=100.0 L_xma4=2.0
.param W_xma3=100.0 L_xma3=2.0
.param W_xm5=50.0   L_xm5=2.0
.param W_xm6=50.0   L_xm6=2.0
.param W_xm7=100.0  L_xm7=2.0
.param W_xma1=100.0 L_xma1=2.0
.param W_xma2=100.0 L_xma2=2.0
.param W_xm8=50.0   L_xm8=2.0
.param W_xm9=50.0   L_xm9=2.0
.param W_xm10=50.0  L_xm10=2.0
.param W_xm11=50.0  L_xm11=2.0
.param W_xm12=50.0  L_xm12=2.0
.param W_xm13=50.0  L_xm13=2.0
.param W_xm14=50.0  L_xm14=2.0
.param W_xm15=50.0  L_xm15=2.0
.param W_xma5=100.0 L_xma5=2.0
.param W_xma6=100.0 L_xma6=2.0
.param W_xma7=100.0 L_xma7=2.0
.param W_xma8=100.0 L_xma8=2.0
.param W_xma9=100.0 L_xma9=2.0
.param W_xma10=100.0 L_xma10=2.0
.param W_xma11=100.0 L_xma11=2.0
.param W_xma12=100.0 L_xma12=2.0
.param W_xm16=50.0  L_xm16=2.0
.param W_xm17=50.0  L_xm17=2.0
.param W_xm18=50.0  L_xm18=2.0

* DUT Instance
VDD VDD 0 1.8
Vinp vp 0 DC 0.7 AC 1 PULSE(0.5 0.9 500n 1n 1n 200n 1u)

xm2 N002 vp N006 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 vm N006 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4t N003 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4t} l={L_xm4t}
xm3t N004 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3t} l={L_xm3t}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xm6t N006 Vbias3 N007 0 sky130_fd_pr__nfet_01v8 w={W_xm6t} l={L_xm6t}
xm6b N007 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6b} l={L_xm6b}
xm7b vout N002 N005 VDD sky130_fd_pr__pfet_01v8 w={W_xm7b} l={L_xm7b}
xm8t vout Vbias3 N008 0 sky130_fd_pr__nfet_01v8 w={W_xm8t} l={L_xm8t}
xm8b N008 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8b} l={L_xm8b}
Cc vout N003 2.4e-13
C3 vout 0 1e-13
xm4b N002 N001 N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm4b} l={L_xm4b}
xm3b N001 N001 N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm3b} l={L_xm3b}
xm7t N005 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7t} l={L_xm7t}
C1 vm 0 1e-05
R1 vm vout 100000000.0

.subckt SUB_1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 N003 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 N004 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
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
* 1. Operating Point Analysis
op
let pwr = -i(vdd) * 1.8
print pwr

* 2. AC Analysis for Gain, fun, and Phase Margin
ac dec 100 1k 1G
let aol_db = vdb(vout)
let phase = 180/PI * cph(v(vout))

meas ac open_loop_gain find aol_db at=1k
meas ac unity_gain_frequency when aol_db=0 fall=1
meas ac phase_at_unity find phase when aol_db=0 fall=1
let pm = 180 + phase_at_unity
print pm
meas ac gain_margin find aol_db when phase=-180 fall=1

* 3. Transient Analysis for Step Response & Slew Rate
tran 0.5n 1u
meas tran v_init find v(vout) at=490n
meas tran v_peak max v(vout) from=500n to=700n
meas tran sr_pos max deriv(v(vout)) from=500n to=600n
meas tran sr_neg min deriv(v(vout)) from=700n to=800n
print sr_pos sr_neg

quit
.endc
.end
