* Testbench for 2 GHz Delay-Locked Loop (DLL)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xmref=0.5

* Default transistor sizing parameters
.param W_xm1=10.0 L_xm1=1.0
.param W_xm2=20.0 L_xm2=1.0
.param W_xm3=10.0 L_xm3=1.0
.param W_xm4=20.0 L_xm4=1.0
.param W_xm5=20.0 L_xm5=1.0
.param W_xm6=20.0 L_xm6=1.0
.param W_xm7=10.0 L_xm7=1.0
.param W_xm8=10.0 L_xm8=1.0
.param W_xm9=20.0 L_xm9=1.0
.param W_xm10=10.0 L_xm10=1.0
.param W_xm11=10.0 L_xm11=1.0
.param W_xm12=10.0 L_xm12=1.0
.param W_xm13=10.0 L_xm13=1.0
.param W_xmref=100.0 L_xmref=1.0

* Power Supplies and Reference Clock (2 GHz, T=500ps)
VDD VDD 0 1.8
Vin In 0 PULSE(0 1.8 0 50p 50p 200p 500p)
Vref Vref 0 500m

* Initial condition on control voltage
.ic v(Vindel)=1.2

* Subcircuit definitions
.subckt INV_20_10 In Out VDD GND
  xm1 Out In GND GND sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm2 Out In VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
.ends INV_20_10

.subckt NAND_2 A B Out VDD GND
  xm3 out B VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm8 out A VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
  xm11 N001 B GND 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
  xm12 out A N001 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
.ends NAND_2

.subckt NAND_3 A B C Out VDD GND
  xm3 out B VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm7 out C VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xm8 out A VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
  xm10 N002 C GND 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
  xm11 N001 B N002 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
  xm12 out A N001 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
.ends NAND_3

.subckt NAND_4 A B C D Out VDD GND
  xm3 out B VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm7 out C VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xm8 out A VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
  xm9 out D VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
  xm10 N002 C N003 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
  xm11 N001 B N002 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
  xm12 out A N001 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
  xm13 N003 D GND 0 sky130_fd_pr__nfet_01v8 w={W_xm13} l={L_xm13}
.ends NAND_4

.subckt PFD data dclock up down VDD GND
  X_U1 data N004 VDD GND INV_20_10
  X_U2 N001 N004 B VDD 0 NAND_2
  X_U3 B N002 VDD 0 INV_20_10
  X_U4 N002 N003 VDD 0 INV_20_10
  X_U5 N003 A reset N001 VDD 0 NAND_3
  X_U6 N001 up VDD 0 INV_20_10
  X_U7 B N005 A VDD 0 NAND_2
  X_U8 A reset N005 VDD 0 NAND_2
  X_U9 dclock N009 VDD 0 INV_20_10
  X_U10 N006 N009 C VDD 0 NAND_2
  X_U11 C N007 VDD 0 INV_20_10
  X_U12 N007 N008 VDD 0 INV_20_10
  X_U13 N008 D reset N006 VDD 0 NAND_3
  X_U14 N006 down VDD 0 INV_20_10
  X_U15 C N010 D VDD 0 NAND_2
  X_U16 D reset N010 VDD 0 NAND_2
  X_U17 A B C D reset VDD 0 NAND_4
.ends PFD

.subckt delay Inp Inm Outp Outm Vpbias Vrbias VDD GND
  xm1 Outp Vrbias GND 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm4 N001 Vpbias VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm3 Outp Inm N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm2 Outp Outp 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  xm5 Outm Inp N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
  xm6 Outm Vrbias 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
  xm7 Outm Outm 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
  C1 0 Outp 5f
  C2 Outm 0 5f
.ends delay

.subckt pdiff Inp Inm Out Vpbias VDD GND
  xm4 N001 Vpbias VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm3 N002 Inp N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm5 Out Inm N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
  xm6 N002 N002 GND 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
  xm7 Out N002 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
.ends pdiff

