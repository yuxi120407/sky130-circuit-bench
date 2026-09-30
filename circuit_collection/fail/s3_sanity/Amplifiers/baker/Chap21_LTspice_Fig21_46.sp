* Testbench for Cascode Amplifier with Source Follower
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
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param L_xmsu4=0.5

* Define parameters used in the netlist
.param W_xm1=10 L_xm1=1
.param W_xm2=10 L_xm2=1
.param W_xm3=20 L_xm3=1
.param W_xm4=20 L_xm4=1
.param W_xm5=20 L_xm5=1
.param W_xm6=20 L_xm6=1
.param W_xm7=20 L_xm7=1
.param W_xmsu1=10 L_xmsu1=1
.param W_xmsu2=20 L_xmsu2=1
.param W_xmsu3=10 L_xmsu3=1
.param W_xmsu4=10 L_xmsu4=1
.param W_xma1=20 L_xma1=1
.param W_xma2=20 L_xma2=1
.param W_xma3=20 L_xma3=1
.param W_xma4=20 L_xma4=1
.param W_xma5=20 L_xma5=1
.param W_xma6=20 L_xma6=1
.param W_xma7=20 L_xma7=1
.param W_xma8=20 L_xma8=1
.param W_xma9=20 L_xma9=1
.param W_xma10=20 L_xma10=1
.param W_xma11=20 L_xma11=1
.param W_xma12=20 L_xma12=1
.param W_xm8=10 L_xm8=1
.param W_xm9=10 L_xm9=1
.param W_xm10=10 L_xm10=1
.param W_xm11=10 L_xm11=1
.param W_xm12=10 L_xm12=1
.param W_xm13=10 L_xm13=1
.param W_xm14=10 L_xm14=1
.param W_xm15=10 L_xm15=1
.param W_xm16=10 L_xm16=1
.param W_xm17=10 L_xm17=1
.param W_xm18=10 L_xm18=1

* Input source (AC coupled via RS and Cbig in netlist)
Vin N006 0 dc 0 ac 1 pulse(0 0.1 1n 1n 1n 1u 2u)
Iout 0 Vout dc 0 ac 0
Icg 0 N005 dc 0 ac 0

* --- DUT Netlist ---
VDD VDD 0 1.8
xm1 N005 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 N004 Vbias3 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm4 N001 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 N004 Vbias2 N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
RS N006 P001 100000.0
Rbig N003 N004 1000000000.0
Cbig P001 N003 1e-06
xm5 N002 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
xm6 Vout Vbias2 N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
Cload1 Vout 0 1e-12
xm7 0 N004 Vout Vout sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
R1 Vout 0 10000.0

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
* --- End DUT Netlist ---

.control
  * Initialize variables to prevent print errors if meas fails
  let generic_adc = 0
  let generic_f3db = 0
  let generic_pole1 = 0
  let pole1_splitting = 0
  let unity_gain_freq = 0
  let pole2_splitting = 0
  let generic_pole2 = 0
  let zero_freq = 0
  let generic_zero = 0
  let max_in = 0
  let input_pole = 0
  let max_out = 0
  let output_pole = 0
  let source_follower_gain = 0
  let cg_gain = 0
  let cs_small_signal_gain = 0
  let open_circuit_gain = 0
  let cin_miller = 0
  let tf_magnitude = 0
  let tf_phase = 0
  let source_follower_rout = 0
  let cout_miller = 0
  let cg_input_resistance = 0
  let input_referred_noise_psd = 0
  let v1 = 0
  let v2 = 0
  let slew_rate = 0

  * DC Operating Point
  op
  let power = -i(VDD) * 1.8
  print power

  * AC Analysis 1: Normal operation
  ac dec 100 1 1G
  
  let vout_mag = mag(v(Vout))
  let vout_ph = ph(v(Vout))*180/3.14159265359
  
  meas ac generic_adc max vout_mag
  let f3db_val = $&generic_adc / sqrt(2)
  meas ac generic_f3db when vout_mag=$&f3db_val fall=1
  meas ac generic_pole1 when vout_mag=$&f3db_val fall=1
  meas ac pole1_splitting when vout_mag=$&f3db_val fall=1
  
  meas ac unity_gain_freq when vout_mag=1 fall=1
  meas ac pole2_splitting when vout_ph=-135 fall=1
  meas ac generic_pole2 when vout_ph=-135 fall=1
  
  meas ac zero_freq when vout_ph=0 rise=1
  meas ac generic_zero when vout_ph=0 rise=1
  
  let in_mag = mag(v(N003))
  meas ac max_in max in_mag
  let in_f3db = $&max_in / sqrt(2)
  meas ac input_pole when in_mag=$&in_f3db fall=1
  
  let out_mag = mag(v(N004))
  meas ac max_out max out_mag
  let out_f3db = $&max_out / sqrt(2)
  meas ac output_pole when out_mag=$&out_f3db fall=1
  
  let sf_gain_vec = mag(v(Vout)/v(N004))
  meas ac source_follower_gain find sf_gain_vec at=1k
  
  let cg_gain_vec = mag(v(N004)/v(N005))
  meas ac cg_gain find cg_gain_vec at=1k
  
  let cs_gain_vec = mag(v(N005)/v(N003))
  meas ac cs_small_signal_gain find cs_gain_vec at=1k
  
  let oc_gain_vec = mag(v(N004)/v(N003))
  meas ac open_circuit_gain find oc_gain_vec at=1k
  
  let omega = 2 * 3.14159265359 * frequency
  let Y_in = (v(N006) - v(P001)) / (100000.0 * v(N003))
  let cin_vec = imag(Y_in) / omega
  meas ac cin_miller find cin_vec at=1k
  
  meas ac tf_magnitude find vout_mag at=1k
  meas ac tf_phase find vout_ph at=1k

  print generic_adc generic_f3db generic_pole1 pole1_splitting unity_gain_freq pole2_splitting generic_pole2 zero_freq generic_zero input_pole output_pole source_follower_gain cg_gain cs_small_signal_gain open_circuit_gain cin_miller tf_magnitude tf_phase

  * AC Analysis 2: Rout and Cout
  alter Vin acmag=0
  alter Iout acmag=1
  ac dec 100 1 1G
  
  let rout_mag = mag(v(Vout))
  meas ac source_follower_rout find rout_mag at=1k
  
  let omega2 = 2 * 3.14159265359 * frequency
  let Y_out = 1 / v(Vout)
  let cout_vec = imag(Y_out) / omega2
  meas ac cout_miller find cout_vec at=1k
  
  print source_follower_rout cout_miller

  * AC Analysis 3: CG input resistance
  alter Iout acmag=0
  alter Icg acmag=1
  ac dec 100 1 1G
  
  let cg_rin_mag = mag(v(N005))
  meas ac cg_input_resistance find cg_rin_mag at=1k
  
  print cg_input_resistance

  * Noise Analysis
  alter Icg acmag=0
  alter Vin acmag=1
  noise v(Vout) Vin dec 10 1 1G
  
  meas noise input_referred_noise_psd find inoise_spectrum at=1k
  print input_referred_noise_psd

  * Transient Analysis
  tran 1n 2u
  
  meas tran v1 find v(Vout) at=1.1n
  meas tran v2 find v(Vout) at=1.9n
  let slew_rate = ($&v2 - $&v1) / 0.8e-9 / 1e6
  
  print slew_rate

  quit
.endc
.end