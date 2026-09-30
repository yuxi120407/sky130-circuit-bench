* Op-Amp Testbench
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
.param L_xm4a=0.5
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
.param L_xmcg=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param L_xmsu4=0.5
.param W_xm1=5.0
.param W_xm10=5.0
.param W_xm12=5.0
.param W_xm13=5.0
.param W_xm14=5.0
.param W_xm15=5.0
.param W_xm17=5.0
.param W_xm18=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm6=5.0
.param W_xm6b=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm8b=5.0
.param W_xm8t=5.0
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
.param W_xmcg=5.0
.param W_xmsu1=5.0
.param W_xmsu3=5.0
.param W_xmsu4=5.0

* Define missing parameters with typical values to allow simulation
.param W_xm2=5.0 L_xm2=0.5 W_xm1=5.0 L_xm1=0.5 W_xm4=10.0 L_xm4=0.5 W_xm3=10.0 L_xm3=0.5
.param W_xm6t=5.0 L_xm6t=0.5 W_xm6b=5.0 L_xm6b=0.5 W_xm7=20.0 L_xm7=0.5 W_xm8t=5.0 L_xm8t=0.5 W_xm8b=5.0 L_xm8b=0.5
.param W_xm4a=10.0 L_xm4a=0.5 W_xmcg=5.0 L_xmcg=0.5 W_xm9=5.0 L_xm9=0.5 W_xm10=5.0 L_xm10=0.5
.param W_xmsu2=5.0 L_xmsu2=0.5 W_xmsu1=5.0 L_xmsu1=0.5 W_xmsu3=5.0 L_xmsu3=0.5
.param W_xm5=5.0 L_xm5=0.5 W_xm6=5.0 L_xm6=0.5 W_xma4=10.0 L_xma4=0.5 W_xma3=10.0 L_xma3=0.5
.param W_xma1=10.0 L_xma1=0.5 W_xma2=10.0 L_xma2=0.5 W_xmsu4=5.0 L_xmsu4=0.5 W_xm8=5.0 L_xm8=0.5
.param W_xm11=5.0 L_xm11=0.5 W_xm12=5.0 L_xm12=0.5 W_xm13=5.0 L_xm13=0.5 W_xm14=5.0 L_xm14=0.5 W_xm15=5.0 L_xm15=0.5
.param W_xma5=10.0 L_xma5=0.5 W_xma6=10.0 L_xma6=0.5 W_xma7=10.0 L_xma7=0.5 W_xma8=10.0 L_xma8=0.5
.param W_xma9=10.0 L_xma9=0.5 W_xma10=10.0 L_xma10=0.5 W_xma11=10.0 L_xma11=0.5 W_xma12=10.0 L_xma12=0.5
.param W_xm16=5.0 L_xm16=0.5 W_xm17=5.0 L_xm17=0.5 W_xm18=5.0 L_xm18=0.5

* DUT Netlist
VDD VDD 0 1.8
xm2 N002 vin N004 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 vout N004 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xm6t N004 Vbias3 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm6t} l={L_xm6t}
xm6b N005 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6b} l={L_xm6b}
xm7 vout N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8t vout Vbias3 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm8t} l={L_xm8t}
xm8b N006 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8b} l={L_xm8b}
Cc vout N003 2.4e-13
C3 vout 0 1e-13
xm4a N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4a} l={L_xm4a}
xmcg N002 vin N003 0 sky130_fd_pr__nfet_01v8 w={W_xmcg} l={L_xmcg}
xm9 N003 Vbias3 N007 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
xm10 N007 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
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

* Stimulus
Vin vin 0 dc 0.9 ac 1 pulse(0.5 1.3 10n 1n 1n 1u 2u)

.control
  * Initialize variables to prevent print errors if meas fails
  let unity_gain_frequency = -1
  let lhp_zero = -1
  let second_pole = -1
  let open_loop_gain = -1
  let cmrr = -1
  let psrr_plus = -1
  let slew_rate = -1

  * 1. DC Operating Point
  op

  * 2. AC Analysis for Aol, CMRR, Poles, Zeros
  ac dec 100 1 1G
  let Vdiff = v(vin) - v(vout)
  let Aol = v(vout) / Vdiff
  let Aol_db = db(Aol)
  let Aol_ph = 180/PI * cph(Aol)
  
  meas ac open_loop_gain find Aol_db at=1
  meas ac unity_gain_frequency when Aol_db=0
  
  let inv_cmrr = 1/Aol - Vdiff/v(vin)
  let cmrr_vec = db(1 / inv_cmrr)
  meas ac cmrr find cmrr_vec at=1
  
  let slope = deriv(Aol_db) * frequency * 2.302585
  meas ac second_pole when Aol_ph=-135 fall=1
  meas ac lhp_zero when slope=-10 rise=1
  
  * 3. AC Analysis for PSRR+
  alter Vin ac=0
  alter VDD ac=1
  ac dec 100 1 1G
  let psrr_vec = db(v(VDD) / v(vout))
  meas ac psrr_plus find psrr_vec at=1
  
  * 4. Transient Analysis for Slew Rate
  alter Vin ac=1
  alter VDD ac=0
  tran 1n 2u
  let dvout = deriv(v(vout))
  meas tran sr_max max dvout
  meas tran sr_min min dvout
  let sr_rise = sr_max / 1e6
  let sr_fall = -sr_min / 1e6
  let slew_rate = (sr_rise + sr_fall - abs(sr_rise - sr_fall))/2
  
  * Print all metrics
  print unity_gain_frequency
  print lhp_zero
  print second_pole
  print slew_rate
  print open_loop_gain
  print cmrr
  print psrr_plus
  
  quit
.endc
.end