* Cascode CS Amplifier Testbench
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
.param W_xm10=5.0
.param W_xm11=5.0
.param W_xm12=5.0
.param W_xm14=5.0
.param W_xm15=5.0
.param W_xm16=5.0
.param W_xm18=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xma10=5.0
.param W_xma11=5.0
.param W_xma12=5.0
.param W_xma2=5.0
.param W_xma3=5.0
.param W_xma4=5.0
.param W_xma6=5.0
.param W_xma7=5.0
.param W_xma8=5.0
.param W_xmsu2=5.0
.param W_xmsu3=5.0
.param W_xmsu4=5.0

* Define parameters to allow the parameterized netlist to run
.param W_xm1=2 L_xm1=0.5 W_xm2=2 L_xm2=0.5 W_xm3=4 L_xm3=0.5 W_xm4=4 L_xm4=0.5
.param W_xmsu1=2 L_xmsu1=0.5 W_xmsu2=4 L_xmsu2=0.5 W_xmsu3=2 L_xmsu3=0.5 W_xmsu4=2 L_xmsu4=0.5
.param W_xm5=2 L_xm5=0.5 W_xm6=2 L_xm6=0.5 W_xm7=4 L_xm7=0.5 W_xm8=2 L_xm8=0.5
.param W_xm9=2 L_xm9=0.5 W_xm10=2 L_xm10=0.5 W_xm11=2 L_xm11=0.5 W_xm12=2 L_xm12=0.5
.param W_xm13=2 L_xm13=0.5 W_xm14=2 L_xm14=0.5 W_xm15=2 L_xm15=0.5 W_xm16=2 L_xm16=0.5
.param W_xm17=2 L_xm17=0.5 W_xm18=2 L_xm18=0.5
.param W_xma1=4 L_xma1=0.5 W_xma2=4 L_xma2=0.5 W_xma3=4 L_xma3=0.5 W_xma4=4 L_xma4=0.5
.param W_xma5=4 L_xma5=0.5 W_xma6=4 L_xma6=0.5 W_xma7=4 L_xma7=0.5 W_xma8=4 L_xma8=0.5
.param W_xma9=4 L_xma9=0.5 W_xma10=4 L_xma10=0.5 W_xma11=4 L_xma11=0.5 W_xma12=4 L_xma12=0.5

* DUT
VDD VDD 0 1.8
xm1 N003 N002 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 Vout Vbias3 N003 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
xm4 N001 Vbias1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm3 Vout Vbias2 N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
X_U1 Vbias1 Vhigh Vbias2 Vpcas Vncas Vbias3 Vlow Vbias4 VDD 0 SUB_1
Cload Vout 0 1e-13
RS N004 P001 100000.0
Rbig N002 Vout 1000000000.0
Cbig P001 N002 1e-06

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

* Stimulus
Vin N004 0 dc 0 ac 1 pulse(-0.1 0.1 10u 10p 10p 100u 200u)

.control
* DC Operating Point
op
let power = -i(VDD) * 1.8
print power

* AC Analysis
ac dec 100 1 100T

* 1. open_circuit_gain
let amp_gain_mag = mag(v(Vout)) / mag(v(N002))
meas ac open_circuit_gain MAX amp_gain_mag

* 2. output_pole
let amp_gain_db = vdb(Vout) - vdb(N002)
meas ac amp_gain_max MAX amp_gain_db
let target_gain = $&amp_gain_max - 3
meas ac output_pole WHEN amp_gain_db=$&target_gain FALL=1

* 3. cascode_output_resistance
let cascode_output_resistance = 1 / (2 * 3.14159265 * $&output_pole * 1e-13)

* 4. input_pole
let v_n002_mag = mag(v(N002))
meas ac in_max MAX v_n002_mag
let target_in = $&in_max / 1.41421356
meas ac input_pole WHEN v_n002_mag=$&target_in FALL=1

* 5. input_capacitance
let input_capacitance = 1 / (2 * 3.14159265 * 100000 * $&input_pole)

* 6. transfer_function_zero
let logf = log10(frequency)
let slope_amp = deriv(amp_gain_db) / deriv(logf)
meas ac min_slope MIN slope_amp
let target_slope = $&min_slope + 10
meas ac transfer_function_zero WHEN slope_amp=$&target_slope RISE=1

* Print AC metrics
print open_circuit_gain output_pole cascode_output_resistance input_pole input_capacitance transfer_function_zero

* Transient Analysis for Slew Rate
tran 10n 200u
meas tran t_rise trig v(Vout) val=0.5 rise=1 targ v(Vout) val=1.3 rise=1
let slew_rate = 0.8 / ($&t_rise * 1e6)
print slew_rate

quit
.endc
.end