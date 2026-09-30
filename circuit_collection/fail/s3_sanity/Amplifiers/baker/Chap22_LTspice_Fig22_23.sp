* Testbench for Diff-Amp with Current Mirror Load (Baker Ch 22)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm11_sub=0.5
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
.param L_xm21_sub=0.5
.param L_xm22=0.5
.param L_xm23=0.5
.param L_xm24=0.5
.param L_xm25=0.5
.param L_xm26=0.5
.param L_xm3=0.5
.param L_xm31=0.5
.param L_xm4=0.5
.param L_xm41=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xmissl=0.5
.param L_xmissr=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param W_xm10=5.0
.param W_xm11_sub=5.0
.param W_xm13=5.0
.param W_xm14=5.0
.param W_xm16=5.0
.param W_xm17=5.0
.param W_xm19=5.0
.param W_xm20=5.0
.param W_xm22=5.0
.param W_xm23=5.0
.param W_xm25=5.0
.param W_xm26=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xmsu2=5.0
.param W_xmsu3=5.0

* Default transistor dimensions
.param W_xmissl=10.0 L_xmissl=1.0
.param W_xmissr=10.0 L_xmissr=1.0
.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=10.0 L_xm2=1.0
.param W_xm3=10.0 L_xm3=1.0
.param W_xm4=10.0 L_xm4=1.0
.param W_xm11=10.0 L_xm11=1.0
.param W_xm21=10.0 L_xm21=1.0
.param W_xm31=10.0 L_xm31=1.0
.param W_xm41=10.0 L_xm41=1.0

* Subcircuit parameter defaults
.param W_xmsu1=5.0 L_xmsu1=1.0 W_xmsu2=5.0 L_xmsu2=1.0 W_xmsu3=5.0 L_xmsu3=1.0
.param W_xm5=5.0 L_xm5=1.0 W_xm6=5.0 L_xm6=1.0 W_xm7=5.0 L_xm7=1.0 W_xm8=5.0 L_xm8=1.0
.param W_xm9=5.0 L_xm9=1.0 W_xm10=5.0 L_xm10=1.0 W_xm11_sub=5.0 L_xm11_sub=1.0
.param W_xm12=5.0 L_xm12=1.0 W_xm13=5.0 L_xm13=1.0 W_xm14=5.0 L_xm14=1.0
.param W_xm15=5.0 L_xm15=1.0 W_xm16=5.0 L_xm16=1.0 W_xm17=5.0 L_xm17=1.0
.param W_xm18=5.0 L_xm18=1.0 W_xm19=5.0 L_xm19=1.0 W_xm20=5.0 L_xm20=1.0
.param W_xm21_sub=5.0 L_xm21_sub=1.0 W_xm22=5.0 L_xm22=1.0 W_xm23=5.0 L_xm23=1.0
.param W_xm24=5.0 L_xm24=1.0 W_xm25=5.0 L_xm25=1.0 W_xm26=5.0 L_xm26=1.0

* DUT Circuit
VDD VDD 0 1.8
xmissl N1 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xmissl} l={L_xmissl}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xm1 VDD VI1 N003 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 VDD VI2 N004 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}

* Stimuli
VCM VCM 0 dc 0.9 ac 0
Vdiff Vdiff 0 dc 0 ac 0
E1 VI1 0 POLY(2) VCM 0 Vdiff 0 0 1 0.5
E2 VI2 0 POLY(2) VCM 0 Vdiff 0 0 1 -0.5

xm4 0 N1 N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 0 N2 N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm41 N1 N1 N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm41} l={L_xm41}
xm11 VDD VI1 N001 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
xmissr N2 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xmissr} l={L_xmissr}
xm31 N2 N2 N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm31} l={L_xm31}
xm21 VDD VI2 N002 0 sky130_fd_pr__nfet_01v8 w={W_xm21} l={L_xm21}

