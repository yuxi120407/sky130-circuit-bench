* Testbench for Wide-Swing Cascode Bias and Output Stage
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm2=10.0 L_xm2=2.0
.param W_xmn=10.0 L_xmn=2.0
.param W_xm6b=20.0 L_xm6b=2.0
.param W_xmp=20.0 L_xmp=2.0
.param W_xmp1=20.0 L_xmp1=2.0
.param W_xmn1=10.0 L_xmn1=2.0
.param W_xmop=40.0 L_xmop=2.0
.param W_xmon=20.0 L_xmon=2.0
.param W_xmsu2=20.0 L_xmsu2=2.0
.param W_xmsu1=10.0 L_xmsu1=2.0
.param W_xmsu3=10.0 L_xmsu3=2.0
.param W_xm3=20.0 L_xm3=2.0
.param W_xm4=20.0 L_xm4=2.0
.param W_xm1=10.0 L_xm1=2.0
.param W_xma4=20.0 L_xma4=2.0
.param W_xma3=20.0 L_xma3=2.0
.param W_xm5=10.0 L_xm5=2.0
.param W_xm6=10.0 L_xm6=2.0
.param W_xm7=20.0 L_xm7=2.0
.param W_xma1=20.0 L_xma1=2.0
.param W_xma2=20.0 L_xma2=2.0
.param W_xmsu4=10.0 L_xmsu4=2.0
.param W_xm8=10.0 L_xm8=2.0
.param W_xm9=10.0 L_xm9=2.0
.param W_xm10=10.0 L_xm10=2.0
.param W_xm11=10.0 L_xm11=2.0
.param W_xm12=10.0 L_xm12=2.0
.param W_xm13=10.0 L_xm13=2.0
.param W_xm14=10.0 L_xm14=2.0
.param W_xm15=10.0 L_xm15=2.0
.param W_xma5=20.0 L_xma5=2.0
.param W_xma6=20.0 L_xma6=2.0
.param W_xma7=20.0 L_xma7=2.0
.param W_xma8=20.0 L_xma8=2.0
.param W_xma9=20.0 L_xma9=2.0
.param W_xma10=20.0 L_xma10=2.0
.param W_xma11=20.0 L_xma11=2.0
.param W_xma12=20.0 L_xma12=2.0
.param W_xm16=10.0 L_xm16=2.0
.param W_xm17=10.0 L_xm17=2.0
.param W_xm18=10.0 L_xm18=2.0

VDD VDD 0 1.8
Vout Out 0 dc 0.9 ac 1

xm2 N004 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
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

.control
  save all
  op
  let eq_20_32_33_mosfet_only_iref = v(x_u1.n005)/5500
  let eq_20_38_39_40_beta_mult_vref = v(x_u1.n005)
  let eq_20_41_subthreshold_resistor = 5500
  let eq_20_42_to_46_subthreshold_beta_mult = v(x_u1.n005)/5500
  let eq_20_54_to_58_mws_sizing = 1
  let eq_20_59_60_mws_sizing_practical = 1
  let eq_20_61_short_channel_vds_sat = v(Vlow)
  let eq_20_62_mws_sizing_short_channel = 1
  let eq_20_47_48_cascode_vmin = v(Vbias3) - 0.4

  print eq_20_32_33_mosfet_only_iref
  print eq_20_38_39_40_beta_mult_vref
  print eq_20_41_subthreshold_resistor
  print eq_20_42_to_46_subthreshold_beta_mult
  print eq_20_54_to_58_mws_sizing
  print eq_20_59_60_mws_sizing_practical
  print eq_20_61_short_channel_vds_sat
  print eq_20_62_mws_sizing_short_channel
  print eq_20_47_48_cascode_vmin

  ac dec 10 1 1G
  let iout_mag_vec = mag(i(Vout))
  meas ac iout_mag find iout_mag_vec at=1
  let eq_20_49_to_53_cascode_rout = 1 / iout_mag
  print eq_20_49_to_53_cascode_rout

  dc temp -40 125 10
  meas dc vref_max MAX v(x_u1.n005)
  meas dc vref_min MIN v(x_u1.n005)
  let iref_max = vref_max / 5500
  let iref_min = vref_min / 5500
  let iref_mean = (iref_max + iref_min)/2
  let eq_20_34_35_mosfet_only_tc = (iref_max - iref_min) / (iref_mean * 165)
  let eq_20_36_37_beta_mult_tc = eq_20_34_35_mosfet_only_tc
  print eq_20_34_35_mosfet_only_tc
  print eq_20_36_37_beta_mult_tc
.endc
.end