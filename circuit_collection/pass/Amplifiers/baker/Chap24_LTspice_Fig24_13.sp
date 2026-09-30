* Op-Amp AC and DC Performance Testbench (Baker Fig. 24.8 / 24.9 / 24.13)
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
.param L_xm7_sub=0.5
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
.param W_xm10=5.0
.param W_xm12=5.0
.param W_xm13=5.0
.param W_xm15=5.0
.param W_xm16=5.0
.param W_xm18=5.0
.param W_xm2=5.0
.param W_xm4=5.0
.param W_xm6=5.0
.param W_xm6b=5.0
.param W_xm7_sub=5.0
.param W_xm8b=5.0
.param W_xm8t=5.0
.param W_xm9=5.0
.param W_xma11=5.0
.param W_xma12=5.0
.param W_xma2=5.0
.param W_xma3=5.0
.param W_xma5=5.0
.param W_xma6=5.0
.param W_xma8=5.0
.param W_xma9=5.0
.param W_xmsu2=5.0
.param W_xmsu3=5.0

* Parameter defaults for SKY130 1.8V devices
.param L_def=1.0
.param W_xm1=10.0 L_xm1={L_def} W_xm2=10.0 L_xm2={L_def}
.param W_xm3=10.0 L_xm3={L_def} W_xm4=10.0 L_xm4={L_def}
.param W_xm6t=20.0 L_xm6t={L_def} W_xm6b=20.0 L_xm6b={L_def}
.param W_xm7=20.0 L_xm7={L_def} W_xm8t=10.0 L_xm8t={L_def} W_xm8b=10.0 L_xm8b={L_def}
.param W_xmsu1=5.0 L_xmsu1={L_def} W_xmsu2=5.0 L_xmsu2={L_def} W_xmsu3=5.0 L_xmsu3={L_def}
.param W_xmsu4=5.0 L_xmsu4={L_def}
.param W_xm5=5.0 L_xm5={L_def} W_xm6=5.0 L_xm6={L_def} W_xm7_sub=10.0 L_xm7_sub={L_def}
.param W_xm8=5.0 L_xm8={L_def} W_xm9=5.0 L_xm9={L_def} W_xm10=5.0 L_xm10={L_def}
.param W_xm11=5.0 L_xm11={L_def} W_xm12=5.0 L_xm12={L_def} W_xm13=5.0 L_xm13={L_def}
.param W_xm14=5.0 L_xm14={L_def} W_xm15=5.0 L_xm15={L_def} W_xm16=5.0 L_xm16={L_def}
.param W_xm17=5.0 L_xm17={L_def} W_xm18=5.0 L_xm18={L_def}
.param W_xma1=10.0 L_xma1={L_def} W_xma2=10.0 L_xma2={L_def} W_xma3=10.0 L_xma3={L_def}
.param W_xma4=10.0 L_xma4={L_def} W_xma5=10.0 L_xma5={L_def} W_xma6=10.0 L_xma6={L_def}
.param W_xma7=10.0 L_xma7={L_def} W_xma8=10.0 L_xma8={L_def} W_xma9=10.0 L_xma9={L_def}
.param W_xma10=10.0 L_xma10={L_def} W_xma11=10.0 L_xma11={L_def} W_xma12=10.0 L_xma12={L_def}

* Circuit Under Test (Baker Fig. 24.8 / 24.13 with Fig. 24.9 AC feedback setup)
VDD VDD 0 1.8
Vp vp 0 dc 0.9 ac 1

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
Rz N002 N003 6500.0

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
  xm7 VDD Vbiasp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7_sub} l={L_def}
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
* 1. DC Operating Point and Power Dissipation
op
let power_dissipation = -i(VDD) * 1.8
print power_dissipation

* 2. Open-Loop AC Analysis (Frequency Response, Gain, PM, GM, fun)
ac dec 100 1 1G
let aol_db = db(v(vout))
let aol_ph = 180 / PI * cph(v(vout))

meas ac open_loop_dc_gain find aol_db at=10
let aol_3db_vec = aol_db - ($&open_loop_dc_gain) + 3
meas ac dominant_pole_frequency when aol_3db_vec=0 fall=1
meas ac unity_gain_frequency when aol_db=0 fall=1
meas ac phase_at_unity find aol_ph when aol_db=0 fall=1
let phase_margin = 180 + ($&phase_at_unity)

meas ac f_180 when aol_ph=-180 fall=1
meas ac gain_at_180 find aol_db when aol_ph=-180 fall=1
let gain_margin = -($&gain_at_180)

meas ac non_dominant_pole_frequency when aol_ph=-135 fall=1

print open_loop_dc_gain unity_gain_frequency phase_margin gain_margin dominant_pole_frequency non_dominant_pole_frequency

* 3. DC Sweep for Output Voltage Swing and Systematic Offset
dc Vp 0 1.8 0.001
let dvout = deriv(v(vout))
meas dc output_voltage_swing_max find v(vout) when dvout=0.5 fall=1
meas dc output_voltage_swing_min find v(vout) when dvout=0.5 rise=1

meas dc vp_at_900m find v(vp) when v(vout)=0.9
let systematic_offset_voltage = ($&vp_at_900m) - 0.9

print output_voltage_swing_max output_voltage_swing_min systematic_offset_voltage
quit
.endc
.end