* DSM Flash Memory Sensing Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm1=1.0   L_xm1=0.15
.param W_xm2=2.0   L_xm2=0.15
.param W_xm3=2.0   L_xm3=0.15
.param W_xm4=2.0   L_xm4=0.5
.param W_xm5=2.0   L_xm5=0.5
.param W_xm6=2.0   L_xm6=0.5
.param W_xm7=2.0   L_xm7=0.5
.param W_xm8=1.0   L_xm8=0.15
.param W_xm9=1.0   L_xm9=0.15
.param W_xm10=1.0  L_xm10=0.15
.param W_xm11=1.0  L_xm11=0.15
.param W_xm12=1.0  L_xm12=0.15

VDD VDD 0 1.8
xm3 0 0 N003 VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm1 vbit Outi N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
VREF VREF 0 1.0
Cbit vbit 0 5e-13
X_U1 vbit VREF Outi Out clock VDD 0 SUB_1
I1 vbit 0 1u
xm2 N003 Out N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
Ibias N001 0 10u
xm4 N002 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
xm5 N001 N001 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm5} l={L_xm5}

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

Vclk clock 0 PULSE(0 1.8 0 100p 100p 4.9n 10n)
.ic v(vbit)=1.05 v(out)=0 v(outi)=1.8

.control
tran 0.1n 600n

* Measure single cycle discharge drop during non-charge phase (between 10ns and 20ns)
meas tran v_t10 find v(vbit) at=10n
meas tran v_t20 find v(vbit) at=20n
let delta_vbit_drop = v_t10 - v_t20
print delta_vbit_drop

* Measure maximum voltage increase during a charge phase (between 20ns and 30ns)
meas tran v_t30 find v(vbit) at=30n
let delta_vbit_max = v_t30 - v_t20
print delta_vbit_max

* Measure average output voltage and compute M/N ratio
meas tran vout_avg AVG v(out) from=0n to=600n
let output_ratio = vout_avg / 1.8
print output_ratio

* Compute Dynamic Range and Minimum Resolvable Signal for N = 60 cycles
let N_cycles = 60
let dynamic_range = 20 * log10(N_cycles)
let minimum_resolvable_signal = 10e-6 / N_cycles
print dynamic_range
print minimum_resolvable_signal

quit
.endc
.end