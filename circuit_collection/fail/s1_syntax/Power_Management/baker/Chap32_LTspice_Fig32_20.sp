* Synchronous Buck Converter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm1a=0.5
.param L_xm1i=0.5
.param L_xm2=0.5
.param L_xm2a=0.5
.param L_xm2i=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm8=0.5
.param L_xmd=0.5
.param L_xmu=0.5

* Parameter definitions for transistors
.param W_xmu=200.0 L_xmu=0.15
.param W_xmd=200.0 L_xmd=0.15
.param W_xm1=10.0 L_xm1=0.15
.param W_xm2=10.0 L_xm2=0.15
.param W_xm3=10.0 L_xm3=0.15
.param W_xm4=10.0 L_xm4=0.15
.param W_xm1i=3.0 L_xm1i=0.15
.param W_xm2i=6.0 L_xm2i=0.15
.param W_xm1a=3.0 L_xm1a=0.15
.param W_xm2a=6.0 L_xm2a=0.15
.param W_xm8=6.0 L_xm8=0.15
.param W_xm11=3.0 L_xm11=0.15
.param W_xm12=3.0 L_xm12=0.15

* Power Supplies
VDD VDD 0 DC 1.8
Vs Vs 0 DC 1.8

* PWM Input Clock (10 MHz, 50% duty cycle)
Vin Vin 0 PULSE(0 1.8 0 1n 1n 49n 100n)

* DUT Power Stage and Output Filter
xmu Vs N001 N002 0 sky130_fd_pr__nfet_01v8 w={W_xmu} l={L_xmu}
xmd N002 N003 0 0 sky130_fd_pr__nfet_01v8 w={W_xmd} l={L_xmd}
C1 Vout 0 7.5e-09
X_X1 Vin Vs N001 N003 SUB_1
L1 N002 Vout 0.0001
Rload Vout 0 40.0

* Subcircuits from design
.subckt SUB_1 In Vs Up Down
  X_X1 N004 Up Vs Fig18_39
  X_X2 N005 Down Vs INV_240_80
  X_X3 N001 N004 Vs INV_240_80
  X_X4 N003 N001 Vs INV_30_10
  X_X5 N007 N005 Vs INV_30_10
  X_X6 N006 N007 Vs INV_30_10
  X_X7 N002 N003 Vs INV_30_10
  X_X8 In N008 Vs INV_30_10
  X_X9 In N005 N002 Vs NAND_2
  X_X10 N001 N008 N006 Vs NAND_2
.ends SUB_1

.subckt Fig18_39 In Out VDD
  xm1i N001 In 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1i} l={L_xm1i}
  xm2i N001 In VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2i} l={L_xm2i}
  C2 N002 B 5p
  xm1a N002 N001 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1a} l={L_xm1a}
  xm2a N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2a} l={L_xm2a}
  xm3 Out N001 0 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
  xm4 Out N001 B B sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  C1 N001 A 1p
  xm2 B A VDD 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  xm1 A B VDD 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
.ends Fig18_39

.subckt INV_240_80 In Out VDD
  xm1 Out In 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm2 Out In VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
.ends INV_240_80

.subckt INV_30_10 In Out VDD
  xm1 Out In 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm2 Out In VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
.ends INV_30_10

.subckt NAND_2 A B Out VDD
  xm3 out B VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm8 out A VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
  xm11 N001 B 0 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
  xm12 out A N001 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
.ends NAND_2

* Control Block for Execution and Automated Measurement
.control
  set wr_singlescale
  * Run transient analysis matching Baker's LTspice timing (up to 20 us)
  tran 50p 20u 19.7u

  * Steady-state output voltage measurements
  meas tran vout_avg avg v(vout) from=19.7u to=20.0u
  meas tran vout_max max v(vout) from=19.7u to=20.0u
  meas tran vout_min min v(vout) from=19.7u to=20.0u
  let vout_ripple = vout_max - vout_min
  print vout_avg vout_ripple

  * Inductor current ripple
  meas tran il_avg avg i(L1) from=19.7u to=20.0u
  meas tran il_max max i(L1) from=19.7u to=20.0u
  meas tran il_min min i(L1) from=19.7u to=20.0u
  let il_ripple = il_max - il_min
  print il_avg il_ripple

  * Power and Efficiency calculations
  meas tran pin_avg avg @Vs[i] from=19.7u to=20.0u
  let p_in = -pin_avg * 1.8
  let p_out = (vout_avg * vout_avg) / 40.0
  let efficiency = (p_out / p_in) * 100
  print p_out p_in efficiency

  quit
.endc
.end