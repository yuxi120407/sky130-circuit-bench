* Testbench for Simpler DSM Sensing Circuit (Fig. 17.21)
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

* Parameter definitions for transistors
.param W_xm1=10.0  L_xm1=1.0
.param W_xm2=20.0  L_xm2=1.0
.param W_xm3=20.0  L_xm3=1.0
.param W_xm4=20.0  L_xm4=1.0
.param W_xm5=10.0  L_xm5=1.0
.param W_xm6=10.0  L_xm6=1.0
.param W_xm7=20.0  L_xm7=1.0
.param W_xm8=20.0  L_xm8=1.0
.param W_xm9=10.0  L_xm9=1.0
.param W_xm10=13.0 L_xm10=1.0
.param W_xm11=10.0 L_xm11=1.0
.param W_xm12=10.0 L_xm12=1.0

* Power Supplies
VDD VDD 0 1.8
VREF VREF 0 0.9

* 100 MHz Clock Source (Period 10ns, 50% duty cycle)
Vclock clock 0 pulse(0 1.8 0 100p 100p 4.9n 10n)

* Fix for R1 incorrect connection to VREF instead of GND
* Ramped after 10us to sweep vbit and measure comparator offset
Ifix vbit 0 pwl(0 4.5u 10u 4.5u 20u -4.5u)

* DUT Netlist from Fig. 17.21
xm2 N003 N002 N001 VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}
xm4 vbit VREF N003 N003 sky130_fd_pr__pfet_01v8 w={W_xm4} l={L_xm4}
X_U1 vbit VREF N002 Out clock VDD 0 SUB_1
Cbit vbit 0 5e-13
R1 VREF vbit 200000.0
R2 VDD N001 25000.0

* Subcircuit definitions
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

* Transient Analysis
.tran 0.1n 20u uic

.control
run

* 1. Average bitline voltage (Vbit_avg)
meas tran average_bitline_voltage avg v(vbit) from=5u to=10u
print average_bitline_voltage

* 2. Bitline voltage ripple (peak-to-peak swing)
meas tran vbit_max max v(vbit) from=5u to=10u
meas tran vbit_min min v(vbit) from=5u to=10u
let bitline_voltage_ripple = vbit_max - vbit_min
print bitline_voltage_ripple

* 3. Comparator offset voltage Vos
* Measured during the sweep phase (10u to 20u) when vbit ramps up
meas tran vbit_trip find v(vbit) when v(Out)=0.9 fall=1 td=11u
let comparator_offset_voltage = vbit_trip - 0.9
print comparator_offset_voltage

* 4. Cell sense current Imbit
let cell_sense_current = average_bitline_voltage / 200000.0
print cell_sense_current

* 5. Bitstream density M/N from average value of Out
meas tran vout_avg avg v(Out) from=5u to=10u
let bitstream_density = vout_avg / 1.8
print bitstream_density

* 6. Sensed resistance Rmbit_calc
let sensed_resistance = 25000.0 / bitstream_density
print sensed_resistance

* 7. Minimum sense resistance
let minimum_sense_resistance = 25000.0
print minimum_sense_resistance

* 8. Maximum sense resistance (N = 500 clock cycles in 5us window)
let maximum_sense_resistance = 25000.0 * 500.0
print maximum_sense_resistance

* 9. Average supply current drawn from VDD
meas tran idd_avg avg i(VDD) from=5u to=10u
let average_supply_current = -idd_avg
print average_supply_current

quit
.endc
.end