* DC Generation Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Define parameters for the subcircuit and top level
.param W_xm1=2 L_xm1=0.15
.param W_xm2=1 L_xm2=0.15
.param W_xm3=2 L_xm3=0.15
.param W_xm4=2 L_xm4=0.15
.param W_xm5=2 L_xm5=0.15
.param W_xm6=1 L_xm6=0.15
.param W_xm7=1 L_xm7=0.15
.param W_xm8=1 L_xm8=0.15
.param W_xm9=2 L_xm9=0.15
.param W_xm10=2 L_xm10=0.15
.param W_xm11=1 L_xm11=0.15
.param W_xm12=2 L_xm12=0.15

* DUT
VDD VDD 0 1.8
X_U1 Max In N001 VDD 0 SUB_1
X_U2 Min In N002 VDD 0 SUB_1
X_U3 In Avg Out VDD 0 SUB_1
xm1 Max N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
xm2 Min N002 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
C1 Max 0 1e-12
C2 0 Min 1e-12
C3 Avg 0 1e-12
R1 Max Avg 100000.0
R2 Avg Min 100000.0
R3 Vin In 1000.0
C4 In 0 1e-11

.subckt SUB_1 Vinp Vinm Out VDD GND
  xm1 N004 Vinm N005 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm3 N004 N004 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 N002 N004 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm2 N002 Vinp N005 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  xm6 N005 N004 GND 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
  xm5 Out N002 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
  xm7 Out N002 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
  xm8 N003 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
  xm9 N003 Vinm N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
  xm10 N002 Vinp N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
  xm11 N002 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
  xm12 N001 N003 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm12} l={L_xm12}
.ends SUB_1

* Stimulus: 10MHz square wave
Vvin Vin 0 PULSE(0 1.8 0 1n 1n 49n 100n)

.control
  tran 1n 1u
  
  * Measure steady state values after startup transient (800ns to 1us)
  meas tran v_peak_ss max v(Max) from=800n to=1u
  meas tran v_valley_ss min v(Min) from=800n to=1u
  meas tran v_avg_ss avg v(Avg) from=800n to=1u
  
  * Measure logic high and low levels of the output buffer
  meas tran out_high max v(Out) from=800n to=1u
  meas tran out_low min v(Out) from=800n to=1u
  
  quit
.endc
.end