.subckt SUB_1 Inp Inm Outp Outm Vindel Vref VDD GND
  xm1 N013 N013 GND 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm3 N013 n2 N011 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm4 Vrbias VREF N011 VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm2 Vrbias N013 0 0 sky130_fd_pr__nfet_01v8 w={W_xm2} l={L_xm2}
  xm5 Vpbias Vpbias VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
  xm7 n2 Vrbias 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
  xm6 N011 N013 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
  xmref Vpbias Vindel P001 0 sky130_fd_pr__nfet_01v8 w={W_xmref} l={L_xmref}
  R1 P001 0 10k
  xm8 N009 Vpbias VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
  xm9 n2 0 N009 VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
  xm10 n2 n2 0 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
  X_U12 N010 Outm VDD 0 INV_20_10
  X_U13 N012 Outp VDD 0 INV_20_10
  X_X1 Out4 Out4i N001 N002 Vpbias Vrbias VDD 0 delay
  X_X2 N001 N002 Out6 N003 Vpbias Vrbias VDD 0 delay
  X_X3 Out6 N003 Out7 Out7i Vpbias Vrbias VDD 0 delay
  X_X4 Out2 N007 N005 N008 Vpbias Vrbias VDD 0 delay
  X_X5 N005 N008 Out4 Out4i Vpbias Vrbias VDD 0 delay
  X_X6 N004 N006 Out2 N007 Vpbias Vrbias VDD 0 delay
  X_X7 Inp Inm N004 N006 Vpbias Vrbias VDD 0 delay
  X_X8 Out7 Out7i N010 Vpbias VDD 0 pdiff
  X_X9 Out7i Out7 N012 Vpbias VDD 0 pdiff
.ends SUB_1

* Core DLL Circuit
X_U4 up upi VDD 0 INV_20_10
X_U1 In Out up down VDD 0 PFD
xm1 Vindel down N005 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
xm2 Vindel upi N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
X_U5 down downi VDD 0 INV_20_10
C2 Vindel 0 5e-12
xm3 N003 downi N005 0 sky130_fd_pr__nfet_01v8 w={W_xm3} l={L_xm3}
xm4 N003 up N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm5 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}
xm6 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm6} l={L_xm6}
xm7 N005 N004 0 0 sky130_fd_pr__nfet_01v8 w={W_xm7} l={L_xm7}
xm8 N004 N004 0 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
V_I1_meas N001 N001_meas 0
I1 N001_meas N004 10u
X_U2 n1 n2 Out Outi Vindel Vref VDD 0 SUB_1
X_U3 In n2 VDD 0 INV_20_10
xm9 In 0 n1 VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
xm10 In VDD n1 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}

* Simulation Control
.control
tran 10p 1u

* Measure regulated reference voltage on replica node
meas tran vref_regulation avg v(X_U2.n2) from=900n to=1000n

* Measure charge pump bias current
meas tran charge_pump_current avg i(V_I1_meas) from=1n to=5n

* Measure input-to-output propagation delay through VCDL at end of simulation
meas tran vcdl_delay TRIG v(In) VAL=0.9 RISE=1 TD=950n TARG v(Out) VAL=0.9 RISE=1

* Measure VCDL gain Kv
meas tran delay_first TRIG v(In) VAL=0.9 RISE=1 TD=2.5n TARG v(Out) VAL=0.9 RISE=1
meas tran vindel_first find v(Vindel) at=2.5n
meas tran vindel_final avg v(Vindel) from=900n to=1000n

* Calculate derived metrics using let
let delay_per_stage = $&vcdl_delay / 8.0
let vcdl_gain_Kv = ($&vcdl_delay - $&delay_first) / ($&vindel_final - $&vindel_first)
let v_90 = $&vindel_first + 0.9 * ($&vindel_final - $&vindel_first)

* Measure DLL response time
meas tran dll_response_time when v(Vindel)="$&v_90" cross=1 TD=2.5n

print vref_regulation charge_pump_current vcdl_delay delay_per_stage vcdl_gain_Kv dll_response_time

quit
.endc
.end