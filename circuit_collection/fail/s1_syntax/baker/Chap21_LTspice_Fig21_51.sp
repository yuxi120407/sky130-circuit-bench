* Class AB Amplifier Testbench
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
.param L_xmn=0.5
.param L_xmn1=0.5
.param L_xmon=0.5
.param L_xmop=0.5
.param L_xmp=0.5
.param L_xmp1=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param L_xmsu4=0.5

* Define parameters for the parameterized netlist
.param W_xm2=10 L_xm2=1
.param W_xmn=10 L_xmn=1
.param W_xm6b=20 L_xm6b=1
.param W_xmp=20 L_xmp=1
.param W_xmp1=20 L_xmp1=1
.param W_xmn1=10 L_xmn1=1
.param W_xmop=40 L_xmop=1
.param W_xmon=20 L_xmon=1
.param W_xmsu2=20 L_xmsu2=1
.param W_xmsu1=10 L_xmsu1=1
.param W_xmsu3=10 L_xmsu3=1
.param W_xm3=20 L_xm3=1
.param W_xm4=20 L_xm4=1
.param W_xm1=10 L_xm1=1
.param W_xma4=20 L_xma4=1
.param W_xma3=20 L_xma3=1
.param W_xm5=10 L_xm5=1
.param W_xm6=10 L_xm6=1
.param W_xm7=20 L_xm7=1
.param W_xma1=20 L_xma1=1
.param W_xma2=20 L_xma2=1
.param W_xmsu4=10 L_xmsu4=1
.param W_xm8=10 L_xm8=1
.param W_xm9=10 L_xm9=1
.param W_xm10=10 L_xm10=1
.param W_xm11=10 L_xm11=1
.param W_xm12=10 L_xm12=1
.param W_xm13=10 L_xm13=1
.param W_xm14=10 L_xm14=1
.param W_xm15=10 L_xm15=1
.param W_xma5=20 L_xma5=1
.param W_xma6=20 L_xma6=1
.param W_xma7=20 L_xma7=1
.param W_xma8=20 L_xma8=1
.param W_xma9=20 L_xma9=1
.param W_xma10=20 L_xma10=1
.param W_xma11=20 L_xma11=1
.param W_xma12=20 L_xma12=1
.param W_xm16=10 L_xm16=1
.param W_xm17=10 L_xm17=1
.param W_xm18=10 L_xm18=1

* DUT Netlist
VDD VDD 0 1.8
xm2 N004 Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xmn N003 Vbias3 N004 0 sky130_fd_pr__nfet_01v8 w={W_xmn} l={L_xmn}
xm6b N001 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6b} l={L_xm6b}
xmp N002 Vbias2 N001 VDD sky130_fd_pr__pfet_01v8 w={W_xmp} l={L_xmp}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xmp1 N003 Vpcas N002 VDD sky130_fd_pr__pfet_01v8 w={W_xmp1} l={L_xmp1}
xmn1 N002 Vncas N003 0 sky130_fd_pr__nfet_01v8 w={W_xmn1} l={L_xmn1}
xmop Out N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmop} l={L_xmop}
xmon Out N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xmon} l={L_xmon}

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

* Load capacitor
CL Out 0 1p

* Switch control voltages
V_tbias T_bias 0 dc 1
V_tac T_ac 0 dc 0
V_ttran T_tran 0 dc 0

* Bias finding path
E_err Vbias_exact 0 VALUE={0.9}

* AC path
V_dc_bias V_dc_bias_node 0 dc 0.9
V_ac_source V_ac V_dc_bias_node dc 0 ac 1

* TRAN path (Closed loop unity gain for non-inverting amplifier)
E_tran V_tran 0 VALUE={V(Vstim) - V(Out) + V(V_dc_bias_node)}
Vstim Vstim 0 dc 0.9 pulse(0.4 1.4 10n 0.1n 0.1n 5u 10u)

* Switches
S_bias Vin Vbias_exact T_bias 0 switch_model
S_ac Vin V_ac T_ac 0 switch_model
S_tran Vin V_tran T_tran 0 switch_model
.model switch_model sw vt=0.5 ron=1 roff=1T

.control
  * 1. Find exact DC bias
  alter @V_tbias[dc] = 1
  alter @V_tac[dc] = 0
  alter @V_ttran[dc] = 0
  op
  let v_trip = v(Vbias_exact)
  
  * 2. AC Analysis
  alter @V_dc_bias[dc] = $&v_trip
  alter @V_tbias[dc] = 0
  alter @V_tac[dc] = 1
  alter @V_ttran[dc] = 0
  ac dec 100 1 10G
  
  meas ac small_signal_gain max vdb(Out)
  let gain_minus_3 = small_signal_gain - 3
  meas ac dominant_pole when vdb(Out)=$&gain_minus_3 fall=1
  meas ac unity_gain_frequency when vdb(Out)=0 fall=1
  
  * 3. Transient Analysis
  alter @V_tbias[dc] = 0
  alter @V_tac[dc] = 0
  alter @V_ttran[dc] = 1
  tran 1n 10u
  
  let dvout = deriv(v(Out))
  meas tran max_dv max dvout
  meas tran min_dv min dvout
  
  let sr_max = max_dv / 1e6
  let sr_min_abs = -min_dv / 1e6
  let slew_rate = sr_max > sr_min_abs ? sr_max : sr_min_abs
  
  print small_signal_gain dominant_pole unity_gain_frequency slew_rate
  quit
.endc
.end