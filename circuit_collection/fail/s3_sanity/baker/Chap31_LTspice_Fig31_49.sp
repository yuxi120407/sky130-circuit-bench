* Testbench for Series-Shunt Feedback Amplifier (Fig 31.17)
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
.param L_xmr3=0.5
.param L_xmrl=0.5
.param L_xmsf=0.5
.param L_xmsl=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param L_xmsu4=0.5

* Parameter definitions for transistors
.param W_xmr3=5.0 L_xmr3=1.0
.param W_xm1=10.0 L_xm1=0.5
.param W_xm2=10.0 L_xm2=0.5
.param W_xmrl=10.0 L_xmrl=1.0
.param W_xmsf=20.0 L_xmsf=0.5
.param W_xmsl=20.0 L_xmsl=1.0
.param W_xmsu2=5.0 L_xmsu2=1.0
.param W_xmsu1=5.0 L_xmsu1=1.0
.param W_xmsu3=5.0 L_xmsu3=1.0
.param W_xm3=5.0 L_xm3=1.0
.param W_xm4=5.0 L_xm4=1.0
.param W_xma4=5.0 L_xma4=1.0
.param W_xma3=5.0 L_xma3=1.0
.param W_xm5=5.0 L_xm5=1.0
.param W_xm6=5.0 L_xm6=1.0
.param W_xm7=5.0 L_xm7=1.0
.param W_xma1=5.0 L_xma1=1.0
.param W_xma2=5.0 L_xma2=1.0
.param W_xmsu4=5.0 L_xmsu4=1.0
.param W_xm8=5.0 L_xm8=1.0
.param W_xm9=5.0 L_xm9=1.0
.param W_xm10=5.0 L_xm10=1.0
.param W_xm11=5.0 L_xm11=1.0
.param W_xm12=5.0 L_xm12=1.0
.param W_xm13=5.0 L_xm13=1.0
.param W_xm14=5.0 L_xm14=1.0
.param W_xm15=5.0 L_xm15=1.0
.param W_xma5=5.0 L_xma5=1.0
.param W_xma6=5.0 L_xma6=1.0
.param W_xma7=5.0 L_xma7=1.0
.param W_xma8=5.0 L_xma8=1.0
.param W_xma9=5.0 L_xma9=1.0
.param W_xma10=5.0 L_xma10=1.0
.param W_xma11=5.0 L_xma11=1.0
.param W_xma12=5.0 L_xma12=1.0
.param W_xm16=5.0 L_xm16=1.0
.param W_xm17=5.0 L_xm17=1.0
.param W_xm18=5.0 L_xm18=1.0

* Power Supply
VDD VDD 0 1.8

* Input Source (PMOS input requires DC level near 1.2 V for saturation, adjusted to 0.9V for proper bias)
Vin in 0 dc 0.9 ac 1
Iout 0 out dc 0 ac 0

* Nodesets to assist bias circuit startup and main amplifier convergence
.nodeset V(X_U1.Vbiasp)=0.5
.nodeset V(X_U1.N003)=0.6
.nodeset V(X_U1.N004)=0.6
.nodeset V(X_U1.N001)=1.0
.nodeset V(X_U1.N002)=0.0
.nodeset V(X_U1.Vbias1)=1.0
.nodeset V(X_U1.Vbias2)=1.0
.nodeset V(X_U1.Vbias3)=0.6
.nodeset V(X_U1.Vbias4)=1.2
.nodeset V(X_U1.Vhigh)=1.4
.nodeset V(X_U1.Vlow)=0.6
.nodeset V(X_U1.Vpcas)=0.6
.nodeset V(X_U1.Vncas)=1.2
.nodeset V(out)=0.9
.nodeset V(N001)=1.7
.nodeset V(N003)=0.6
.nodeset V(N002)=0.9

* DUT Instance
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xmr3 N003 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xmr3} l={L_xmr3}
xm1 N003 in N001 N001 sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
xm2 N002 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
Cload out 0 1e-11
xmrl N002 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmrl} l={L_xmrl}
xmsf 0 N002 out out sky130_fd_pr__pfet_01v8 w={W_xmsf} l={L_xmsf}
xmsl out Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsl} l={L_xmsl}
R1 VDD N001 1000.0
R2 out N001 9000.0

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
  * Measure Power Dissipation
  dc VDD 1.8 1.8 1
  let pwr = -i(VDD) * 1.8
  meas dc power_dissipation find pwr at=1.8
  print power_dissipation

  * First AC sim: Vin ac=1, Iout ac=0
  ac dec 10 1 1G

  let acl = v(out)/v(in)
  let beta = v(N001)/v(out)
  let aol = v(out)/(v(in) - v(N001))
  let t = aol * beta

  let acl_mag = mag(acl)
  let beta_mag = mag(beta)
  let aol_mag = mag(aol)
  let t_mag = mag(t)

  meas ac closed_loop_gain find acl_mag at=100
  meas ac feedback_factor find beta_mag at=100
  meas ac open_loop_gain find aol_mag at=100
  meas ac loop_gain find t_mag at=100

  let acl_db = db(acl)
  meas ac acl_db_max max acl_db
  let target_db = $&acl_db_max - 3
  meas ac closed_loop_bandwidth when acl_db=target_db fall=1

  print closed_loop_gain
  print feedback_factor
  print open_loop_gain
  print loop_gain
  print closed_loop_bandwidth

  * Second AC sim: Vin ac=0, Iout ac=1
  alter Vin ac=0
  alter Iout ac=1
  ac dec 10 1 1G
  
  let rout = mag(v(out))
  meas ac closed_loop_output_resistance find rout at=100
  print closed_loop_output_resistance
.endc

.end