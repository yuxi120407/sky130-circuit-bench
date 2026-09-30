* Testbench for Fig 24.29 CMOS Op-Amp with Output Buffer (Sky130)
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
.param W_xm11=5.0
.param W_xm12=5.0
.param W_xm13=5.0
.param W_xm15=5.0
.param W_xm16=5.0
.param W_xm17=5.0
.param W_xm18=5.0
.param W_xm2=5.0
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
.param W_xma6=5.0
.param W_xma7=5.0
.param W_xma8=5.0
.param W_xmsu1=5.0
.param W_xmsu3=5.0

* Parameter definitions for device sizes
.param W_xm2b=2.5 L_xm2b=0.15
.param W_xm1b=2.5 L_xm1b=0.15
.param W_xm4t=5.0 L_xm4t=0.15
.param W_xm3t=5.0 L_xm3t=0.15
.param W_xm6t=7.5 L_xm6t=0.15
.param W_xm6b=7.5 L_xm6b=0.15
.param W_xm9b=5.0 L_xm9b=0.15
.param W_xm8t=2.5 L_xm8t=0.15
.param W_xm8b=2.5 L_xm8b=0.15
.param W_xm4b=5.0 L_xm4b=0.15
.param W_xm3b=5.0 L_xm3b=0.15
.param W_xm9t=5.0 L_xm9t=0.15
.param W_xm2t=2.5 L_xm2t=0.15
.param W_xm1t=2.5 L_xm1t=0.15
.param W_xm3=5.0 L_xm3=0.15
.param W_xm4=5.0 L_xm4=0.15
.param W_xm5=2.5 L_xm5=0.15
.param W_xmfcp=1.25 L_xmfcp=0.15
.param W_xmfcn=2.5 L_xmfcn=0.15
.param W_xmop=50.0 L_xmop=0.15
.param W_xmon=25.0 L_xmon=0.15

* Subcircuit bias transistors
.param W_xmsu2=5.0 L_xmsu2=0.15 W_xmsu1=2.5 L_xmsu1=0.15 W_xmsu3=2.5 L_xmsu3=0.15
.param W_xma4=5.0 L_xma4=0.15 W_xma3=5.0 L_xma3=0.15 W_xma1=5.0 L_xma1=0.15 W_xma2=5.0 L_xma2=0.15
.param W_xmsu4=2.5 L_xmsu4=0.15 W_xm8=2.5 L_xm8=0.15 W_xm9=2.5 L_xm9=0.15
.param W_xm10=2.5 L_xm10=0.15 W_xm11=2.5 L_xm11=0.15 W_xm12=2.5 L_xm12=0.15 W_xm13=2.5 L_xm13=0.15
.param W_xm14=2.5 L_xm14=0.15 W_xm15=2.5 L_xm15=0.15 W_xm16=2.5 L_xm16=0.15 W_xm17=2.5 L_xm17=0.15 W_xm18=2.5 L_xm18=0.15
.param W_xma5=5.0 L_xma5=0.15 W_xma6=5.0 L_xma6=0.15 W_xma7=5.0 L_xma7=0.15 W_xma8=5.0 L_xma8=0.15
.param W_xma9=5.0 L_xma9=0.15 W_xma10=5.0 L_xma10=0.15 W_xma11=5.0 L_xma11=0.15 W_xma12=5.0 L_xma12=0.15
.param W_xm1=2.5 L_xm1=0.15 W_xm2=2.5 L_xm2=0.15 W_xm5=2.5 L_xm5=0.15 W_xm6=2.5 L_xm6=0.15 W_xm7=5.0 L_xm7=0.15

* Power Supplies
VDD VDD 0 1.8

* Bias generator subcircuit
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

* Bias generator instance
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1

* DUT: Core Op-Amp Transistors
xm2b N008 vp N011 0 sky130_fd_pr__nfet_01v8 w={W_xm2b} l={L_xm2b}
xm1b N009 vm N011 0 sky130_fd_pr__nfet_01v8 w={W_xm1b} l={L_xm1b}
xm4t N004 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4t} l={L_xm4t}
xm3t N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3t} l={L_xm3t}
xm6t N011 Vbias3 N012 0 sky130_fd_pr__nfet_01v8 w={W_xm6t} l={L_xm6t}
xm6b N012 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6b} l={L_xm6b}
xm9b N006 Vbias2 N005 VDD sky130_fd_pr__pfet_01v8 w={W_xm9b} l={L_xm9b}
xm8t N010 Vbias3 N013 0 sky130_fd_pr__nfet_01v8 w={W_xm8t} l={L_xm8t}
xm8b N013 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8b} l={L_xm8b}
Cc Vout N008 2.4e-13
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

* Feedback network and loads (Fig. 24.31)
R1 vm Vout 10000.0
R2 vm Vin 10000.0
RL Vout 0 10000.0
CL Vout 0 1e-11

* Input sources: Vp at 0.9V common-mode, Vin pulse
Vref vp 0 DC 0.9
Vin Vin 0 DC 0.9 AC 1 PULSE(0.4 1.4 1u 1n 1n 1u 3u)

.control
* 1. Operating Point
op
let quiescent_power = -i(VDD) * 1.8
print quiescent_power

* 2. AC Open-Loop / Closed-Loop Response
ac dec 50 0.1 10G
let A_OL = -v(Vout)/v(vm)
let gain_db = db(A_OL)
let phase = 180/3.14159265359 * cph(A_OL)
meas ac open_loop_dc_gain find gain_db at=0.1
meas ac unity_gain_frequency when gain_db=0 fall=1
meas ac phase_at_ugf find phase when gain_db=0 fall=1
let phase_margin = 180 + phase_at_ugf

let A2 = v(Vout)/v(N006)
let A2_db = db(A2)
meas ac second_stage_gain find A2_db at=0.1

print open_loop_dc_gain second_stage_gain unity_gain_frequency phase_margin

* 3. Transient Step Response
tran 1n 3u
meas tran v_high find v(Vout) at=0.9u
meas tran v_low find v(Vout) at=1.9u
let v90 = v_low + 0.9 * (v_high - v_low)
let v10 = v_low + 0.1 * (v_high - v_low)
meas tran step_response_fall_time trig v(Vout) val=$&v90 fall=1 td=0.9u targ v(Vout) val=$&v10 fall=1 td=0.9u
meas tran step_response_rise_time trig v(Vout) val=$&v10 rise=1 td=1.9u targ v(Vout) val=$&v90 rise=1 td=1.9u
print step_response_fall_time step_response_rise_time
quit
.endc
.end