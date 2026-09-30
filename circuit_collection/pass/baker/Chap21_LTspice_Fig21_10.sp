* Testbench for Baker Fig 21.8 Common-Source Amplifier with Gate-Drain Load
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
.param L_xm19=0.5
.param L_xm2=0.5
.param L_xm20=0.5
.param L_xm21=0.5
.param L_xm22=0.5
.param L_xm23=0.5
.param L_xm24=0.5
.param L_xm25=0.5
.param L_xm26=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5

* Parameter definitions for devices
.param W_xm1=4.2 L_xm1=1.0
.param W_xm2=12.6 L_xm2=1.0
.param W_xmsu1=2.0 L_xmsu1=1.0
.param W_xmsu2=4.0 L_xmsu2=1.0
.param W_xmsu3=2.0 L_xmsu3=1.0
.param W_xm3=12.0 L_xm3=1.0
.param W_xm4=12.0 L_xm4=1.0
.param W_xm5=12.0 L_xm5=1.0
.param W_xm6=4.0 L_xm6=1.0
.param W_xm7=12.0 L_xm7=1.0
.param W_xm8=4.0 L_xm8=1.0
.param W_xm9=12.0 L_xm9=1.0
.param W_xm10=12.0 L_xm10=1.0
.param W_xm11=12.0 L_xm11=1.0
.param W_xm12=4.0 L_xm12=1.0
.param W_xm13=4.0 L_xm13=1.0
.param W_xm14=4.0 L_xm14=1.0
.param W_xm15=12.0 L_xm15=1.0
.param W_xm16=12.0 L_xm16=1.0
.param W_xm17=12.0 L_xm17=1.0
.param W_xm18=12.0 L_xm18=1.0
.param W_xm19=12.0 L_xm19=1.0
.param W_xm20=12.0 L_xm20=1.0
.param W_xm21=12.0 L_xm21=1.0
.param W_xm22=4.0 L_xm22=1.0
.param W_xm23=4.0 L_xm23=1.0
.param W_xm24=4.0 L_xm24=1.0
.param W_xm25=4.0 L_xm25=1.0
.param W_xm26=4.0 L_xm26=1.0

* Main Amplifier DUT
VDD VDD 0 1.8
xm1 Vout Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 Vout Vout VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
R1 Vbias4 Vin 1000000000.0
C1 Vin N001 1e-06
RS Vs N001 100000.0

* Input excitation source
Vsig Vs 0 dc 0 ac 1.0 sin(0 1m 400MEG)

* Bias generator subcircuit (Baker Fig 20.43)
.subckt SUB_1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD GND
  xmsu2 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N001 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 N002 N001 Vbiasn 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 Vbiasn N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm1 Vbiasn Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm2 N002 Vbiasn N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  R1 N003 0 6.5k
  xm5 Vbias2 Vbias2 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
  xm6 Vbias2 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
  xm7 N005 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xm8 Vbias1 Vbiasn 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
  xm9 Vbias1 Vbias2 N005 VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
  xm10 Vhigh Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
  xm11 Vncas Vbias2 Vhigh VDD sky130_fd_pr__pfet_01v8 w={W_xm11} l={L_xm11}
  xm12 Vncas Vncas N009 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
  xm13 N009 Vbias3 N010 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
  xm14 N010 N009 GND 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
  xm15 N006 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm15} l={L_xm15}
  xm16 Vbias3 Vbias2 N006 VDD sky130_fd_pr__pfet_01v8 w={W_xm16} l={L_xm16}
  xm17 N007 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm17} l={L_xm17}
  xm18 Vbias4 Vbias2 N007 VDD sky130_fd_pr__pfet_01v8 w={W_xm18} l={L_xm18}
  xm19 N008 N004 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm19} l={L_xm19}
  xm20 N004 Vbias2 N008 VDD sky130_fd_pr__pfet_01v8 w={W_xm20} l={L_xm20}
  xm21 Vpcas Vpcas N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm21} l={L_xm21}
  xm22 Vbias3 Vbias3 0 0 sky130_fd_pr__nfet_01v8 w={W_xm22} l={L_xm22}
  xm23 Vpcas Vbias3 N011 0 sky130_fd_pr__nfet_01v8 w={W_xm23} l={L_xm23}
  xm24 N011 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
  xm25 Vbias4 Vbias3 Vlow 0 sky130_fd_pr__nfet_01v8 w={W_xm25} l={L_xm25}
  xm26 Vlow Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm26} l={L_xm26}
.ends SUB_1

* Control and Analysis
.control
  * 1. DC Operating Point Analysis
  op
  let dc_bias_current = @m.xm1.msky130_fd_pr__nfet_01v8[id]
  let dc_output_voltage = v(vout)
  print dc_bias_current dc_output_voltage

  * 2. AC Frequency Response Analysis
  ac dec 100 1k 100G
  let gain_db = db(v(vout))
  let phase_deg = 180/3.141592653589793 * cph(v(vout))
  
  meas ac dc_phase find phase_deg at=1k
  let phase_norm = phase_deg - dc_phase + 180
  
  meas ac low_frequency_gain find gain_db at=100k
  meas ac input_pole_frequency when phase_norm=135
  meas ac output_pole_frequency when phase_norm=45
  meas ac rhp_zero_frequency when phase_norm=-45
  meas ac gain_at_400MHz find gain_db at=400MEG
  meas ac phase_at_400MHz find phase_deg at=400MEG
  print low_frequency_gain input_pole_frequency output_pole_frequency rhp_zero_frequency gain_at_400MHz phase_at_400MHz

  * 3. Transient Analysis at 400 MHz
  tran 0.01n 100n
  meas tran vout_dc AVG v(vout) from=90n to=100n
  meas tran t_vout_cross WHEN v(vout)=vout_dc rise=last
  meas tran t_vs_cross WHEN v(vs)=0 fall=last
  let time_delay_400MHz = t_vout_cross - t_vs_cross
  print time_delay_400MHz

  * 4. Noise Analysis
  noise v(vout) Vsig dec 20 10k 100MEG
  setplot noise1
  let input_referred_noise = inoise_spectrum[60]
  print input_referred_noise

  quit
.endc
.end