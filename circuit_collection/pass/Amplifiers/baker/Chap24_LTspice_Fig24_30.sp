* Testbench for Baker CMOS Op-Amp with Output Buffer (Fig. 24.29)
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
.param L_xm1b=0.5
.param L_xm1t=0.5
.param L_xm2=0.5
.param L_xm2b=0.5
.param L_xm2t=0.5
.param L_xm3=0.5
.param L_xm3b=0.5
.param L_xm3t=0.5
.param L_xm4=0.5
.param L_xm4b=0.5
.param L_xm4t=0.5
.param L_xm5=0.5
.param L_xm5_sub=0.5
.param L_xm6=0.5
.param L_xm6b=0.5
.param L_xm6t=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm8b=0.5
.param L_xm8t=0.5
.param L_xm9=0.5
.param L_xm9b=0.5
.param L_xm9t=0.5
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
.param W_xm10=5.0
.param W_xm12=5.0
.param W_xm13=5.0
.param W_xm14=5.0
.param W_xm15=5.0
.param W_xm17=5.0
.param W_xm18=5.0
.param W_xm2=5.0
.param W_xm5_sub=5.0
.param W_xm6=5.0
.param W_xm8=5.0
.param W_xm9=5.0
.param W_xma10=5.0
.param W_xma11=5.0
.param W_xma12=5.0
.param W_xma2=5.0
.param W_xma3=5.0
.param W_xma4=5.0
.param W_xma6=5.0
.param W_xma7=5.0
.param W_xma8=5.0
.param W_xmsu2=5.0
.param W_xmsu3=5.0
.param W_xmsu4=5.0

* Parameter definitions for device sizes (W/L)
.param W_xm1b=50.0 L_xm1b=0.15
.param W_xm2b=50.0 L_xm2b=0.15
.param W_xm1t=50.0 L_xm1t=0.15
.param W_xm2t=50.0 L_xm2t=0.15
.param W_xm3t=100.0 L_xm3t=0.15
.param W_xm3b=100.0 L_xm3b=0.15
.param W_xm4t=100.0 L_xm4t=0.15
.param W_xm4b=100.0 L_xm4b=0.15
.param W_xm9t=100.0 L_xm9t=0.15
.param W_xm9b=100.0 L_xm9b=0.15
.param W_xm6t=150.0 L_xm6t=0.15
.param W_xm6b=150.0 L_xm6b=0.15
.param W_xm8t=50.0 L_xm8t=0.15
.param W_xm8b=50.0 L_xm8b=0.15
.param W_xm3=100.0 L_xm3=0.15
.param W_xm4=100.0 L_xm4=0.15
.param W_xm5=10.0 L_xm5=0.5
.param W_xmfcp=50.0 L_xmfcp=0.15
.param W_xmfcn=25.0 L_xmfcn=0.15
.param W_xmop=1000.0 L_xmop=0.15
.param W_xmon=500.0 L_xmon=0.15

* Subcircuit bias transistors parameters
.param W_xmsu1=10.0 L_xmsu1=0.15 W_xmsu2=10.0 L_xmsu2=0.15 W_xmsu3=10.0 L_xmsu3=0.15 W_xmsu4=50.0 L_xmsu4=0.15
.param W_xm1=50.0 L_xm1=0.15 W_xm2=50.0 L_xm2=0.15 W_xm5_sub=50.0 L_xm5_sub=0.15 W_xm6=50.0 L_xm6=0.15
.param W_xm7=100.0 L_xm7=0.15 W_xm8=50.0 L_xm8=0.15 W_xm9=50.0 L_xm9=0.15 W_xm10=50.0 L_xm10=0.15
.param W_xm11=50.0 L_xm11=0.15 W_xm12=50.0 L_xm12=0.15 W_xm13=50.0 L_xm13=0.15 W_xm14=50.0 L_xm14=0.15 W_xm15=50.0 L_xm15=0.15
.param W_xm16=50.0 L_xm16=0.15 W_xm17=50.0 L_xm17=0.15 W_xm18=50.0 L_xm18=0.15
.param W_xma1=100.0 L_xma1=0.15 W_xma2=100.0 L_xma2=0.15 W_xma3=100.0 L_xma3=0.15 W_xma4=100.0 L_xma4=0.15
.param W_xma5=100.0 L_xma5=0.15 W_xma6=100.0 L_xma6=0.15 W_xma7=100.0 L_xma7=0.15 W_xma8=100.0 L_xma8=0.15
.param W_xma9=100.0 L_xma9=0.15 W_xma10=100.0 L_xma10=0.15 W_xma11=100.0 L_xma11=0.15 W_xma12=100.0 L_xma12=0.15

