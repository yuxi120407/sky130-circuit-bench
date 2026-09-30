* Testbench for Figure 17.21: Resistor-based DSM Sensing Circuit
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param W_xm1=5.0
.param W_xm10=5.0
.param W_xm11=5.0
.param W_xm12=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm9=5.0

* Parameter declarations for transistors
.param L_xm1=0.5 W_xm1=1.5
.param L_xm2=0.5 W_xm2=3.0
.param L_xm3=0.5 W_xm3=3.0
.param L_xm4=0.5 W_xm4=3.0
.param L_xm5=0.5 W_xm5=1.5
.param L_xm6=0.5 W_xm6=1.5
.param L_xm7=0.5 W_xm7=3.0
.param L_xm8=0.5 W_xm8=1.5
.param L_xm9=0.5 W_xm9=1.5
.param L_xm10=0.5 W_xm10=2.0
.param L_xm11=0.5 W_xm11=1.5
.param L_xm12=0.5 W_xm12=1.5

* DUT Circuit
VDD VDD 0 1.8
xm2 N003 N002 N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xm4 vbit VREF N003 N003 sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
VREF VREF 0 0.8
X_U1 vbit VREF N002 Out clock VDD 0 SUB_1
Cbit vbit 0 5e-13
R1 VREF vbit 50000.0
R2 VDD N001 25000.0

* Clock generator: 100 MHz, 50% duty cycle
Vclock clock 0 PULSE(0 1.8 0 100p 100p 4.9n 10n)

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

* Transient Analysis (600 ns as in Baker LTspice)
.tran 0.1n 600n 100n

.control
  run
  * Average bit line voltage in steady-state (100n to 600n)
  meas tran bitline_average_voltage avg v(vbit) from=100n to=600n
  
  * Offset voltage relative to VREF (0.8 V)
  let comparator_offset_voltage = bitline_average_voltage - 0.8
  
  * Cell current through R1 (50k)
  let cell_current = comparator_offset_voltage / 50000.0
  
  * Bit line ripple
  meas tran vbit_max max v(vbit) from=100n to=600n
  meas tran vbit_min min v(vbit) from=100n to=600n
  let bitline_voltage_ripple = vbit_max - vbit_min
  
  * Supply current and power from VDD
  meas tran idd_avg avg i(VDD) from=100n to=600n
  let average_supply_current = abs(idd_avg)
  let average_power = 1.8 * average_supply_current

  print comparator_offset_voltage
  print bitline_average_voltage
  print cell_current
  print bitline_voltage_ripple
  print average_supply_current
  print average_power
  quit
.endc
.end