* Testbench for Series-Shunt Feedback Amplifier
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
.param L_xmr1=0.5
.param L_xmr3=0.5
.param L_xmrl=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param L_xmsu4=0.5

* Parameters for DUT
.param W_xmr1=10 L_xmr1=1
.param W_xmr3=5 L_xmr3=1
.param W_xm1=20 L_xm1=1
.param W_xm2=5 L_xm2=1
.param W_xmrl=10 L_xmrl=1
.param W_xmsu2=10 L_xmsu2=1
.param W_xmsu1=5 L_xmsu1=1
.param W_xmsu3=5 L_xmsu3=1
.param W_xm3=10 L_xm3=1
.param W_xm4=10 L_xm4=1
.param W_xma4=10 L_xma4=1
.param W_xma3=10 L_xma3=1
.param W_xm5=5 L_xm5=1
.param W_xm6=5 L_xm6=1
.param W_xm7=10 L_xm7=1
.param W_xma1=10 L_xma1=1
.param W_xma2=10 L_xma2=1
.param W_xmsu4=5 L_xmsu4=1
.param W_xm8=5 L_xm8=1
.param W_xm9=5 L_xm9=1
.param W_xm10=5 L_xm10=1
.param W_xm11=5 L_xm11=1
.param W_xm12=5 L_xm12=1
.param W_xm13=5 L_xm13=1
.param W_xm14=5 L_xm14=1
.param W_xm15=5 L_xm15=1
.param W_xma5=10 L_xma5=1
.param W_xma6=10 L_xma6=1
.param W_xma7=10 L_xma7=1
.param W_xma8=10 L_xma8=1
.param W_xma9=10 L_xma9=1
.param W_xma10=10 L_xma10=1
.param W_xma11=10 L_xma11=1
.param W_xma12=10 L_xma12=1
.param W_xm16=5 L_xm16=1
.param W_xm17=5 L_xm17=1
.param W_xm18=5 L_xm18=1

* DUT
VDD VDD 0 1.8
xmr1 out Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmr1} l={L_xmr1}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xmr3 N001 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xmr3} l={L_xmr3}
xm1 N001 in out out sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
xm2 out N001 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
Cload out 0 1e-11
xmrl out Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmrl} l={L_xmrl}

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
Vin in 0 DC 0.5 AC 1
Iout 0 out AC 0
Vb1 Vbias1 0 0.8
Vb4 Vbias4 0 0.8

.control
  op
  let power = -i(VDD) * 1.8
  print power

  ac dec 10 0.1 1G
  
  let acl_mag = mag(v(out) / v(in))
  meas ac closed_loop_gain_ACL find acl_mag at=0.1
  
  let aol_mag = mag(v(out) / (v(in) - v(out)))
  meas ac open_loop_gain_AOL find aol_mag at=0.1
  
  let beta_mag = mag(v(out) / v(out))
  meas ac feedback_factor_beta find beta_mag at=0.1
  
  let rinf_mag = mag(v(in) / -i(Vin))
  meas ac closed_loop_input_resistance_Rinf find rinf_mag at=0.1

  alter @Vin[acmag] = 0
  alter @Iout[acmag] = 1
  ac dec 10 0.1 1G
  
  let rout_mag = mag(v(out))
  meas ac closed_loop_output_resistance_Rout find rout_mag at=0.1

  print closed_loop_gain_ACL open_loop_gain_AOL feedback_factor_beta closed_loop_input_resistance_Rinf closed_loop_output_resistance_Rout
.endc
.end