* Testbench for Figure 24.21: Indirect Feedback Compensated Op-Amp
.title Testbench Fig 24.21 Op-Amp

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

* Parameter defaults matching Fig 24.21 and Table 9.2
.param W_xm1=50.0 L_xm1=2.0
.param W_xm2=50.0 L_xm2=2.0
.param W_xm3t=100.0 L_xm3t=1.0
.param W_xm3b=100.0 L_xm3b=1.0
.param W_xm4t=100.0 L_xm4t=1.0
.param W_xm4b=100.0 L_xm4b=1.0
.param W_xm6t=100.0 L_xm6t=2.0
.param W_xm6b=100.0 L_xm6b=2.0
.param W_xm7t=100.0 L_xm7t=1.0
.param W_xm7b=100.0 L_xm7b=1.0
.param W_xm8t=50.0 L_xm8t=2.0
.param W_xm8b=50.0 L_xm8b=2.0

.param W_xmsu1=10.0 L_xmsu1=2.0
.param W_xmsu2=10.0 L_xmsu2=2.0
.param W_xmsu3=10.0 L_xmsu3=2.0
.param W_xmsu4=10.0 L_xmsu4=2.0
.param W_xm3=10.0 L_xm3=2.0
.param W_xm4=10.0 L_xm4=2.0
.param W_xm5=10.0 L_xm5=2.0
.param W_xm6=10.0 L_xm6=2.0
.param W_xm7=10.0 L_xm7=2.0
.param W_xm8=10.0 L_xm8=2.0
.param W_xm9=10.0 L_xm9=2.0
.param W_xm10=10.0 L_xm10=2.0
.param W_xm11=10.0 L_xm11=2.0
.param W_xm12=10.0 L_xm12=2.0
.param W_xm13=10.0 L_xm13=2.0
.param W_xm14=10.0 L_xm14=2.0
.param W_xm15=10.0 L_xm15=2.0
.param W_xm16=10.0 L_xm16=2.0
.param W_xm17=10.0 L_xm17=2.0
.param W_xm18=10.0 L_xm18=2.0
.param W_xma1=10.0 L_xma1=2.0
.param W_xma2=10.0 L_xma2=2.0
.param W_xma3=10.0 L_xma3=2.0
.param W_xma4=10.0 L_xma4=2.0
.param W_xma5=10.0 L_xma5=2.0
.param W_xma6=10.0 L_xma6=2.0
.param W_xma7=10.0 L_xma7=2.0
.param W_xma8=10.0 L_xma8=2.0
.param W_xma9=10.0 L_xma9=2.0
.param W_xma10=10.0 L_xma10=2.0
.param W_xma11=10.0 L_xma11=2.0
.param W_xma12=10.0 L_xma12=2.0

* Supply Sources
VDD VDD 0 1.8

* DUT Instance
xm2 N002 vin N006 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 vout N006 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4t N003 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4t} l={L_xm4t}
xm3t N004 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3t} l={L_xm3t}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1 W_xm1=10.0 W_xm2=40.0
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

* Driving source with DC common-mode and AC/Pulse excitations
Vin_src vin 0 dc 0.7 ac 1 pulse(0.5 0.9 100n 1n 1n 200n 500n)

.control
* 1. Operating Point Analysis
op
let power_dissipation = -i(VDD) * 1.8
print power_dissipation

* 2. Open-Loop AC Analysis
alter @Vin_src[ac] = 1
alter @VDD[ac] = 0
ac dec 50 1 1G
let aol = v(vout) / (v(vin) - v(vout))
let aol_db = 20*log10(mag(aol))
let aol_ph = 180/PI * cph(aol)

meas ac open_loop_dc_gain find aol_db at=1
meas ac unity_gain_frequency when aol_db=0 fall=1
meas ac phase_at_ugf find aol_ph when aol_db=0 fall=1
meas ac phase_margin param='phase_at_ugf + 180'
meas ac gain_at_180 find aol_db when aol_ph=-180 fall=1
meas ac gain_margin param='-gain_at_180'

meas ac second_pole_frequency when aol_ph=-135 fall=1
let slope = frequency * 2.302585 * deriv(aol_db)
meas ac lhp_zero_frequency when slope=-30 rise=1

print open_loop_dc_gain unity_gain_frequency phase_margin gain_margin second_pole_frequency lhp_zero_frequency

* 3. PSRR+
alter @Vin_src[ac] = 0
alter @VDD[ac] = 1
ac dec 10 1 1G
let psrr_pos_db = -20*log10(mag(v(vout)))
meas ac psrr_positive find psrr_pos_db at=1
print psrr_positive

* 4. PSRR- and CMRR
alter @VDD[ac] = -1
alter @Vin_src[ac] = -1
ac dec 10 1 1G
let psrr_neg_db = -20*log10(mag(v(vout) + 1))
meas ac psrr_negative find psrr_neg_db at=1
meas ac cmrr find psrr_neg_db at=1
print psrr_negative cmrr

* 5. Transient Step Response
alter @VDD[ac] = 0
alter @Vin_src[ac] = 0
tran 0.5n 600n
meas tran sr_pos trig v(vout) val=0.55 rise=1 targ v(vout) val=0.85 rise=1
meas tran sr_neg trig v(vout) val=0.85 fall=1 targ v(vout) val=0.55 fall=1
meas tran slew_rate_positive param='0.3 / (sr_pos * 1e6)'
meas tran slew_rate_negative param='0.3 / (sr_neg * 1e6)'
print slew_rate_positive slew_rate_negative

quit
.endc
.end