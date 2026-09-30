* Shunt-Shunt Feedback Amplifier (Transimpedance / Charge Amp)
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

.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=10.0 L_xm2=1.0
.param W_xm3=20.0 L_xm3=1.0
.param W_xm4=20.0 L_xm4=1.0
.param W_xm5=2.0  L_xm5=0.5
.param W_xmsu1=5.0 L_xmsu1=1.0
.param W_xmsu2=10.0 L_xmsu2=1.0
.param W_xmsu3=5.0 L_xmsu3=1.0
.param W_xmsu4=5.0 L_xmsu4=1.0
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
.param W_xm6=5.0 L_xm6=1.0
.param W_xm7=10.0 L_xm7=1.0
.param W_xm8=5.0 L_xm8=1.0
.param W_xm9=5.0 L_xm9=1.0
.param W_xm10=5.0 L_xm10=1.0
.param W_xm11=5.0 L_xm11=1.0
.param W_xm12=5.0 L_xm12=1.0
.param W_xm13=5.0 L_xm13=1.0
.param W_xm14=5.0 L_xm14=1.0
.param W_xm15=5.0 L_xm15=1.0
.param W_xm16=5.0 L_xm16=1.0
.param W_xm17=5.0 L_xm17=1.0
.param W_xm18=5.0 L_xm18=1.0

* Power Supplies & Bias Control
VDD VDD 0 1.8
Vreset reset 0 DC 1.8 PULSE(1.8 0 1u 1n 1n 40u 50u)

* DUT Circuit Instance
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xm1 N002 in 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm4 N001 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm2 out Vbias3 N002 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm3 out Vbias2 N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
I1 in 0 DC 0 AC 1
I2 out 0 DC 0 AC 0
CF in out 1e-14
xm5 out reset in 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
Cload out 0 1e-11

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
* 1. DC Operating Point & Power
op
let pwr = -i(VDD) * 1.8
let power_dissipation = pwr
print power_dissipation

* 2. AC Analysis 1: Transimpedance, Input Impedance, Open-Loop, Beta
ac dec 20 1 1G

let v_in_real = real(v(in))
let v_out_real = real(v(out))
meas ac v_in_r find v_in_real at=1
meas ac v_out_r find v_out_real at=1
let gds5 = -1 / (v_in_r - v_out_r)

let omega = 2 * pi * frequency
let Yf = gds5 + i * omega * 1e-14
let i_f = (v(in) - v(out)) * Yf
let i_in = -1 - i_f

let AOL = v(out) / i_in
let open_loop_transimpedance_gain_vec = db(AOL)

let beta = i_f / v(out)
let feedback_factor_beta_vec = abs(beta)

let ACL = v(out)
let closed_loop_transimpedance_gain_vec = db(ACL)

let closed_loop_input_impedance_vec = abs(v(in))

meas ac open_loop_transimpedance_gain find open_loop_transimpedance_gain_vec at=100k
print open_loop_transimpedance_gain

meas ac feedback_factor_beta find feedback_factor_beta_vec at=100k
print feedback_factor_beta

meas ac closed_loop_transimpedance_gain find closed_loop_transimpedance_gain_vec at=100k
print closed_loop_transimpedance_gain

meas ac closed_loop_input_impedance find closed_loop_input_impedance_vec at=100k
print closed_loop_input_impedance

* 3. AC Analysis 2: Output Impedance
alter i1 acmag=0
alter i2 acmag=1
ac dec 20 1 1G
let Zout_CL = abs(v(out))
meas ac closed_loop_output_impedance find Zout_CL at=100k
print closed_loop_output_impedance

* 4. Transient Analysis: Integration Slope
alter i1 dc=10p
tran 10n 30u
meas tran v_out_5u find v(out) at=5u
meas tran v_out_25u find v(out) at=25u
let transient_integration_slope = (v_out_25u - v_out_5u) / 20
print transient_integration_slope

quit
.endc
.end