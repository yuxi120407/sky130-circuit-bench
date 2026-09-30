* Testbench for Baker Ch 24 Two-Stage CMOS Op-Amp
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
.param L_xm1_s=0.5
.param L_xm2=0.5
.param L_xm2_s=0.5
.param L_xm3=0.5
.param L_xm3_s=0.5
.param L_xm4=0.5
.param L_xm4_s=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm6b=0.5
.param L_xm6t=0.5
.param L_xm7=0.5
.param L_xm7_s=0.5
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

* Parameter definitions for transistors (W/L in um)
.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=10.0 L_xm2=1.0
.param W_xm3=10.0 L_xm3=1.0
.param W_xm4=10.0 L_xm4=1.0
.param W_xm6t=20.0 L_xm6t=1.0
.param W_xm6b=20.0 L_xm6b=1.0
.param W_xm7=20.0 L_xm7=1.0
.param W_xm8t=10.0 L_xm8t=1.0
.param W_xm8b=10.0 L_xm8b=1.0

* Bias circuit parameters
.param W_xmsu1=2.0 L_xmsu1=1.0
.param W_xmsu2=2.0 L_xmsu2=1.0
.param W_xmsu3=2.0 L_xmsu3=1.0
.param W_xmsu4=5.0 L_xmsu4=1.0
.param W_xm1_s=10.0 L_xm1_s=1.0
.param W_xm2_s=40.0 L_xm2_s=1.0
.param W_xm3_s=20.0 L_xm3_s=1.0
.param W_xm4_s=20.0 L_xm4_s=1.0
.param W_xm5=10.0 L_xm5=1.0
.param W_xm6=10.0 L_xm6=1.0
.param W_xm7_s=20.0 L_xm7_s=1.0
.param W_xm8=10.0 L_xm8=1.0
.param W_xm9=10.0 L_xm9=1.0
.param W_xm10=10.0 L_xm10=1.0
.param W_xm11=10.0 L_xm11=1.0
.param W_xm12=10.0 L_xm12=1.0
.param W_xm13=10.0 L_xm13=1.0
.param W_xm14=10.0 L_xm14=1.0
.param W_xm15=10.0 L_xm15=1.0
.param W_xm16=10.0 L_xm16=1.0
.param W_xm17=10.0 L_xm17=1.0
.param W_xm18=10.0 L_xm18=1.0
.param W_xma1=10.0 L_xma1=1.0
.param W_xma2=10.0 L_xma2=1.0
.param W_xma3=10.0 L_xma3=1.0
.param W_xma4=10.0 L_xma4=1.0
.param W_xma5=10.0 L_xma5=1.0
.param W_xma6=10.0 L_xma6=1.0
.param W_xma7=10.0 L_xma7=1.0
.param W_xma8=10.0 L_xma8=1.0
.param W_xma9=10.0 L_xma9=1.0
.param W_xma10=10.0 L_xma10=1.0
.param W_xma11=10.0 L_xma11=1.0
.param W_xma12=10.0 L_xma12=1.0

* DUT Circuit
VDD VDD 0 1.8
xm2 N002 vp N004 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 vm N004 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xm6t N004 Vbias3 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm6t} l={L_xm6t}
xm6b N005 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6b} l={L_xm6b}
xm7 vout N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8t vout Vbias3 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm8t} l={L_xm8t}
xm8b N006 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8b} l={L_xm8b}
C1 vm 0 1e-05
R1 vm vout 100000000.0
Cc vout N003 2.4e-12
C3 vout 0 1e-13
Rz N002 N003 6.5k

* Bias Generator Subcircuit
.subckt SUB_1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD GND
  xmsu2 N002 N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmsu2} l={L_xmsu2}
  xmsu1 N002 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xmsu1} l={L_xmsu1}
  xmsu3 Vbiasp N002 N003 0 sky130_fd_pr__nfet_01v8 w={W_xmsu3} l={L_xmsu3}
  xm3 N003 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3_s} l={L_xm3_s}
  xm4 N004 Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4_s} l={L_xm4_s}
  xm1 N003 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1_s} l={L_xm1_s}
  xm2 N004 N004 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm2_s} l={L_xm2_s}
  R1 N005 GND 5.5k
  xma4 Vbiasp N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma4} l={L_xma4}
  xma3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xma3} l={L_xma3}
  xm5 N001 N004 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
  xm6 Vbiasp N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
  xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7_s} l={L_xm7_s}
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

* AC and DC Input Source at non-inverting terminal vp (Fig 24.9)
Vinp vp 0 dc 0.9 ac 1
I_inject vm 0 dc 0
Iload vout 0 dc 0

.control
  * 1. Operating point analysis for power dissipation
  op
  let power_dissipation = -i(VDD) * 1.8
  print power_dissipation

  * 2. AC analysis for Gain, Bandwidth, PM, and GM
  ac dec 100 1 1G
  let gain_db = vdb(vout)
  let phase = 180/PI * cph(v(vout))

  meas ac dc_open_loop_gain find gain_db at=1
  print dc_open_loop_gain

  let aol_3db = dc_open_loop_gain - 3.0
  meas ac dominant_pole_frequency when gain_db=aol_3db fall=1
  print dominant_pole_frequency

  meas ac unity_gain_frequency when gain_db=0 fall=1
  print unity_gain_frequency

  meas ac phase_at_unity find phase when gain_db=0 fall=1
  let phase_margin = 180 + phase_at_unity
  print phase_margin

  meas ac gain_at_180 find gain_db when phase=-180 fall=1
  let gain_margin = -gain_at_180
  print gain_margin

  meas ac second_pole_frequency when phase=-135 fall=1
  print second_pole_frequency

  * 3. DC sweep for Output Voltage Swing
  dc I_inject -10n 10n 0.01n
  let diff_vout = deriv(v(vout))
  meas dc output_swing_min find v(vout) when diff_vout=50e6 rise=1
  print output_swing_min
  meas dc output_swing_max find v(vout) when diff_vout=50e6 fall=1
  print output_swing_max

  * 4. DC sweep for Max Sink Current
  dc Iload 0 -200u -0.1u
  meas dc max_sink_current_raw when v(vout)=1.2
  let max_sink_current = -max_sink_current_raw
  print max_sink_current

  quit
.endc
.end