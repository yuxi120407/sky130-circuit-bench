* NMOS Clock Driver Testbench (Baker Fig. 18.40 / 18.39)
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

* Parameter definitions for parameterized W/L
.param W_xmu=30.0   L_xmu=0.15
.param W_xmd=30.0   L_xmd=0.15
.param W_xm1i=3.0   L_xm1i=0.15
.param W_xm2i=9.0   L_xm2i=0.15
.param W_xm1a=3.0   L_xm1a=0.15
.param W_xm2a=9.0   L_xm2a=0.15
.param W_xm3=3.0    L_xm3=0.15
.param W_xm4=9.0    L_xm4=0.15
.param W_xm2=3.0    L_xm2=0.15
.param W_xm1=3.0    L_xm1=0.15
.param W_xm8=3.0    L_xm8=0.15
.param W_xm11=3.0   L_xm11=0.15
.param W_xm12=3.0   L_xm12=0.15

* Power Supplies
VDD VDD 0 DC 1.8
Vs Vs 0 DC 1.8

* Input Stimulus: 20 MHz square wave (50 ns period)
Vin Vin 0 PULSE(0 1.8 5n 100p 100p 25n 50n)

* DUT Circuit Netlist
X_X1 N004 N005 Vs Fig18_39
xmu Vs N005 Vout 0 sky130_fd_pr__nfet_01v8 w={W_xmu} l={L_xmu}
xmd Vout N009 0 0 sky130_fd_pr__nfet_01v8 w={W_xmd} l={L_xmd}
C1 Vout 0 1e-11
X_X2 N006 N009 Vs INV_240_80
X_X3 N001 N004 Vs INV_240_80
X_X4 N003 N001 Vs INV_30_10
X_X5 N008 N006 Vs INV_30_10
X_X6 N007 N008 Vs INV_30_10
X_X7 N002 N003 Vs INV_30_10
X_X8 Vin N010 Vs INV_30_10
X_X9 Vin N006 N002 Vs NAND_2
X_X10 N001 N010 N007 Vs NAND_2

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

* Control Script
.control
tran 50p 150n 50n

* Measure Output Voltage Levels
meas tran voh MAX v(Vout) from=70n to=80n
meas tran vol MIN v(Vout) from=90n to=100n

* Measure Rise and Fall Times
meas tran rise_time trig v(Vout) val=0.18 rise=2 targ v(Vout) val=1.62 rise=2
meas tran fall_time trig v(Vout) val=1.62 fall=2 targ v(Vout) val=0.18 fall=2

* Measure Propagation Delays (Non-inverting buffer)
meas tran propagation_delay_lh trig v(Vin) val=0.9 rise=2 targ v(Vout) val=0.9 rise=2
meas tran propagation_delay_hl trig v(Vin) val=0.9 fall=2 targ v(Vout) val=0.9 fall=2

* Measure Peak Bootstrapped Gate Voltage at node N005
meas tran peak_bootstrapped_voltage MAX v(N005) from=55n to=80n

* Measure Average Power Dissipation from Vs supply
meas tran i_avg_vs AVG i(Vs) from=50n to=150n
let average_power = -i_avg_vs * 1.8

print voh vol rise_time fall_time propagation_delay_lh propagation_delay_hl peak_bootstrapped_voltage average_power
quit
.endc
.end