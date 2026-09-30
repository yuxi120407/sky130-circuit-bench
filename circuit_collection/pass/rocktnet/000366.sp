* Capacitance Multiplier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm8=5.0 L_xm8=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm6=5.0 L_xm6=0.5

XM8 N_M2D N_PG VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM4 B VBP N_M2D VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM1 N_M5D N_PG VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM5 A VBP N_M5D VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM2 N_PG N_PG VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 VBP VBP N_PG VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM9 B B N_M3S GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N_M3S N_NG GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM7 A B N_NG GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM6 N_NG N_NG GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

VVDD VDD 0 1.8
I_bias VBP 0 10u

* Physical capacitor at Node A
Cphys A 0 10p

* Input current source for AC impedance and Tran step response at Node B
Iin 0 B DC 0 AC 1 PULSE(0 10n 1u 1n 1n 50u 100u)

.control
  * DC Analysis
  op
  let power_consumption = -i(VVDD) * 1.8
  let dc_bias_voltage = v(B)
  print power_consumption dc_bias_voltage
  
  * AC Analysis for Impedance
  ac dec 20 1 1G
  
  let omega = 2 * 3.141592653589793 * frequency
  let Y_in = 1 / v(B)
  let Ceff_vec = imag(Y_in) / omega
  let Z_in = v(B)
  let Req_vec = real(Z_in)
  
  * Measure effective capacitance at 1 kHz (avoids DC resistance dominance)
  meas ac effective_capacitance find Ceff_vec at=1k
  
  * Measure equivalent series resistance at 100 MHz
  meas ac equivalent_series_resistance find Req_vec at=100Meg
  
  * Calculate Multiplication Factor
  let multiplication_factor = effective_capacitance / 10e-12
  
  print effective_capacitance multiplication_factor equivalent_series_resistance
  
  quit
.endc
.end