* Testbench for Baker Fig. 24.29 CMOS Op-Amp with Output Buffer
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm17=0.5
.param L_xm18=0.5
.param L_xm2=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm9=0.5
.param L_xma10=0.5
.param L_xma12=0.5
.param L_xma2=0.5
.param L_xma3=0.5
.param L_xma4=0.5
.param L_xma6=0.5
.param L_xma7=0.5
.param L_xma9=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param L_xmsu4=0.5
.param W_xm1=5.0
.param W_xm10=5.0
.param W_xm11=5.0
.param W_xm12=5.0
.param W_xm13=5.0
.param W_xm14=5.0
.param W_xm15=5.0
.param W_xm16=5.0
.param W_xm17=5.0
.param W_xm18=5.0
.param W_xm1b=5.0
.param W_xm1t=5.0
.param W_xm2=5.0
.param W_xm2b=5.0
.param W_xm2t=5.0
.param W_xm3=5.0
.param W_xm3b=5.0
.param W_xm3t=5.0
.param W_xm4=5.0
.param W_xm4b=5.0
.param W_xm4t=5.0
.param W_xm5=5.0
.param W_xm5_sub=5.0
.param W_xm6=5.0
.param W_xm6b=5.0
.param W_xm6t=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm8b=5.0
.param W_xm8t=5.0
.param W_xm9=5.0
.param W_xm9b=5.0
.param W_xm9t=5.0
.param W_xma1=5.0
.param W_xma10=5.0
.param W_xma11=5.0
.param W_xma12=5.0
.param W_xma2=5.0
.param W_xma3=5.0
.param W_xma4=5.0
.param W_xma5=5.0
.param W_xma6=5.0
.param W_xma7=5.0
.param W_xma8=5.0
.param W_xma9=5.0
.param W_xmfcn=5.0
.param W_xmfcp=5.0
.param W_xmon=5.0
.param W_xmop=5.0
.param W_xmsu1=5.0
.param W_xmsu2=5.0
.param W_xmsu3=5.0
.param W_xmsu4=5.0

* W/L Parameter definitions (Table 9.2 & Fig 24.29: length in um, width in um)
.param L_xm2b=0.15 W_xm2b=5.0
.param L_xm1b=0.15 W_xm1b=5.0
.param L_xm4t=0.15 W_xm4t=10.0
.param L_xm3t=0.15 W_xm3t=10.0
.param L_xm6t=0.15 W_xm6t=15.0
.param L_xm6b=0.15 W_xm6b=15.0
.param L_xm9b=0.15 W_xm9b=10.0
.param L_xm8t=0.15 W_xm8t=5.0
.param L_xm8b=0.15 W_xm8b=5.0
.param L_xm4b=0.15 W_xm4b=10.0
.param L_xm3b=0.15 W_xm3b=10.0
.param L_xm9t=0.15 W_xm9t=10.0
.param L_xm2t=0.15 W_xm2t=5.0
.param L_xm1t=0.15 W_xm1t=5.0
.param L_xm3=0.15  W_xm3=10.0
.param L_xm4=0.15  W_xm4=10.0
.param L_xm5=0.15  W_xm5=5.0
.param L_xmfcp=0.15 W_xmfcp=5.0
.param L_xmfcn=0.15 W_xmfcn=2.5
.param L_xmop=0.15  W_xmop=100.0
.param L_xmon=0.15  W_xmon=50.0

* Subcircuit transistor parameters
.param L_xmsu1=0.15 W_xmsu1=5.0 L_xmsu2=0.15 W_xmsu2=5.0 L_xmsu3=0.15 W_xmsu3=5.0
.param L_xm1=0.15 W_xm1=5.0 L_xm2=0.15 W_xm2=5.0 L_xma3=0.15 W_xma3=10.0 L_xma4=0.15 W_xma4=10.0
.param L_xm5_sub=0.15 W_xm5_sub=5.0 L_xm6=0.15 W_xm6=5.0 L_xm7=0.15 W_xm7=10.0
.param L_xma1=0.15 W_xma1=10.0 L_xma2=0.15 W_xma2=10.0 L_xmsu4=0.15 W_xmsu4=5.0
.param L_xm8=0.15 W_xm8=5.0 L_xm9=0.15 W_xm9=5.0 L_xm10=0.15 W_xm10=5.0 L_xm11=0.15 W_xm11=5.0
.param L_xm12=0.15 W_xm12=5.0 L_xm13=0.15 W_xm13=5.0 L_xm14=0.15 W_xm14=5.0 L_xm15=0.15 W_xm15=5.0
.param L_xma5=0.15 W_xma5=10.0 L_xma6=0.15 W_xma6=10.0 L_xma7=0.15 W_xma7=10.0
.param L_xma8=0.15 W_xma8=10.0 L_xma9=0.15 W_xma9=10.0 L_xma10=0.15 W_xma10=10.0
.param L_xma11=0.15 W_xma11=10.0 L_xma12=0.15 W_xma12=10.0
.param L_xm16=0.15 W_xm16=5.0 L_xm17=0.15 W_xm17=5.0 L_xm18=0.15 W_xm18=5.0

