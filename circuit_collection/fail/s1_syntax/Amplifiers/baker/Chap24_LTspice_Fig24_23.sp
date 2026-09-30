* CMOS Two-Stage Op-Amp Testbench (Baker Fig. 24.14 / Fig. 24.8 / Fig. 24.23)
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

* Parameter definitions for standard Baker Chapter 24 scaling
.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=10.0 L_xm2=1.0
.param W_xm3=10.0 L_xm3=1.0
.param W_xm4=10.0 L_xm4=1.0
.param W_xm6t=20.0 L_xm6t=1.0
.param W_xm6b=20.0 L_xm6b=1.0
.param W_xm7=20.0 L_xm7=1.0
.param W_xm8t=10.0 L_xm8t=1.0
.param W_xm8b=10.0 L_xm8b=1.0

.param W_xmsu1=5.0 L_xmsu1=1.0
.param W_xmsu2=5.0 L_xmsu2=1.0
.param W_xmsu3=5.0 L_xmsu3=1.0
.param W_xmsu4=10.0 L_xmsu4=1.0
.param W_xma1=10.0 L_xma1=1.0
.param W_xma2=10.0 L_xma2=1.0
.param W_xma3=10.0 L_xma3=1.0
.param W_xma4=10.0 L_xma4=1.0
.param W_xma5=10.0 L_xma5=1.0
.param W_xma6=10.0 L_xma6=1.0
.param W_xma7=10.0 L_xma7=1.0
.param W_xma8=10.0 L_xma8=1.0
.param W_xma9=10.0 L_xma9=1.0
.param W_xma10=10.0 L_xma10=1.0
.param W_xma11=10.0 L_xma11=1.0
.param W_xma12=10.0 L_xma12=1.0
.param W_xm5=10.0 L_xm5=1.0
.param W_xm6=10.0 L_xm6=1.0
.param W_xm7=10.0 L_xm7=1.0
.param W_xm8=10.0 L_xm8=1.0
.param W_xm9=10.0 L_xm9=1.0
.param W_xm10=10.0 L_xm10=1.0
.param W_xm11=10.0 L_xm11=1.0
.param W_xm12=10.0 L_xm12=1.0
.param W_xm13=10.0 L_xm13=1.0
.param W_xm14=10.0 L_xm14=1.0
.param W_xm15=10.0 L_xm15=1.0
.param W_xm16=10.0 L_xm16=1.0
.param W_xm17=10.0 L_xm17=1.0
.param W_xm18=10.0 L_xm18=1.0

* DUT Subcircuit definition
.subckt SUB_1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 N003 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm4 N004 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xm1 N003 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
  xm2 N004 N004 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
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

.subckt OPAMP_DUT vin vinn vout VDD GND
  xm2 N002 vin N004 GND sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  xm1 N001 vinn N004 GND sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm4 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD GND SUB_1
  xm6t N004 Vbias3 N005 GND sky130_fd_pr__nfet_01v8 w={W_xm6t} l={L_xm6t}
  xm6b N005 Vbias4 GND GND sky130_fd_pr__nfet_01v8 w={W_xm6b} l={L_xm6b}
  xm7 vout N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xm8t vout Vbias3 N006 GND sky130_fd_pr__nfet_01v8 w={W_xm8t} l={L_xm8t}
  xm8b N006 Vbias4 GND GND sky130_fd_pr__nfet_01v8 w={W_xm8b} l={L_xm8b}
  Cc vout N003 2.4e-12
  C3 vout GND 1e-12
  Rz N002 N003 6500.0
.ends OPAMP_DUT

* Power Supplies
VDD VDD 0 DC 1.8

* Instance 1: AC Open-Loop
XDUT1 vin_ac vfb_ac vout_ac VDD 0 OPAMP_DUT
Lfb1 vout_ac vfb_ac 1000MEG
Cfb1 vfb_ac 0 10u
Vac_diff vin_ac 0 DC 0.7 AC 1

* Instance 2: Large-Signal Transient Step Response
XDUT2 vin_step vout_step vout_step VDD 0 OPAMP_DUT
Vin_pulse vin_step 0 PULSE(0.5 0.9 450n 1n 1n 250n 1u)

* Instance 3: CMRR
XDUT_CMRR vin_cmrr vfb_cmrr vout_cmrr VDD 0 OPAMP_DUT
Lfb_cmrr vout_cmrr vfb_cmrr 1000MEG
Cfb_cmrr vfb_cmrr vin_cmrr 10u
Vac_cmrr vin_cmrr 0 DC 0.7 AC 1

* Instance 4: PSRR+
VDD_psrr VDD_psrr 0 DC 1.8 AC 1
XDUT_PSRR vin_psrr vfb_psrr vout_psrr VDD_psrr 0 OPAMP_DUT
Lfb_psrr vout_psrr vfb_psrr 1000MEG
Cfb_psrr vfb_psrr 0 10u
Vdc_psrr vin_psrr 0 DC 0.7 AC 0

.control
save all

* 1. DC Operating Point & Power
op
let power_dissipation = -i(VDD_psrr) * 1.8
print power_dissipation

* 2. AC Analysis
ac dec 100 10 1G

let aol_db = db(v(vout_ac))
meas ac open_loop_gain find aol_db at=10

meas ac unity_gain_frequency when aol_db=0 fall=1

let phase_deg = 180/3.141592653589793 * phase(v(vout_ac))
let pm = 180 + phase_deg
meas ac phase_margin find pm when aol_db=0 fall=1

let acm_db = db(v(vout_cmrr))
let cmrr_vec = aol_db - acm_db
meas ac cmrr find cmrr_vec at=10

let avdd_db = db(v(vout_psrr))
let psrr_plus_vec = aol_db - avdd_db
meas ac psrr_plus find psrr_plus_vec at=10

* 3. Transient Analysis
tran 0.5n 1u 400n

meas tran sr_pos trig v(vout_step) val=0.55 rise=1 targ v(vout_step) val=0.85 rise=1
let slew_rate_positive = 0.3 / sr_pos * 1e-6
print slew_rate_positive

meas tran sr_neg trig v(vout_step) val=0.85 fall=1 targ v(vout_step) val=0.55 fall=1
let slew_rate_negative = 0.3 / sr_neg * 1e-6
print slew_rate_negative

meas tran settling_time_rise trig v(vin_step) val=0.7 rise=1 targ v(vout_step) val=0.896 rise=1
meas tran settling_time_fall trig v(vin_step) val=0.7 fall=1 targ v(vout_step) val=0.504 fall=1

quit
.endc
.end