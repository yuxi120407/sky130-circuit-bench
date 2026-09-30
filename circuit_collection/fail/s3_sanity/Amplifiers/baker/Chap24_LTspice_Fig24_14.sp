* Op-Amp Voltage Follower Testbench (Fig 24.14 / Fig 24.8)
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

* Parameter defaults matching Baker's design scaled for sky130
.param W_xm1=10.0 L_xm1=0.5
.param W_xm2=10.0 L_xm2=0.5
.param W_xm3=10.0 L_xm3=0.5
.param W_xm4=10.0 L_xm4=0.5
.param W_xm6t=20.0 L_xm6t=0.5
.param W_xm6b=20.0 L_xm6b=0.5
.param W_xm7=20.0 L_xm7=0.5
.param W_xm8t=10.0 L_xm8t=0.5
.param W_xm8b=10.0 L_xm8b=0.5
.param W_xmsu1=5.0 L_xmsu1=0.5
.param W_xmsu2=5.0 L_xmsu2=0.5
.param W_xmsu3=5.0 L_xmsu3=0.5
.param W_xmsu4=5.0 L_xmsu4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm18=5.0 L_xm18=0.5
.param W_xma1=10.0 L_xma1=0.5
.param W_xma2=10.0 L_xma2=0.5
.param W_xma3=10.0 L_xma3=0.5
.param W_xma4=10.0 L_xma4=0.5
.param W_xma5=10.0 L_xma5=0.5
.param W_xma6=10.0 L_xma6=0.5
.param W_xma7=10.0 L_xma7=0.5
.param W_xma8=10.0 L_xma8=0.5
.param W_xma9=10.0 L_xma9=0.5
.param W_xma10=10.0 L_xma10=0.5
.param W_xma11=10.0 L_xma11=0.5
.param W_xma12=10.0 L_xma12=0.5

* DUT Circuit
VDD VDD 0 1.8
xm2 N002 vin N004 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm1 N001 vout N004 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xm6t N004 Vbias3 N005 0 sky130_fd_pr__nfet_01v8 w={W_xm6t} l={L_xm6t}
xm6b N005 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6b} l={L_xm6b}
xm7 vout N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8t vout Vbias3 N006 0 sky130_fd_pr__nfet_01v8 w={W_xm8t} l={L_xm8t}
xm8b N006 Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8b} l={L_xm8b}
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

* Source: DC 1.2V with AC 1 and PWL for transient simulation
Vin vin 0 DC 1.2 AC 1 PWL(0 1.2 10n 1.2 11n 1.205 500n 1.205 501n 1.1 1u 1.1 1.001u 1.5 2u 1.5)

.control
* 1. DC Operating Point & Power Dissipation
op
let power_dissipation = -i(VDD) * 1.8
print power_dissipation

* 2. AC Analysis (Closed Loop Frequency Response)
ac dec 100 1 1G
let v_diff = v(vin) - v(vout)
let aol_mag = v(vout) / v_diff
let aol_db = 20 * log10(mag(aol_mag))
let aol_ph = 180/PI * cph(aol_mag)

meas ac open_loop_dc_gain find aol_db at=1
print open_loop_dc_gain
let target_gain = open_loop_dc_gain - 3
meas ac dominant_pole_frequency when aol_db=$&target_gain fall=1
print dominant_pole_frequency
meas ac unity_gain_frequency when aol_db=0 fall=1
print unity_gain_frequency
meas ac pm_phase find aol_ph when aol_db=0 fall=1
let phase_margin = 180 + pm_phase
print phase_margin
meas ac gm_gain find aol_db when aol_ph=-180 fall=1
let gain_margin = -gm_gain
print gain_margin

* 3. Transient Analysis: Small-Signal and Large-Signal Step Response
tran 1n 2u
meas tran v_init find v(vout) at=9n
meas tran v_final find v(vout) at=490n
let v10 = v_init + 0.1*(v_final - v_init)
let v90 = v_init + 0.9*(v_final - v_init)
meas tran t10 when v(vout)=$&v10 rise=1 from=10n to=500n
meas tran t90 when v(vout)=$&v90 rise=1 from=10n to=500n
let small_signal_rise_time = t90 - t10
print small_signal_rise_time

let dvout = deriv(v(vout))
meas tran slew_rate_v_s max dvout from=1u to=2u
let slew_rate = slew_rate_v_s / 1e6
print slew_rate

* 4. DC Sweep for Output Swing Limits
dc Vin 0 1.8 0.01
meas dc output_swing_high max v(vout)
print output_swing_high
meas dc output_swing_low min v(vout)
print output_swing_low

quit
.endc
.end