* Power Supplies
VDD VDD 0 dc 1.8 ac 0

* DUT Instance
xm2b N008 vp N011 0 sky130_fd_pr__nfet_01v8 w={W_xm2b} l={L_xm2b}
xm1b N009 vm N011 0 sky130_fd_pr__nfet_01v8 w={W_xm1b} l={L_xm1b}
xm4t N004 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4t} l={L_xm4t}
xm3t N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3t} l={L_xm3t}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
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

* Load (Fig. 24.31: 1k resistor in parallel with 10 pF capacitor)
RL Vout 0 1k
CL Vout 0 1e-11

* Inverting closed-loop feedback resistors (Fig. 24.31)
R1 vm Vout 10000.0
R2 vm Vin 10000.0

* Input voltage source for closed-loop inverting step response
* Nominal DC common-mode is set to 0.5V (or 0.9V)
Vin Vin 0 dc 0.9 ac 0 pulse(0.1 1.7 50n 1n 1n 200n 500n)
Vref vp 0 dc 0.9 ac 1

* Bias Generator Subcircuit
.subckt SUB_1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 N003 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm4 N004 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
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

* Control Block for Simulations and Measurements
.control
  destroy all

  * 1. Operating Point: Measure Quiescent Power
  op
  let quiescent_power = -i(VDD) * 1.8
  print quiescent_power

  * 2. Transient Analysis: Slew Rate and Step Settling
  tran 0.1n 600n 0
  let dvout = deriv(v(Vout))
  meas tran max_dvdt MAX dvout FROM=40n TO=100n
  meas tran min_dvdt MIN dvout FROM=240n TO=300n
  let slew_rate_positive = max_dvdt / 1e6
  let slew_rate_negative = -min_dvdt / 1e6
  print slew_rate_negative slew_rate_positive

  * 3. AC Open-Loop Analysis (Closed-Loop Method)
  ac dec 100 1 1G
  let aol = v(Vout) / (v(vp) - v(vm))
  let gain_db = db(aol)
  let phase_deg = 180 / 3.141592653589793 * ph(aol)
  meas ac open_loop_dc_gain find gain_db at=10
  meas ac unity_gain_frequency when gain_db=0 fall=1
  meas ac phase_at_fun find phase_deg when gain_db=0 fall=1
  let phase_margin = 180 + phase_at_fun
  print open_loop_dc_gain unity_gain_frequency phase_margin

  * 4. Common-Mode Rejection Ratio (CMRR)
  alter @Vref[ac] = 1
  alter @Vin[ac] = 1
  ac dec 100 1 1G
  let aol = ac1.aol
  let vdiff = v(vp) - v(vm)
  let vcm = (v(vp) + v(vm)) / 2
  let a_cm = (v(Vout) - aol * vdiff) / vcm
  let cmrr_mag = aol / a_cm
  let cmrr_db = db(cmrr_mag)
  meas ac cmrr find cmrr_db at=10
  print cmrr

  * 5. Power Supply Rejection Ratio (PSRR+)
  alter @Vref[ac] = 0
  alter @Vin[ac] = 0
  alter @VDD[ac] = 1
  ac dec 100 1 1G
  let aol = ac1.aol
  let vdiff = v(vp) - v(vm)
  let a_vdd = v(Vout) - aol * vdiff
  let psrr_mag = aol / a_vdd
  let psrr_db = db(psrr_mag)
  meas ac psrr_positive find psrr_db at=10
  print psrr_positive

  quit
.endc
.end