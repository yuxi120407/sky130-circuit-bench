* Testbench for Baker Ch24 Two-Stage Op-Amp Voltage Follower
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

* Default transistor dimensions (matching Baker Ch24 scaling for Sky130)
.param W_xm1=10.0  L_xm1=1.0
.param W_xm2=10.0  L_xm2=1.0
.param W_xm3=20.0  L_xm3=1.0
.param W_xm4=20.0  L_xm4=1.0
.param W_xm6t=20.0 L_xm6t=1.0
.param W_xm6b=20.0 L_xm6b=1.0
.param W_xm7=40.0  L_xm7=1.0
.param W_xm8t=10.0 L_xm8t=1.0
.param W_xm8b=10.0 L_xm8b=1.0

* Bias generator SUB_1 internal dimensions
.param W_xmsu1=5.0  L_xmsu1=1.0
.param W_xmsu2=5.0  L_xmsu2=1.0
.param W_xmsu3=5.0  L_xmsu3=1.0
.param W_xmsu4=5.0  L_xmsu4=1.0
.param W_xm1=10.0   L_xm1=1.0
.param W_xm2=10.0   L_xm2=1.0
.param W_xm3=10.0   L_xm3=1.0
.param W_xm4=10.0   L_xm4=1.0
.param W_xm5=10.0   L_xm5=1.0
.param W_xm6=10.0   L_xm6=1.0
.param W_xm7=10.0   L_xm7=1.0
.param W_xm8=10.0   L_xm8=1.0
.param W_xm9=10.0   L_xm9=1.0
.param W_xm10=10.0  L_xm10=1.0
.param W_xm11=10.0  L_xm11=1.0
.param W_xm12=10.0  L_xm12=1.0
.param W_xm13=10.0  L_xm13=1.0
.param W_xm14=10.0  L_xm14=1.0
.param W_xm15=10.0  L_xm15=1.0
.param W_xm16=10.0  L_xm16=1.0
.param W_xm17=10.0  L_xm17=1.0
.param W_xm18=10.0  L_xm18=1.0
.param W_xma1=10.0  L_xma1=1.0
.param W_xma2=10.0  L_xma2=1.0
.param W_xma3=10.0  L_xma3=1.0
.param W_xma4=10.0  L_xma4=1.0
.param W_xma5=10.0  L_xma5=1.0
.param W_xma6=10.0  L_xma6=1.0
.param W_xma7=10.0  L_xma7=1.0
.param W_xma8=10.0  L_xma8=1.0
.param W_xma9=10.0  L_xma9=1.0
.param W_xma10=10.0 L_xma10=1.0
.param W_xma11=10.0 L_xma11=1.0
.param W_xma12=10.0 L_xma12=1.0

* DUT Instance and Connection
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
Rz N002 N003 6.5k

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

* Input voltage source: 0.9V DC nominal with AC and small-signal pulse for transient
Vin vin 0 dc 0.9 ac 1 pulse(0.895 0.905 1u 1n 1n 10u 20u)

* Control Block
.control
save all

* 1. Operating Point Analysis
op
let power_dissipation = -i(VDD) * 1.8
print power_dissipation

let current_sinking_capability = abs(@m.xm8t.msky130_fd_pr__nfet_01v8[id])
print current_sinking_capability

* 2. DC Transfer Analysis
dc Vin 0 1.8 0.01
meas dc vout_at_mid find v(vout) at=0.9
meas dc systematic_offset_voltage param='0.9 - vout_at_mid'
print systematic_offset_voltage

let cl_gain = deriv(v(vout))
meas dc closed_loop_gain find cl_gain at=0.9
print closed_loop_gain

meas dc max_slope max cl_gain
meas dc slope_thresh param='max_slope * 0.5'
meas dc output_swing_low find v(vout) when cl_gain=slope_thresh rise=1
meas dc output_swing_high find v(vout) when cl_gain=slope_thresh fall=1
print output_swing_low
print output_swing_high

* 3. AC Frequency Response
ac dec 100 1 1G
let aol = v(vout) / (v(vin) - v(vout))
let aol_db = db(aol)
let aol_phase_deg = ph(aol) * 180 / 3.141592653589793

meas ac dc_open_loop_gain find aol_db at=1
print dc_open_loop_gain

meas ac aol_3db param='dc_open_loop_gain - 3'
meas ac dominant_pole_frequency when aol_db=aol_3db fall=1
print dominant_pole_frequency

meas ac unity_gain_frequency when aol_db=0 fall=1
print unity_gain_frequency

meas ac dc_phase find aol_phase_deg at=1
meas ac target_phase_2nd param='dc_phase - 135'
meas ac second_pole_frequency when aol_phase_deg=target_phase_2nd fall=1
print second_pole_frequency

meas ac pm_phase find aol_phase_deg when aol_db=0 fall=1
meas ac phase_margin param='pm_phase - dc_phase + 180'
print phase_margin

meas ac target_phase_180 param='dc_phase - 180'
meas ac gm_db find aol_db when aol_phase_deg=target_phase_180 fall=1
meas ac gain_margin param='0 - gm_db'
print gain_margin

* 4. Transient Analysis
tran 10n 20u
meas tran v_init find v(vout) at=0.9u
meas tran v_final find v(vout) at=10.9u
meas tran v_step param='v_final - v_init'
meas tran v_targ param='v_init + 0.99 * v_step'
meas tran settling_time trig time val=1u cross=1 targ v(vout) val=v_targ rise=1
print settling_time

quit
.endc
.end