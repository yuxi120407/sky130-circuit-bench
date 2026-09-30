* Testbench for StrongARM Latch
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5

* DUT
XM1 N0 LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N5 LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 N1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 LABEL_NET_3 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 N5 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N5 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N7 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N6 N0 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N5 N0 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N7 N5 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N6 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 N0 LABEL_NET_4 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}

* Fixes for broken netlist extraction
* XM4 was extracted with Gate shorted to Source. We add the correct differential input transistor.
XM4_fix N4 IN_MINUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
* N3 is the source of the output inverters but was left floating. Tie to GND.
VN3 N3 0 0

* Power supply
VVDD VDD 0 1.8

* Clock signal (160 MHz as per paper, T = 6.25ns)
VCLK CLK 0 PULSE(0 1.8 0 50p 50p 3n 6.25n)
R0 LABEL_NET_0 CLK 1m
R1 LABEL_NET_1 CLK 1m
R2 LABEL_NET_2 CLK 1m
R4 LABEL_NET_4 CLK 1m

* Input signals (Differential, common mode 0.9V, 100mV differential)
VIN_P LABEL_NET_3 0 0.95
VIN_N IN_MINUS 0 0.85

* Load capacitance
C1 N6 0 10f
C2 N7 0 10f

.control
  tran 10p 20n
  
  * Measure Clock-to-Q delay on the second rising edge (t=6.25ns)
  meas tran delay_clk_q trig v(CLK) val=0.9 rise=2 targ v(N6) val=0.9 rise=2
  
  * Measure average power consumption over one full clock cycle
  meas tran pwr_avg avg i(VVDD) from=6.25n to=12.5n
  let power_mw = -pwr_avg * 1.8 * 1000
  print power_mw
  
  * Measure output voltage swing
  meas tran vout_max max v(N6) from=6.25n to=12.5n
  meas tran vout_min min v(N6) from=6.25n to=12.5n
  let v_swing = vout_max - vout_min
  print v_swing
  
  quit
.endc
.end
