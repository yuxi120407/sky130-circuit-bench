* Testbench for Cascode OTA with Class-AB Output Stage (Fig 24.40 / 24.41)
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

* Parameters for Sky130 implementation
.param W_xm1=10.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=10.0 L_xm12=0.5
.param W_xm13=10.0 L_xm13=0.5
.param W_xm14=10.0 L_xm14=0.5
.param W_xm15=10.0 L_xm15=0.5
.param W_xm16=10.0 L_xm16=0.5
.param W_xmfcpl1=5.0 L_xmfcpl1=0.5
.param W_xmfcpr1=5.0 L_xmfcpr1=0.5
.param W_xmfcnr1=2.5 L_xmfcnr1=0.5
.param W_xmfcnl1=2.5 L_xmfcnl1=0.5
.param W_xmop1=10.0 L_xmop1=0.5
.param W_xmon1=5.0 L_xmon1=0.5

* Bias circuit parameters
.param W_xmsu2=5.0 L_xmsu2=0.5
.param W_xmsu1=5.0 L_xmsu1=0.5
.param W_xmsu3=5.0 L_xmsu3=0.5
.param W_xm3=10.0 L_xm3=0.5
.param W_xm4=10.0 L_xm4=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=20.0 L_xm2=0.5
.param W_xma4=10.0 L_xma4=0.5
.param W_xma3=10.0 L_xma3=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=10.0 L_xm7=0.5
.param W_xma1=10.0 L_xma1=0.5
.param W_xma2=10.0 L_xma2=0.5
.param W_xmsu4=5.0 L_xmsu4=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xma5=10.0 L_xma5=0.5
.param W_xma6=10.0 L_xma6=0.5
.param W_xma7=10.0 L_xma7=0.5
.param W_xma8=10.0 L_xma8=0.5
.param W_xma9=10.0 L_xma9=0.5
.param W_xma10=10.0 L_xma10=0.5
.param W_xma11=10.0 L_xma11=0.5
.param W_xma12=10.0 L_xma12=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm18=5.0 L_xm18=0.5

* Power Supplies
VDD VDD 0 1.8
Vcm vp 0 0.9 ac 1
Vin vin 0 dc 0.9 PULSE(0.18 1.62 510n 1n 1n 500n 1000n)

* Bias Generator Subcircuit
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1

* Inverting feedback configuration with load
R1 Vm Vin 10000.0
R2 Vm Vout 10000.0
Cload1 Vout 0 1e-12

* DUT Circuit
xm1 N003 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
xm2 N002 vm N005 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 N003 vp N005 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 N005 Vbias3 N010 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm5 N010 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 N005 Vbias3 N009 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 N009 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
xm8 N007 Vbias3 N008 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
xm9 N008 N006 0 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm10 N006 Vbias3 N011 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
xm11 N011 N006 0 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
xm12 N003 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm12} l={L_xm12}
xm13 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm13} l={L_xm13}
xm14 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm14} l={L_xm14}
xm15 N004 Vbias2 N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm15} l={L_xm15}
xm16 N001 Vbias2 N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm16} l={L_xm16}
xmfcpl1 N006 Vpcas N001 VDD sky130_fd_pr__pfet_01v8 w={W_xmfcpl1} l={L_xmfcpl1}
xmfcpr1 N007 Vpcas N004 VDD sky130_fd_pr__pfet_01v8 w={W_xmfcpr1} l={L_xmfcpr1}
xmfcnr1 N004 Vncas N007 0 sky130_fd_pr__nfet_01v8 w={W_xmfcnr1} l={L_xmfcnr1}
xmfcnl1 N001 Vncas N006 0 sky130_fd_pr__nfet_01v8 w={W_xmfcnl1} l={L_xmfcnl1}
xmop1 Vout N004 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmop1} l={L_xmop1}
xmon1 Vout N007 0 0 sky130_fd_pr__nfet_01v8 w={W_xmon1} l={L_xmon1}
Cc1 Vout N008 2.4e-13

* Bias Circuit Subcircuit Definition
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

* Control Simulation
.control
* AC Analysis
ac dec 10 1 1G
let diff = v(vp) - v(vm)
let Aol_db = db(v(Vout)/diff)
let Aol_pm = 180 + ph(v(Vout)/diff) * 180 / 3.141592653589793

meas ac open_loop_dc_gain find Aol_db at=1
meas ac unity_gain_frequency when Aol_db=0
meas ac phase_margin find Aol_pm when Aol_db=0

* Transient Analysis
tran 0.1n 1.2u
meas tran output_swing_high find v(Vout) at=500n
meas tran output_swing_low find v(Vout) at=1000n

meas tran t1 when v(Vout)=1.4 fall=1 td=510n
meas tran t2 when v(Vout)=1.2 fall=1 td=510n
meas tran slew_rate param='0.2 / (t2 - t1) / 1e6'

meas tran i_vdd_q find i(VDD) at=500n
meas tran quiescent_current param='abs(i_vdd_q)'

print open_loop_dc_gain unity_gain_frequency phase_margin slew_rate quiescent_current output_swing_high output_swing_low
quit
.endc
.end