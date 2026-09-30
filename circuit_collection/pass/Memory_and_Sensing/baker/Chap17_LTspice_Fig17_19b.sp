* Delta-Sigma Modulation Sensing Circuit for Resistive Memory (Baker Fig. 17.18)
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

* Parameter settings for Sky130 devices
.param W_xm1=13.0 L_xm1=1.0
.param W_xm2=20.0 L_xm2=1.0
.param W_xm3=20.0 L_xm3=1.0
.param W_xm4=20.0 L_xm4=1.0
.param W_xm5=10.0 L_xm5=1.0
.param W_xm6=10.0 L_xm6=1.0
.param W_xm7=20.0 L_xm7=1.0
.param W_xm8=10.0 L_xm8=1.0
.param W_xm9=10.0 L_xm9=1.0
.param W_xm10=10.0 L_xm10=1.0
.param W_xm11=10.0 L_xm11=1.0
.param W_xm12=10.0 L_xm12=1.0

* Power Supplies
VDD VDD 0 DC 1.8
VREF VREF 0 DC 0.5

* Switched Capacitor Network & Feedback Path (Top-level DUT)
xm3 N001 phi1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm1 N002 phi2 N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
xm2 N004 N003 N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
C1 N001 0 1e-13
xm4 vbit VREF N004 N004 sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
X_U1 vbit VREF N003 Out clock VDD 0 SUB_1
Cbit vbit 0 5e-13
R1 VREF vbit 50000.0

* Clock Signals (T = 10ns, f = 100MHz)
* phi1: active low precharge pulse for Ccup
Vphi1 phi1 0 PULSE(1.8 0 0.5n 0.1n 0.1n 3.0n 10n)
* phi2: active low discharge pulse for Ccup
Vphi2 phi2 0 PULSE(1.8 0 4.5n 0.1n 0.1n 3.0n 10n)
* clock: active high sampling clock for comparator
Vclock clock 0 PULSE(0 1.8 8.0n 0.1n 0.1n 1.5n 10n)

* Subcircuit: Clocked Comparator with Built-in Offset (Fig. 17.16)
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

* Subcircuit: 2-input NAND Gate
.subckt NAND_2 A B Out VDD GND
  xm3 out B VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
  xm8 out A VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm8} l={L_xm8}
  xm11 N001 B GND 0 sky130_fd_pr__nfet_01v8 w={W_xm11} l={L_xm11}
  xm12 out A N001 0 sky130_fd_pr__nfet_01v8 w={W_xm12} l={L_xm12}
.ends NAND_2

* Initial condition on bitline
.ic v(vbit)=0.5 v(N001)=1.8

* Control & Measurement Block
.control
tran 0.05n 500n 100n

* Measure maximum and minimum bitline voltage during steady state
meas tran vbit_max max v(vbit) from=100n to=500n
meas tran vbit_min min v(vbit) from=100n to=500n
meas tran vbit_avg avg v(vbit) from=100n to=500n

* Calculate ripple and comparator offset
let delta_vbit = vbit_max - vbit_min
let vos_meas = vbit_avg - 0.5
print delta_vbit
print vos_meas

* Measure average supply current and memory cell current
meas tran ivdd_avg avg i(VDD) from=100n to=500n
let pwr_avg = -ivdd_avg * 1.8
print pwr_avg

let imbit_avg = (vbit_avg - 0.5) / 50000.0
print imbit_avg

quit
.endc
.end