* Load capacitor on output branch
CL N1 0 1p

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
  xm11 Vncas Vbias2 Vhigh VDD sky130_fd_pr__pfet_01v8 w={W_xm11_sub} l={L_xm11_sub}
  xm12 Vncas Vncas N009 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
  xm13 N009 Vbias3 N010 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
  xm14 N010 N009 GND 0 sky130_fd_pr__nfet_01v8 w={W_xm14} l={L_xm14}
  xm15 N006 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm15} l={L_xm15}
  xm16 Vbias3 Vbias2 N006 VDD sky130_fd_pr__pfet_01v8 w={W_xm16} l={L_xm16}
  xm17 N007 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm17} l={L_xm17}
  xm18 Vbias4 Vbias2 N007 VDD sky130_fd_pr__pfet_01v8 w={W_xm18} l={L_xm18}
  xm19 N008 N004 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm19} l={L_xm19}
  xm20 N004 Vbias2 N008 VDD sky130_fd_pr__pfet_01v8 w={W_xm20} l={L_xm20}
  xm21 Vpcas Vpcas N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm21_sub} l={L_xm21_sub}
  xm22 Vbias3 Vbias3 0 0 sky130_fd_pr__nfet_01v8 w={W_xm22} l={L_xm22}
  xm23 Vpcas Vbias3 N011 0 sky130_fd_pr__nfet_01v8 w={W_xm23} l={L_xm23}
  xm24 N011 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm24} l={L_xm24}
  xm25 Vbias4 Vbias3 Vlow 0 sky130_fd_pr__nfet_01v8 w={W_xm25} l={L_xm25}
  xm26 Vlow Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm26} l={L_xm26}
.ends SUB_1

.control
  let differential_mode_gain = 0
  let cutoff_frequency_3db = 0
  let common_mode_gain = 0
  let cmrr = 0
  let input_referred_noise = 0
  let max_output_voltage = 0
  let min_output_voltage = 0
  let input_referred_offset = 0
  let max_input_cm_voltage = 0
  let min_vdd = 0

  set diff_gain_val = 0
  set cm_gain_val = 0

  * 1. Differential AC Analysis
  alter Vdiff ac 1
  alter VCM ac 0
  ac dec 10 1 1G
  let vout_db = vdb(N1)
  meas ac differential_mode_gain find vout_db at=10
  set diff_gain_val = $&differential_mode_gain
  let target_gain = differential_mode_gain - 3
  meas ac cutoff_frequency_3db when vout_db="$&target_gain" fall=1
  print differential_mode_gain cutoff_frequency_3db

  * 2. Common Mode AC Analysis
  alter Vdiff ac 0
  alter VCM ac 1
  ac dec 10 1 1G
  let vout_cm_db = vdb(N1)
  meas ac common_mode_gain find vout_cm_db at=10
  set cm_gain_val = $&common_mode_gain
  let cmrr = $diff_gain_val - $cm_gain_val
  print common_mode_gain cmrr

  * 3. Noise Analysis
  alter Vdiff ac 1
  alter VCM ac 0
  noise v(N1, 0) Vdiff dec 10 1k 100Meg
  setplot noise2
  let input_referred_noise = inoise_total
  print input_referred_noise

  * 4. DC Sweep for Transfer Characteristics and Output Swing
  alter Vdiff ac 0
  dc Vdiff -1.8 1.8 0.01
  meas dc max_output_voltage max v(N1)
  meas dc min_output_voltage min v(N1)
  let mid_out = (max_output_voltage + min_output_voltage)/2
  meas dc input_referred_offset when v(N1)="$&mid_out"
  print max_output_voltage min_output_voltage input_referred_offset

  * 5. DC Sweep for Input Common-Mode Range
  alter Vdiff dc 0
  dc VCM 0 1.8 0.01
  meas dc max_out_cm max v(N1)
  meas dc min_out_cm min v(N1)
  let mid_out_cm = (max_out_cm + min_out_cm)/2
  meas dc max_input_cm_voltage when v(N1)="$&mid_out_cm"
  print max_input_cm_voltage

  * 6. DC Sweep for Min VDD
  alter VCM dc 0.9
  dc VDD 0 1.8 0.01
  meas dc max_out_vdd max v(N1)
  meas dc min_out_vdd min v(N1)
  let mid_out_vdd = (max_out_vdd + min_out_vdd)/2
  meas dc min_vdd when v(N1)="$&mid_out_vdd"
  print min_vdd

  quit
.endc
.end