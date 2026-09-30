* Differential Amplifier Testbench with Current Mirror Load
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
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm6b=0.5
.param L_xm6t=0.5
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
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param L_xmsu4=0.5

* Parameter defaults
.param W_xm1=10.0 L_xm1=0.5
.param W_xm2=10.0 L_xm2=0.5
.param W_xm3=20.0 L_xm3=0.5
.param W_xm4=20.0 L_xm4=0.5
.param W_xm6t=20.0 L_xm6t=0.5
.param W_xm6b=20.0 L_xm6b=0.5
.param W_xmsu1=5.0 L_xmsu1=0.5
.param W_xmsu2=5.0 L_xmsu2=0.5
.param W_xmsu3=5.0 L_xmsu3=0.5
.param W_xmsu4=5.0 L_xmsu4=0.5
.param W_xm5=10.0 L_xm5=0.5
.param W_xm6=10.0 L_xm6=0.5
.param W_xm7=20.0 L_xm7=0.5
.param W_xm8=10.0 L_xm8=0.5
.param W_xm9=10.0 L_xm9=0.5
.param W_xm10=10.0 L_xm10=0.5
.param W_xm11=10.0 L_xm11=0.5
.param W_xm12=10.0 L_xm12=0.5
.param W_xm13=10.0 L_xm13=0.5
.param W_xm14=10.0 L_xm14=0.5
.param W_xm15=10.0 L_xm15=0.5
.param W_xm16=10.0 L_xm16=0.5
.param W_xm17=10.0 L_xm17=0.5
.param W_xm18=10.0 L_xm18=0.5
.param W_xma1=20.0 L_xma1=0.5
.param W_xma2=20.0 L_xma2=0.5
.param W_xma3=20.0 L_xma3=0.5
.param W_xma4=20.0 L_xma4=0.5
.param W_xma5=20.0 L_xma5=0.5
.param W_xma6=20.0 L_xma6=0.5
.param W_xma7=20.0 L_xma7=0.5
.param W_xma8=20.0 L_xma8=0.5
.param W_xma9=20.0 L_xma9=0.5
.param W_xma10=20.0 L_xma10=0.5
.param W_xma11=20.0 L_xma11=0.5
.param W_xma12=20.0 L_xma12=0.5

* Main Circuit DUT
VDD VDD 0 1.8
xm2 Vout N002 N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 Vin N003 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 Vout N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
VI1 Vin 0 SINE(500m 1m 10MEG)
xm6t N003 Vbias3 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm6t} l={L_xm6t}
xm6b N004 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6b} l={L_xm6b}
VI2 N002 0 500m

* Load capacitance per Ex. 22.6
CL Vout 0 1p

* Bias Circuit Subcircuit
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

.control
* 1. Operating Point Analysis
op
let vout_dc = v(vout)
let idd_tot = -i(vdd)
print vout_dc idd_tot

* 2. Small-Signal AC Analysis
alter @vi1[acmag] = 1
ac dec 100 1k 1G
let gain_db = vdb(vout)
meas ac ad_lf find gain_db at=1k
let gain_3db = ad_lf - 3.0
meas ac f_3db when gain_db=gain_3db fall=1
print ad_lf f_3db

* 3. Transient Analysis (10 MHz sine input)
alter @vi1[acmag] = 0
tran 0.5n 500n 300n
meas tran vout_tran_max max v(vout)
meas tran vout_tran_min min v(vout)
meas tran vout_pp pp v(vout)
print vout_tran_max vout_tran_min vout_pp

* 4. DC Sweep of Input for Output Swing and CM Range
dc VI1 0 1.8 0.005
meas dc vout_max max v(vout)
meas dc vout_min min v(vout)
print vout_max vout_min

quit
.endc
.end