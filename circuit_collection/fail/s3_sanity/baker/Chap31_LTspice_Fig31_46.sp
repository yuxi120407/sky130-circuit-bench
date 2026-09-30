* Testbench for Series-Shunt Buffer
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
.param L_xmr1=0.5
.param L_xmr3=0.5
.param L_xmrl=0.5
.param L_xmsu1=0.5
.param L_xmsu2=0.5
.param L_xmsu3=0.5
.param L_xmsu4=0.5
.param W_xm11=5.0
.param W_xm12=5.0
.param W_xm13=5.0
.param W_xm15=5.0
.param W_xm16=5.0
.param W_xm17=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm9=5.0
.param W_xma1=5.0
.param W_xma10=5.0
.param W_xma12=5.0
.param W_xma3=5.0
.param W_xma5=5.0
.param W_xma6=5.0
.param W_xma8=5.0
.param W_xma9=5.0
.param W_xmr1=5.0
.param W_xmrl=5.0
.param W_xmsu1=5.0
.param W_xmsu3=5.0
.param W_xmsu4=5.0

* Dummy parameters to allow the parameterized netlist to compile
.param W_xm1=5 L_xm1=1 W_xm2=10 L_xm2=1 W_xmr1=5 L_xmr1=2 W_xmrl=5 L_xmrl=2
.param W_xmr3=10 L_xmr3=2 W_xm3=5 L_xm3=1 W_xm4=5 L_xm4=1
.param W_xmsu2=5 L_xmsu2=1 W_xmsu1=5 L_xmsu1=1 W_xmsu3=5 L_xmsu3=1
.param W_xma4=5 L_xma4=1 W_xma3=5 L_xma3=1
.param W_xm5=5 L_xm5=1 W_xm6=5 L_xm6=1 W_xm7=5 L_xm7=1 W_xma1=5 L_xma1=1
.param W_xma2=5 L_xma2=1 W_xmsu4=5 L_xmsu4=1 W_xm8=5 L_xm8=1 W_xm9=5 L_xm9=1
.param W_xm10=5 L_xm10=1 W_xm11=5 L_xm11=1 W_xm12=5 L_xm12=1 W_xm13=5 L_xm13=1
.param W_xm14=5 L_xm14=1 W_xm15=5 L_xm15=1 W_xma5=5 L_xma5=1 W_xma6=5 L_xma6=1
.param W_xma7=5 L_xma7=1 W_xma8=5 L_xma8=1 W_xma9=5 L_xma9=1 W_xma10=5 L_xma10=1
.param W_xma11=5 L_xma11=1 W_xma12=5 L_xma12=1 W_xm16=5 L_xm16=1 W_xm17=5 L_xm17=1
.param W_xm18=5 L_xm18=1

* --- DUT Netlist ---
VDD VDD 0 1.8
xmr3 N001 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xmr3} l={L_xmr3}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
xm1 N001 in out 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xmr1 out Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xmr1} l={L_xmr1}
xm2 out N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xmrl out Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xmrl} l={L_xmrl}
Cload out 0 1e-11
xm4 out_sf in VDD 0 sky130_fd_pr__nfet_01v8 w={W_xm4} l={L_xm4}
xm3 out_sf Vbias4 0 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
Cload1 out_sf 0 1e-11

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

* Stimulus
Vin in 0 DC 1.2 AC 1 PULSE(1.0 1.4 1n 1n 1n 5u 10u)
Iout_test out 0 DC 0 AC 0

.control
* 1. AC Analysis (Vin active, Iout_test inactive)
ac dec 100 100 1G
let a_cl_complex = v(out) / v(in)
let cl_gain_mag = mag(a_cl_complex)
meas ac closed_loop_gain find cl_gain_mag at=100k

let a_ol_complex = a_cl_complex / (1 - a_cl_complex)
let a_ol_db = 20 * log10(mag(a_ol_complex))
meas ac open_loop_gain find a_ol_db at=100k

let beta_vec = mag(v(out)) / mag(v(out))
meas ac feedback_factor find beta_vec at=100k

let rin = mag(v(in)) / mag(i(Vin))
meas ac closed_loop_input_resistance find rin at=100k

* 2. AC Analysis for Output Resistance (Vin AC=0, Iout_test AC=1)
alter @Vin[ac] = 0
alter @Iout_test[ac] = 1
ac dec 100 100 1G
let rout = mag(v(out))
meas ac closed_loop_output_resistance find rout at=100k

* 3. Transient Analysis
alter @Vin[ac] = 1
alter @Iout_test[ac] = 0
tran 10n 10u
meas tran v_max max v(out)
meas tran v_min min v(out)

print closed_loop_gain open_loop_gain feedback_factor closed_loop_input_resistance closed_loop_output_resistance
quit
.endc
.end