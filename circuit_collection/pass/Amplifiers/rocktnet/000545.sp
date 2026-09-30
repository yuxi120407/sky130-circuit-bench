* Fully Differential Op-Amp Testbench
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

* Parameters from netlist
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5

* DUT
XM1 N3 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUT_PLUS N8 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N8 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM5 N7 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM4 N7 OUT_MINUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM6 N3 VCOM N1 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N7 OUT_PLUS N5 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N10 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 VCOM N5 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 OUT_MINUS N10 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N8 IN_PLUS N4 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N10 IN_MINUS N4 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}

* Bias and Load Sources
I_tail1 N4 0 40u
I_tail2 N1 0 20u
I_tail3 N5 0 20u
B_load1 OUT_PLUS 0 I=50u*tanh(v(OUT_PLUS)/0.1)
B_load2 OUT_MINUS 0 I=50u*tanh(v(OUT_MINUS)/0.1)

* Compensation and Load Capacitors
Rz1 OUT_PLUS N8_c 5k
Cc1 N8_c N8 3p
Rz2 OUT_MINUS N10_c 5k
Cc2 N10_c N10 3p
Cl1 OUT_PLUS 0 1p
Cl2 OUT_MINUS 0 1p

* Voltage Sources
VVDD VDD 0 1.8
VCOM VCOM 0 0.9
VIN_PLUS IN_PLUS 0 DC 0.9 AC 0.5 PULSE(0.9 1.2 10n 1n 1n 1u 2u)
VIN_MINUS IN_MINUS 0 DC 0.9 AC -0.5 PULSE(0.9 0.6 10n 1n 1n 1u 2u)

* Dependent source for differential output
E_diff OUT_DIFF 0 OUT_PLUS OUT_MINUS 1.0

* Control Block
.control
  * DC Operating Point
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  * AC Analysis
  ac dec 100 1 1G
  let gain_db = vdb(OUT_DIFF)
  let phase_deg = 180/PI * cph(v(OUT_DIFF))
  
  meas ac dc_gain find gain_db at=1
  meas ac ugbw when gain_db=0 fall=1
  meas ac phase_margin_raw find phase_deg when gain_db=0 fall=1
  let phase_margin = 180 + phase_margin_raw
  print dc_gain
  print ugbw
  print phase_margin

  * Transient Analysis
  tran 1n 2u
  meas tran v_max max v(OUT_DIFF)
  meas tran v_min min v(OUT_DIFF)
  meas tran t_rise trig v(OUT_DIFF) val=0.2 rise=1 targ v(OUT_DIFF) val=1.0 rise=1
  let slew_rate = 0.8 / t_rise * 1e-6
  print slew_rate
  
  quit
.endc
.end