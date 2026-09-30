* Testbench for Baker Fig 21.8 CS Amplifier with Diode-Connected Load
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

* Parameters for sizing
.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=30.0 L_xm2=1.0
.param W_xmsu1=10.0 L_xmsu1=1.0
.param W_xmsu2=30.0 L_xmsu2=1.0
.param W_xmsu3=10.0 L_xmsu3=1.0
.param W_xm3=30.0 L_xm3=1.0
.param W_xm4=30.0 L_xm4=1.0
.param W_xm5=30.0 L_xm5=1.0
.param W_xm6=10.0 L_xm6=1.0
.param W_xm7=30.0 L_xm7=1.0
.param W_xm8=10.0 L_xm8=1.0
.param W_xm9=30.0 L_xm9=1.0
.param W_xm10=30.0 L_xm10=1.0
.param W_xm11=30.0 L_xm11=1.0
.param W_xm12=10.0 L_xm12=1.0
.param W_xm13=10.0 L_xm13=1.0
.param W_xm14=10.0 L_xm14=1.0
.param W_xm15=30.0 L_xm15=1.0
.param W_xm16=30.0 L_xm16=1.0
.param W_xm17=30.0 L_xm17=1.0
.param W_xm18=30.0 L_xm18=1.0
.param W_xm19=30.0 L_xm19=1.0
.param W_xm20=30.0 L_xm20=1.0
.param W_xm21=30.0 L_xm21=1.0
.param W_xm22=10.0 L_xm22=1.0
.param W_xm23=10.0 L_xm23=1.0
.param W_xm24=10.0 L_xm24=1.0
.param W_xm25=10.0 L_xm25=1.0
.param W_xm26=10.0 L_xm26=1.0

* Circuit instantiation
VDD VDD 0 1.8
Vs Vs 0 dc 0 ac 1 sin(0 1m 400MEG)

xm1 Vout Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 Vout Vout VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
R1 Vbias4 Vin 1000000000.0
C1 Vin N001 1e-06
RS Vs N001 100000.0

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

.control
  * 1. Operating Point Analysis
  op
  let dc_output_voltage = v(vout)
  let quiescent_current = @m.xm1.msky130_fd_pr__nfet_01v8[id]
  print dc_output_voltage quiescent_current

  * 2. AC Frequency Analysis
  ac dec 100 10k 100T
  
  let gain_db = vdb(vout)
  let phase_deg = 180/PI * cph(v(vout))
  
  * Low frequency gain at 100 kHz
  meas ac low_frequency_gain find gain_db at=100k
  
  * Input pole frequency (gain down 3dB from low freq)
  let vin_db = vdb(vin)
  meas ac lf_vin_db find vin_db at=100k
  let vin_3db = lf_vin_db - 3.0
  meas ac input_pole_frequency when vin_db=vin_3db fall=1
  
  * Output pole frequency
  let stage_gain_db = vdb(vout) - vdb(vin)
  meas ac lf_stage_gain_db find stage_gain_db at=100k
  let stage_gain_3db = lf_stage_gain_db - 3.0
  let output_pole_frequency = -1
  meas ac output_pole_frequency when stage_gain_db=stage_gain_3db fall=1
  
  * RHP zero frequency
  let stage_phase = 180/PI * (cph(v(vout)) - cph(v(vin)))
  meas ac lf_stage_phase find stage_phase at=100k
  let target_phase = lf_stage_phase - 135.0
  meas ac rhp_zero_frequency when stage_phase=target_phase fall=1
  
  * Gain and Phase at 400 MHz
  meas ac gain_at_400mhz find gain_db at=400MEG
  meas ac phase_at_400mhz find phase_deg at=400MEG
  
  * 3. Transient simulation verifying time-domain behavior at 400 MHz
  tran 50p 100n
  meas tran vout_p2p pp v(vout) from=95n to=100n
  meas tran vin_p2p pp v(vs) from=95n to=100n
  
  print low_frequency_gain
  print input_pole_frequency
  print output_pole_frequency
  print rhp_zero_frequency
  print gain_at_400mhz
  print phase_at_400mhz
  quit
.endc
.end