* DSM Sensing Circuit for Resistive Memory (Baker Fig 17.18)
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

* Parameter definitions for transistor geometries
.param W_xm1=1.0 L_xm1=0.15
.param W_xm2=2.0 L_xm2=0.15
.param W_xm3=2.0 L_xm3=0.15
.param W_xm4=2.0 L_xm4=0.15
.param W_xm5=1.0 L_xm5=0.15
.param W_xm6=1.0 L_xm6=0.15
.param W_xm7=2.0 L_xm7=0.15
.param W_xm8=1.0 L_xm8=0.15
.param W_xm9=1.0 L_xm9=0.15
.param W_xm10=1.3 L_xm10=0.15
.param W_xm11=1.0 L_xm11=0.15
.param W_xm12=1.0 L_xm12=0.15

* Power Supplies
VDD VDD 0 1.8
VREF VREF 0 200m

* Non-overlapping two-phase clocks and comparator clock (T = 10ns, f = 100MHz)
* phi1: active-low PMOS precharge (0.5ns to 3.5ns)
Vphi1 phi1 0 PULSE(1.8 0 0.5n 0.1n 0.1n 3.0n 10n)
* clock: comparator evaluate pulse (4.0ns to 8.5ns)
Vclk clock 0 PULSE(0 1.8 4.0n 0.1n 0.1n 4.5n 10n)
* phi2: active-low PMOS dump switch (5.5ns to 8.5ns)
Vphi2 phi2 0 PULSE(1.8 0 5.5n 0.1n 0.1n 3.0n 10n)

* Circuit Under Test (Fig. 17.18)
xm3 N001 phi1 VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm3} l={L_xm3}
xm1 N002 phi2 N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
xm2 N004 N003 N002 VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
C1 N001 0 1e-13
xm4 vbit VREF N004 N004 sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
X_U1 vbit VREF N003 Out clock VDD 0 SUB_1
Cbit vbit 0 5e-13
R1 VREF vbit 25000.0

* Subcircuits from Netlist
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

* Initial condition for smooth startup
.ic v(vbit)=0.25

.control
* Run 50 cycles (500 ns) of DSM sensing
tran 0.05n 500n

* Measurements in steady-state (100ns to 500ns)
meas tran vbit_avg avg v(vbit) from=100n to=500n
meas tran vbit_max max v(vbit) from=100n to=500n
meas tran vbit_min min v(vbit) from=100n to=500n
meas tran idd_avg avg i(VDD) from=100n to=500n
meas tran n003_avg avg v(N003) from=100n to=500n
meas tran v_n001_max max v(N001) from=100n to=500n
meas tran v_n001_min min v(N001) from=100n to=500n

* Calculate metrics
let vbit_avg_val = $&vbit_avg
let v_os = $&vbit_avg - 0.2
let i_mbit = v_os / 25000.0
let m_ratio = (1.8 - $&n003_avg) / 1.8
let q_cup = 1e-13 * ($&v_n001_max - $&v_n001_min)
let delta_vbit = $&vbit_max - $&vbit_min
let r_sc_min = (1.8 - $&vbit_avg) / (q_cup * 100e6)
let r_mbit_min = r_sc_min
let r_mbit_max = 50 * r_sc_min
let i_dd_avg = -$&idd_avg

print q_cup delta_vbit v_os vbit_avg_val i_mbit r_sc_min r_mbit_min r_mbit_max m_ratio i_dd_avg

quit
.endc
.end