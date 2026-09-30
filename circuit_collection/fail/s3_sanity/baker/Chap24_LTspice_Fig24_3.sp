* Op-Amp Testbench for Sky130
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
.param L_xm7_b=0.5
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

* Default W/L parameters for DUT
.param W_xm1=10.0  L_xm1=0.5
.param W_xm2=10.0  L_xm2=0.5
.param W_xm3=10.0  L_xm3=0.5
.param W_xm4=10.0  L_xm4=0.5
.param W_xm6t=10.0 L_xm6t=0.5
.param W_xm6b=10.0 L_xm6b=0.5
.param W_xm7=50.0  L_xm7=0.5
.param W_xm8t=10.0 L_xm8t=0.5
.param W_xm8b=10.0 L_xm8b=0.5

* Bias generator SUB_1 parameters
.param W_xmsu1=5.0  L_xmsu1=0.5
.param W_xmsu2=10.0 L_xmsu2=0.5
.param W_xmsu3=5.0  L_xmsu3=0.5
.param W_xmsu4=5.0  L_xmsu4=0.5
.param W_xma1=10.0  L_xma1=0.5
.param W_xma2=10.0  L_xma2=0.5
.param W_xma3=10.0  L_xma3=0.5
.param W_xma4=10.0  L_xma4=0.5
.param W_xma5=10.0  L_xma5=0.5
.param W_xma6=10.0  L_xma6=0.5
.param W_xma7=10.0  L_xma7=0.5
.param W_xma8=10.0  L_xma8=0.5
.param W_xma9=10.0  L_xma9=0.5
.param W_xma10=10.0 L_xma10=0.5
.param W_xma11=10.0 L_xma11=0.5
.param W_xma12=10.0 L_xma12=0.5
.param W_xm5=5.0    L_xm5=0.5
.param W_xm6=5.0    L_xm6=0.5
.param W_xm7_b=10.0 L_xm7_b=0.5
.param W_xm8=5.0    L_xm8=0.5
.param W_xm9=5.0    L_xm9=0.5
.param W_xm10=5.0   L_xm10=0.5
.param W_xm11=5.0   L_xm11=0.5
.param W_xm12=5.0   L_xm12=0.5
.param W_xm13=5.0   L_xm13=0.5
.param W_xm14=5.0   L_xm14=0.5
.param W_xm15=5.0   L_xm15=0.5
.param W_xm16=5.0   L_xm16=0.5
.param W_xm17=5.0   L_xm17=0.5
.param W_xm18=5.0   L_xm18=0.5

* Supply
VDD VDD 0 1.8

* Op-Amp Core Netlist (DUT)
xm2 N002 vp N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 vm N003 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xm6t N003 Vbias3 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm6t} l={L_xm6t}
xm6b N004 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6b} l={L_xm6b}
xm7 vout N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8t vout Vbias3 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm8t} l={L_xm8t}
xm8b N005 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8b} l={L_xm8b}

* Miller Compensation & Load (Fig 24.8 & Fig 24.13)
Rz N002 n_cc 6.5k
Cc n_cc vout 2.4p
CL vout 0 100f

* Open-loop AC simulation setup with DC feedback (Fig 24.9)
Vp_src vp 0 DC 0.9 AC 1
Rf vout vm 100MEG
Cf vm 0 10u
Iload vout 0 DC 0

* Subcircuit Definition
.subckt SUB_1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 N003 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm4 N004 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xm1 N003 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
  xm2 N004 N004 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
  R1 N005 GND 5.5k
  xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm5 N001 N004 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
  xm6 Vbiasp N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
  xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7_b} l={L_xm7_b}
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

* Control Script
.control
  op
  let power_dissipation = -i(VDD) * 1.8
  print power_dissipation

  * AC open-loop simulation
  ac dec 100 1 100G
  let gain_db = vdb(vout)
  let phase = 180/PI * cph(v(vout))
  let slope = deriv(gain_db) * frequency * 2.302585
  
  meas ac open_loop_dc_gain find gain_db at=1
  let gain_3db_db_val = open_loop_dc_gain[0] - 3
  set g3db = $&gain_3db_db_val
  meas ac dominant_pole_frequency when gain_db=$g3db fall=1
  
  meas ac rhp_zero_frequency when slope=-10 rise=1
  meas ac second_pole_frequency when slope=-10 fall=2
  
  meas ac unity_gain_frequency when gain_db=0 fall=1
  meas ac phase_at_unity find phase when gain_db=0 fall=1
  let phase_margin = 180 + phase_at_unity
  
  print open_loop_dc_gain dominant_pole_frequency second_pole_frequency rhp_zero_frequency unity_gain_frequency phase_margin

  * DC Transfer Characteristic for Output Swing and Systematic Offset
  dc Vp_src 0 1.8 0.01
  let dvout = deriv(v(vout))
  meas dc output_swing_low find v(vout) when dvout=0.5 rise=1
  meas dc output_swing_high find v(vout) when dvout=0.5 fall=1
  meas dc vp_mid when v(vout)=0.9
  let systematic_offset_voltage = vp_mid[0] - 0.9
  
  print output_swing_low output_swing_high systematic_offset_voltage

  * DC Sweep for Max Sink Current
  dc Iload 0 -5m -10u
  meas dc max_sink_current_neg when v(vout)=1.0
  let max_sink_current = -max_sink_current_neg[0]
  
  print max_sink_current

  quit
.endc
.end