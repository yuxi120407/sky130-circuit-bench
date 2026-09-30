* Testbench for Current-Starved Delay Cell
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm4=5.0 L_xm4=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm10=5.0 L_xm10=0.5

VVDD VDD 0 1.8
VN8 N8 0 0
VBIAS_P BIAS_P 0 0.9
VIN3 N3 0 PULSE(0 1.8 5n 0.1n 0.1n 38n 77n) ; ~13 MHz
VLOGIC FROM_LOGIC 0 PULSE(0 1.8 10n 0.1n 0.1n 38n 77n)
RN1 N1 0 1G ; Prevent floating node error for capacitor XM1

* DUT
XM4 N0 N3 N9 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM3 BIAS_N BIAS_N N8 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM8 N2 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM1 N1 N0 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM7 N7 N2 N9 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM2 N9 BIAS_P VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM9 N2 N3 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM11 N6 FROM_LOGIC N8 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM6 N0 N3 BIAS_N GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM5 N7 N2 BIAS_N GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM10 N6 FROM_LOGIC VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}

* Load capacitors
C0 N0 0 10f
C7 N7 0 10f
C6 N6 0 10f
C2 N2 0 10f

.control
  op
  print v(N0) v(N7) v(N2) v(N6)
  
  tran 0.1n 200n
  
  * Measure delays (using 1.2V for N0/N7 due to reduced swing from tail diode)
  meas tran delay_n3_n2 trig v(N3) val=0.9 rise=1 targ v(N2) val=0.9 fall=1
  meas tran delay_n3_n0 trig v(N3) val=0.9 rise=1 targ v(N0) val=1.2 fall=1
  meas tran delay_n2_n7 trig v(N2) val=0.9 fall=1 targ v(N7) val=1.2 rise=1
  
  * Measure voltage swings
  meas tran v_max_n0 max v(N0)
  meas tran v_min_n0 min v(N0)
  
  * Measure average current for dynamic power calculation
  meas tran avg_current avg i(VVDD)
  
  quit
.endc
.end
