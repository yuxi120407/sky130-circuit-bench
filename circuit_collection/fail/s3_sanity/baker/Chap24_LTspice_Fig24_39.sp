* Testbench for Baker Fig. 24.37 / 24.39 Cascode OTA with CS Output Buffer
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

* Sizing Parameters (matching Baker Table 9.2 & Fig. 24.37 scaled to SKY130)
.param L_def=0.3
.param W_p_def=15.0
.param W_n_def=7.5

* DUT Parameters
.param W_xm1={W_n_def}   L_xm1={L_def}
.param W_xm2={W_n_def}   L_xm2={L_def}
.param W_xm3={W_p_def}   L_xm3={L_def}
.param W_xm4={W_p_def}   L_xm4={L_def}
.param W_xm31={W_p_def}  L_xm31={L_def}
.param W_xm41={W_p_def}  L_xm41={L_def}
.param W_xm5={W_n_def}   L_xm5={L_def}
.param W_xm51={W_n_def}  L_xm51={L_def}
.param W_xm6={W_n_def}   L_xm6={L_def}
.param W_xm6b={W_n_def}  L_xm6b={L_def}
.param W_xm6lb={W_n_def} L_xm6lb={L_def}
.param W_xm8={W_n_def}   L_xm8={L_def}
.param W_xm9={W_n_def}   L_xm9={L_def}
.param W_xm10={W_n_def}  L_xm10={L_def}
.param W_xm11={W_p_def}  L_xm11={L_def}
.param W_xm12={W_p_def}  L_xm12={L_def}
.param W_xm13={W_p_def}  L_xm13={L_def}
.param W_xm14={W_p_def}  L_xm14={L_def}
.param W_xm7=150.0        L_xm7={L_def}
.param W_xm8b=75.0        L_xm8b={L_def}
.param W_xm8t=75.0        L_xm8t={L_def}

* Bias Circuit SUB_1 Parameters
.param W_xmsu1=7.5 L_xmsu1=0.3
.param W_xmsu2=15.0  L_xmsu2=0.3
.param W_xmsu3=7.5 L_xmsu3=0.3
.param W_xmsu4=7.5 L_xmsu4=0.3
.param W_xma1=15.0   L_xma1=0.3
.param W_xma2=15.0   L_xma2=0.3
.param W_xma3=15.0   L_xma3=0.3
.param W_xma4=15.0   L_xma4=0.3
.param W_xma5=15.0   L_xma5=0.3
.param W_xma6=15.0   L_xma6=0.3
.param W_xma7=15.0   L_xma7=0.3
.param W_xma8=15.0   L_xma8=0.3
.param W_xma9=15.0   L_xma9=0.3
.param W_xma10=15.0  L_xma10=0.3
.param W_xma11=15.0  L_xma11=0.3
.param W_xma12=15.0  L_xma12=0.3
.param W_xm15=7.5  L_xm15=0.3
.param W_xm16=7.5  L_xm16=0.3
.param W_xm17=7.5  L_xm17=0.3
.param W_xm18=7.5  L_xm18=0.3

* Circuit Netlist (DUT)
VDD VDD 0 1.8
xm2 N002 vm N008 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 vp N008 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm3 N003 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xm6b N011 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6b} l={L_xm6b}
xm51 N014 N009 0 0 sky130_fd_pr__nfet_01v8 w={W_xm51} l={L_xm51}
xm4 N006 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm5 N013 N009 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
CL Vout 0 1e-12
xm31 N004 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm31} l={L_xm31}
xm41 N005 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm41} l={L_xm41}
xm6 N008 Vbias3 N011 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm6lb N010 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6lb} l={L_xm6lb}
xm8 N008 Vbias3 N010 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
xm9 N009 Vbias3 N014 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm10 N007 Vbias3 N013 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
xm11 N009 Vbias2 N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
xm12 N007 Vbias2 N006 VDD sky130_fd_pr__pfet_01v8 w={W_xm12} l={L_xm12}
xm13 N001 Vbias2 N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm13} l={L_xm13}
xm14 N002 Vbias2 N005 VDD sky130_fd_pr__pfet_01v8 w={W_xm14} l={L_xm14}
xm7 Vout N007 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8b N012 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8b} l={L_xm8b}
xm8t Vout Vbias3 N012 0 sky130_fd_pr__nfet_01v8 w={W_xm8t} l={L_xm8t}
Cc Vout N013 2.4e-13
R1 Vm Vin 10000.0
R2 Vm Vout 10000.0

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

* Sources matching Fig. 24.39
* Vp set to 0.9 V common mode
Vcm vp 0 DC 0.9

* Vin has DC 0.9V, AC 1.0V, and transient step pulse
Vin_source Vin 0 DC 0.9 AC 1.0 pulse(0.8 1.0 1u 1n 1n 20u 40u)

.control
* 1. Operating Point Analysis
op
let quiescent_supply_current = -i(VDD)
let quiescent_power = quiescent_supply_current * 1.8
print quiescent_supply_current quiescent_power

* 2. AC Analysis: Measure closed-loop and open-loop response
ac dec 50 1 1G

* Closed-loop gain: Vout / Vin
let acl_db = db(v(Vout))
meas ac acl_dc find acl_db at=1
meas ac closed_loop_bandwidth when acl_db='acl_dc - 3.0' fall=1

* Open-loop response: A_OL = Vout / (Vp - Vm)
let aol_complex = v(Vout) / (v(vp) - v(vm))
let aol_db = db(aol_complex)
let aol_phase = 57.2957795131 * ph(aol_complex)

meas ac open_loop_gain find aol_db at=1
meas ac unity_gain_frequency when aol_db=0 fall=1
meas ac phase_at_ugf find aol_phase when aol_db=0 fall=1
meas ac phase_margin param='phase_at_ugf > 0 ? phase_at_ugf - 180 : phase_at_ugf + 180'

print open_loop_gain unity_gain_frequency phase_margin closed_loop_bandwidth

* 3. Transient Analysis: Measure Slew Rates from Step Response
tran 10n 40u
* Falling edge of Vout
meas tran sr_fall trig v(Vout) val=0.92 fall=1 targ v(Vout) val=0.88 fall=1
meas tran slew_rate_falling param='0.04 / (sr_fall * 1e6)'

* Rising edge of Vout
meas tran sr_rise trig v(Vout) val=0.88 rise=1 targ v(Vout) val=0.92 rise=1
meas tran slew_rate_rising param='0.04 / (sr_rise * 1e6)'

print slew_rate_falling slew_rate_rising

quit
.endc
.end