* Delta-Sigma Modulator (DSM) Sensing Circuit Testbench (Sky130)
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

* === Device Parameter Definitions ===
.param W_xm1=2.0  L_xm1=0.15
.param W_xm2=2.0  L_xm2=0.15
.param W_xm3=2.0  L_xm3=0.15
.param W_xm4=2.0  L_xm4=0.15
.param W_xm5=1.0  L_xm5=1.0
.param W_xm6=1.0  L_xm6=1.0
.param W_xm7=2.0  L_xm7=0.15
.param W_xm8=2.0  L_xm8=0.15
.param W_xm9=2.0  L_xm9=0.15
.param W_xm10=2.0 L_xm10=0.15
.param W_xm11=1.0 L_xm11=0.15
.param W_xm12=1.0 L_xm12=0.15

* === Power Supply and DC Biases ===
VDD VDD 0 1.8
Vblack Vblack 0 650m
Vinten Vinten 0 650m

* === Circuit Under Test (DUT) ===
xm3 N002 phi1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm1 N004 phi2 N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
xm2 N006 Out N004 VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
C1 N002 0 1e-13
xm4 vbucket VI N006 N006 sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
X_U1 vbucket vd4r Out Outi clock VDD 0 SUB_1
xm5 vbucket vd4r 0 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
C2 vbucket 0 5e-13
xm6 vd4r vd4r 0 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
xm7 N001 phi1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
xm8 N003 phi2 N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
xm9 N005 0 N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm9} l={L_xm9}
C3 N001 0 1e-13
xm10 vd4r VR N005 N005 sky130_fd_pr__pfet_01v8 w={W_xm10} l={L_xm10}
Chr VR 0 1e-12
xm11 VR shr Vblack 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
Chi VI 0 1e-12
xm12 VI shi Vinten 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}

* === Subcircuits ===
.subckt SUB_1 inp inm q qi clock VDD GND
  xm1 N003 inp GND 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
  xm2 Outm Outp VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
  xm3 Outp Outm VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm5 N002 Outm N004 0 sky130_fd_pr__nfet_01v8 w={W_xm5} l={L_xm5}
  xm6 N001 Outp N003 0 sky130_fd_pr__nfet_01v8 w={W_xm6} l={L_xm6}
  xm4 Outm clock VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
  xm7 Outp clock VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm7} l={L_xm7}
  xm8 Outm clock N001 0 sky130_fd_pr__nfet_01v8 w={W_xm8} l={L_xm8}
  xm9 Outp clock N002 0 sky130_fd_pr__nfet_01v8 w={W_xm9} l={L_xm9}
  xm10 N004 inm 0 0 sky130_fd_pr__nfet_01v8 w={W_xm10} l={L_xm10}
  X_U1 Outp q qi VDD 0 NAND_2
  X_U2 qi Outm q VDD 0 NAND_2
.ends SUB_1

.subckt NAND_2 A B Out VDD GND
  xm3 out B VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm8 out A VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
  xm11 N001 B GND 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
  xm12 out A N001 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
.ends NAND_2

* === Control and Clock Signals ===
* Sample-and-hold pulse from 10ns to 100ns
Vshr shr 0 PULSE(0 1.8 10n 0.5n 0.5n 90n 5000n)
Vshi shi 0 PULSE(0 1.8 10n 0.5n 0.5n 90n 5000n)

* Non-overlapping switched-capacitor clocks (T = 10ns, f = 100MHz)
* Active low PMOS precharge phi1 (8.5ns - 9.5ns of each 10ns period)
Vphi1 phi1 0 PULSE(1.8 0 208.5n 0.2n 0.2n 1.0n 10n)
* Active low PMOS charge-transfer phi2 (1.0ns - 4.0ns of each 10ns period)
Vphi2 phi2 0 PULSE(1.8 0 201.0n 0.2n 0.2n 3.0n 10n)
* Comparator evaluation clock (active high from 5.0ns - 8.0ns)
Vclk clock 0 PULSE(0 1.8 205.0n 0.2n 0.2n 3.0n 10n)

.ic v(VR)=0.65 v(VI)=0.65 v(vbucket)=0.6 v(vd4r)=0.6

.control
* Run Transient Simulation (1500 ns total duration as in textbook)
tran 0.1n 1500n uic

* Measure sampled voltages on hold capacitors
meas tran v_sample_r find v(VR) at=150n
meas tran v_sample_i find v(VI) at=150n

* Calculate shifted reference and intensity voltages
let vthp_nom = 0.42
let v_r_shift = 1.8 - vthp_nom - v_sample_r
let v_i_shift = 1.8 - vthp_nom - v_sample_i
let v_col_max = 1.8 - vthp_nom
let r_r_sc = 1.0 / (100e6 * 100e-15)
let i_r_avg = v_r_shift / r_r_sc
let v_resolution_100 = v_r_shift / 100.0

print v_r_shift
print v_i_shift
print v_col_max
print r_r_sc
print i_r_avg
print v_resolution_100

* Measure bucket voltage and modulator output at end of sensing interval
meas tran vbucket_final find v(vbucket) at=1490n
meas tran vd4r_final find v(vd4r) at=1490n
meas tran out_max max v(Out) from=500n to=1500n
meas tran out_avg avg v(Out) from=500n to=1500n

print vbucket_final vd4r_final out_max out_avg
quit
.endc
.end
