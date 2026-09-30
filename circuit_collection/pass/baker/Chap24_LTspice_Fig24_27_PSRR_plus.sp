* Testbench for Two-Stage Op-Amp (Fig. 24.8 / Fig. 24.27)
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
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param L_xmsu4=0.5

* W/L parameters for sky130 transistors
.param W_xm1=10.0  L_xm1=1.0
.param W_xm2=10.0  L_xm2=1.0
.param W_xm3=20.0  L_xm3=1.0
.param W_xm4=20.0  L_xm4=1.0
.param W_xm5=10.0  L_xm5=1.0
.param W_xm6=10.0  L_xm6=1.0
.param W_xm7=10.0  L_xm7=1.0
.param W_xm8=20.0  L_xm8=1.0
.param W_xm9=20.0  L_xm9=1.0
.param W_xm10=10.0 L_xm10=1.0
.param W_xm11=10.0 L_xm11=1.0
.param W_xm12=20.0 L_xm12=1.0
.param W_xm13=10.0 L_xm13=1.0
.param W_xm14=10.0 L_xm14=1.0
.param W_xm15=10.0 L_xm15=1.0
.param W_xm16=20.0 L_xm16=1.0
.param W_xm17=10.0 L_xm17=1.0
.param W_xm18=10.0 L_xm18=1.0

* Bias subcircuit transistor parameters
.param W_xmsu1=5.0  L_xmsu1=1.0
.param W_xmsu2=5.0  L_xmsu2=1.0
.param W_xmsu3=5.0  L_xmsu3=1.0
.param W_xmsu4=5.0  L_xmsu4=1.0
.param W_xma1=10.0  L_xma1=1.0
.param W_xma2=10.0  L_xma2=1.0
.param W_xma3=10.0  L_xma3=1.0
.param W_xma4=10.0  L_xma4=1.0
.param W_xma5=10.0  L_xma5=1.0
.param W_xma6=10.0  L_xma6=1.0
.param W_xma7=10.0  L_xma7=1.0
.param W_xma8=10.0  L_xma8=1.0
.param W_xma9=10.0  L_xma9=1.0
.param W_xma10=10.0 L_xma10=1.0
.param W_xma11=10.0 L_xma11=1.0
.param W_xma12=10.0 L_xma12=1.0

* Power Supplies
VDD  VDD  0 DC 1.8
VDD1 N008 0 DC 1.8 AC 1
VDD2 VDD_AOL 0 DC 1.8

* Common-mode input reference
Vin_cm N012 0 DC 0.9
Vin_ac N003 0 DC 0.9 AC 1 PWL(0 0.9 10u 0.9 10.001u 1.4 1m 1.4 1.000001m 0.4 2m 0.4)

* --- Instance 1: PSRR Test (Supply AC source on N008) ---
xm5 N010 N012 N014 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
xm6 N009 N011 N014 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm8 N010 N009 N008 N008 sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
xm9 N009 N009 N008 N008 sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
xm10 N014 Vbias3 N015 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
xm11 N015 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
xm12 Vout N010 N008 N008 sky130_fd_pr__pfet_01v8 w={W_xm12} l={L_xm12}
xm13 Vout Vbias3 N016 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
xm14 N016 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
C2 N011 0 1e-05
R2 N011 Vout 100000000.0
Cc1 Vout N013 2.4e-12
C4 Vout 0 1e-13
Rz1 N010 N013 6500.0

* --- Instance 2: Open-Loop Gain Test (Differential AC on N003) ---
xm1 N002 N003 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 N001 vm N005 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 N002 N001 VDD_AOL VDD_AOL sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm4 N001 N001 VDD_AOL VDD_AOL sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm7 N005 Vbias3 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
xm15 N006 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm15} l={L_xm15}
xm16 AOL N002 VDD_AOL VDD_AOL sky130_fd_pr__pfet_01v8 w={W_xm16} l={L_xm16}
xm17 AOL Vbias3 N007 0 sky130_fd_pr__nfet_01v8 w={W_xm17} l={L_xm17}
xm18 N007 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm18} l={L_xm18}
C1 vm 0 1e-05
R1 vm AOL 100000000.0
Cc2 AOL N004 2.4e-12
C3 AOL 0 1e-13
Rz2 N002 N004 6500.0

* --- Bias Generation Subcircuit ---
X_U2 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1

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

* Control Block
.control
* 1. Operating Point (Power)
op
let power_dissipation = -(i(VDD) + i(VDD1) + i(VDD2)) * 1.8
print power_dissipation

* 2. AC Analysis (Open-loop gain, PSRR+, Bandwidth)
ac dec 100 0.01 100MEG

let A_ol_vec = v(AOL) / (v(N003) - v(vm))
let aol_db = db(A_ol_vec)
let aol_ph = 180/PI * ph(A_ol_vec)

let A_vdd_vec = v(Vout) + A_ol_vec * v(N011)
let vdd_gain_db = db(A_vdd_vec)
let psrr_pos_db = aol_db - vdd_gain_db

meas ac open_loop_dc_gain find aol_db at=0.01
print open_loop_dc_gain

meas ac vdd_to_output_gain_dc find vdd_gain_db at=0.01
print vdd_to_output_gain_dc

meas ac psrr_positive_dc find psrr_pos_db at=0.01
print psrr_positive_dc

let aol_3db_target = $&open_loop_dc_gain - 3.0
meas ac dominant_pole_3db when aol_db=$&aol_3db_target fall=1
print dominant_pole_3db

meas ac unity_gain_frequency when aol_db=0 fall=1
print unity_gain_frequency

meas ac ph_fun find aol_ph when aol_db=0 fall=1
let phase_margin = 180 + $&ph_fun
print phase_margin

* 3. Transient Analysis (Slew Rate)
tran 0.1u 2m

meas tran t_up_10 when v(AOL)=1.0 td=10u
meas tran t_up_12 when v(AOL)=1.2 td=10u
let slew_rate_positive = (1.2 - 1.0) / ($&t_up_12 - $&t_up_10) / 1e6
print slew_rate_positive

meas tran t_dn_08 when v(AOL)=0.8 td=1m
meas tran t_dn_06 when v(AOL)=0.6 td=1m
let slew_rate_negative = (0.8 - 0.6) / ($&t_dn_06 - $&t_dn_08) / 1e6
print slew_rate_negative

quit
.endc
.end