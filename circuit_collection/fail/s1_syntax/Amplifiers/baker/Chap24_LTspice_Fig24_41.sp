* Testbench for Baker Fig. 24.29 CMOS Op-Amp with Output Buffer
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
.param L_xm31=0.5
.param L_xm4=0.5
.param L_xm41=0.5
.param L_xm5=0.5
.param L_xm51=0.5
.param L_xm6=0.5
.param L_xm6b=0.5
.param L_xm6lb=0.5
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
.param L_xmfcn=0.5
.param L_xmfcp=0.5
.param L_xmon=0.5
.param L_xmop=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param L_xmsu4=0.5

* Parameter values
.param W_xm1=10.0 L_xm1=0.5
.param W_xm2=10.0 L_xm2=0.5
.param W_xm3=20.0 L_xm3=0.5
.param W_xm4=20.0 L_xm4=0.5
.param W_xm31=20.0 L_xm31=0.5
.param W_xm41=20.0 L_xm41=0.5
.param W_xm6=15.0 L_xm6=0.5
.param W_xm6b=15.0 L_xm6b=0.5
.param W_xm6lb=15.0 L_xm6lb=0.5
.param W_xm8=15.0 L_xm8=0.5
.param W_xm9=10.0 L_xm9=0.5
.param W_xm10=10.0 L_xm10=0.5
.param W_xm11=20.0 L_xm11=0.5
.param W_xm12=20.0 L_xm12=0.5
.param W_xm13=20.0 L_xm13=0.5
.param W_xm14=20.0 L_xm14=0.5
.param W_xm5=10.0 L_xm5=0.5
.param W_xm51=10.0 L_xm51=0.5
.param W_xmop=50.0 L_xmop=0.5
.param W_xmon=25.0 L_xmon=0.5
.param W_xmfcn=5.0 L_xmfcn=0.5
.param W_xmfcp=10.0 L_xmfcp=0.5
.param W_xmsu1=5.0 L_xmsu1=0.5
.param W_xmsu2=10.0 L_xmsu2=0.5
.param W_xmsu3=5.0 L_xmsu3=0.5
.param W_xmsu4=5.0 L_xmsu4=0.5
.param W_xm7=10.0 L_xm7=0.5
.param W_xma1=10.0 L_xma1=0.5
.param W_xma2=10.0 L_xma2=0.5
.param W_xma3=10.0 L_xma3=0.5
.param W_xma4=10.0 L_xma4=0.5
.param W_xma5=10.0 L_xma5=0.5
.param W_xma6=10.0 L_xma6=0.5
.param W_xma7=10.0 L_xma7=0.5
.param W_xma8=10.0 L_xma8=0.5
.param W_xma9=10.0 L_xma9=0.5
.param W_xma10=10.0 L_xma10=0.5
.param W_xma11=10.0 L_xma11=0.5
.param W_xma12=10.0 L_xma12=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm18=5.0 L_xm18=0.5

* DUT Instance
VDD VDD 0 1.8
xm2 N002 vm N008 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 vp N008 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm3 N003 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xm6b N012 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6b} l={L_xm6b}
xm51 N014 N010 0 0 sky130_fd_pr__nfet_01v8 w={W_xm51} l={L_xm51}
xm4 N006 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm5 N013 N010 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
CL Vout 0 1e-12
xm31 N004 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm31} l={L_xm31}
xm41 N005 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm41} l={L_xm41}
xm6 N008 Vbias3 N012 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm6lb N011 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6lb} l={L_xm6lb}
xm8 N008 Vbias3 N011 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
xm9 N010 Vbias3 N014 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm10 N009 Vbias3 N013 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
xm11 N010 Vbias2 N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
xm12 N007 Vbias2 N006 VDD sky130_fd_pr__pfet_01v8 w={W_xm12} l={L_xm12}
xm13 N001 Vbias2 N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm13} l={L_xm13}
xm14 N002 Vbias2 N005 VDD sky130_fd_pr__pfet_01v8 w={W_xm14} l={L_xm14}
xmop Vout N007 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmop} l={L_xmop}
xmon Vout N009 0 0 sky130_fd_pr__nfet_01v8 w={W_xmon} l={L_xmon}
xmfcn N007 Vncas N009 0 sky130_fd_pr__nfet_01v8 w={W_xmfcn} l={L_xmfcn}
Cc Vout N013 2.4e-13
R1 Vm Vin 10000.0
R2 Vm Vout 10000.0
xmfcp N009 Vpcas N007 VDD sky130_fd_pr__pfet_01v8 w={W_xmfcp} l={L_xmfcp}

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

* Sources for Common-Mode and Signal Inputs
Vcm vp 0 DC 0.9
Vin_src Vin 0 DC 0.9 AC 1 PULSE(0.5 1.3 10n 1n 1n 40n 100n)

.control
* 1. Operating Point
op
let p_dc = -i(VDD) * 1.8
print p_dc

* 2. AC Analysis (Open-loop and Closed-loop response)
ac dec 100 10 1G
let vdiff = v(vp) - v(vm)
let a_ol = v(Vout) / vdiff
let a_ol_db = 20 * log10(abs(a_ol))
let a_ol_ph = 180 / PI * cph(a_ol)
let a_cl_db = vdb(Vout)

meas ac a_oldc find a_ol_db at=100
meas ac f_3db when a_ol_db='a_oldc-3' fall=1
meas ac fun when a_ol_db=0 fall=1
meas ac ph_fun find a_ol_ph when a_ol_db=0 fall=1
let pm = 180 + ph_fun
print pm

meas ac acl_dc find a_cl_db at=100
meas ac f_3db_cl when a_cl_db='acl_dc-3' fall=1

* 3. Transient Step Response (Large Signal)
tran 0.1n 120n
meas tran vout_max max v(Vout) from=10n to=50n
meas tran vout_min min v(Vout) from=55n to=95n
let vout_swing = vout_max - vout_min
print vout_swing

meas tran t_r10 when v(Vout)=0.58 rise=1
meas tran t_r90 when v(Vout)=1.22 rise=1
let sr_rise = (1.22 - 0.58) / (t_r90 - t_r10) * 1e-6
print sr_rise

meas tran t_f90 when v(Vout)=1.22 fall=1
meas tran t_f10 when v(Vout)=0.58 fall=1
let sr_fall = (1.22 - 0.58) / (t_f10 - t_f90) * 1e-6
print sr_fall

quit
.endc
.end