* Supply and Sources
VDD VDD 0 1.8

* Bias generator subcircuit
.subckt SUB_1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 N003 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma1} l={L_xma1}
  xm4 N004 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma2} l={L_xma2}
  xm1 N003 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm2 N004 N004 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  R1 N005 GND 5.5k
  xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm5 N001 N004 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5_sub} l={L_xm5_sub}
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

X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1

* Main Amplifier Core (Fig. 24.29)
xm2b N008 vin N011 0 sky130_fd_pr__nfet_01v8 w={W_xm2b} l={L_xm2b}
xm1b N009 vm N011 0 sky130_fd_pr__nfet_01v8 w={W_xm1b} l={L_xm1b}
xm4t N004 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4t} l={L_xm4t}
xm3t N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3t} l={L_xm3t}
xm6t N011 Vbias3 N012 0 sky130_fd_pr__nfet_01v8 w={W_xm6t} l={L_xm6t}
xm6b N012 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6b} l={L_xm6b}
xm9b N006 Vbias2 N005 VDD sky130_fd_pr__pfet_01v8 w={W_xm9b} l={L_xm9b}
xm8t N010 Vbias3 N013 0 sky130_fd_pr__nfet_01v8 w={W_xm8t} l={L_xm8t}
xm8b N013 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8b} l={L_xm8b}
Cc Vout N008 240fF
xm4b N006 Vbias2 N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm4b} l={L_xm4b}
xm3b N001 Vbias2 N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm3b} l={L_xm3b}
xm9t N005 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm9t} l={L_xm9t}
xm2t N006 N007 N008 0 sky130_fd_pr__nfet_01v8 w={W_xm2t} l={L_xm2t}
xm1t N001 N007 N009 0 sky130_fd_pr__nfet_01v8 w={W_xm1t} l={L_xm1t}
xm3 N007 Vbias2 N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 N003 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm5 N007 N007 N011 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xmfcp N010 Vpcas N006 VDD sky130_fd_pr__pfet_01v8 w={W_xmfcp} l={L_xmfcp}
xmfcn N006 Vncas N010 0 sky130_fd_pr__nfet_01v8 w={W_xmfcn} l={L_xmfcn}
xmop Vout N006 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmop} l={L_xmop}
xmon Vout N010 0 0 sky130_fd_pr__nfet_01v8 w={W_xmon} l={L_xmon}

* Feedback network for DC stability during AC analysis
Rf vm Vout 100MEG
Cf vm 0 1

* Load network for transient analysis
Rload Vout 0 1G
Cload Vout 0 1f

* AC input source at noninverting terminal
Vin vin 0 dc 1.1 ac 1.0 pulse(0.9 1.3 10n 100p 100p 500n 1000n)

.control
* --- Operating Point Analysis ---
op
let total_quiescent_power = -i(VDD) * 1.8
let output_stage_quiescent_current = @m.xmon.msky130_fd_pr__nfet_01v8[id]
print total_quiescent_power output_stage_quiescent_current

* --- AC Frequency Response ---
ac dec 100 0.1 1G
let vout_db = db(v(Vout))
let vout_ph = 180/3.14159265359 * ph(v(Vout))
meas ac open_loop_gain find vout_db at=1
meas ac unity_gain_frequency when vout_db=0 fall=1
meas ac phase_at_ugf find vout_ph when vout_db=0 fall=1
let phase_margin = 180 + phase_at_ugf
print open_loop_gain unity_gain_frequency phase_margin

* --- Transient Large-Signal Step Response (Fig. 24.31) ---
alter Rf 1
alter Cf 1f
alter Rload 1k
alter Cload 10p

tran 1n 1200n
meas tran dt_pos trig v(Vout) val=1.05 rise=1 targ v(Vout) val=1.15 rise=1
meas tran dt_neg trig v(Vout) val=1.15 fall=1 targ v(Vout) val=1.05 fall=1
let slew_rate_pos = 0.1 / dt_pos / 1e6
let slew_rate_neg = 0.1 / dt_neg / 1e6
print slew_rate_pos slew_rate_neg

quit
.endc
.end