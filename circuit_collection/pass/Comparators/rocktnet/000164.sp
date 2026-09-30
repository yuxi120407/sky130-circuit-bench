* Dynamic Comparator Testbench
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

* DUT
XM1 N1 LABEL_NET_0 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N1 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N7 LABEL_NET_1 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N6 LABEL_NET_2 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 LABEL_NET_3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N5 LABEL_NET_4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N6 N4 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N7 N4 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N0 N1 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N1 N0 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N1 N0 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}

* Supplies
VVDD VDD 0 1.8
V_N2 N2 0 1.8

* Biases
V_N4 N4 0 0
VBIAS_N LABEL_NET_3 0 0.7

* Inputs (Common mode 0.9V, Diff 10mV)
VINP LABEL_NET_1 0 0.905
VINN LABEL_NET_2 0 0.895

* Clocks (80 MHz -> 12.5ns period)
* CLK: Latch enable (LABEL_NET_4)
VCLK LABEL_NET_4 0 PULSE(0 1.8 1n 100p 100p 6.15n 12.5n)
* CLK_BAR: Equalize (LABEL_NET_0)
VCLK_BAR LABEL_NET_0 0 PULSE(1.8 0 1n 100p 100p 6.15n 12.5n)

* Load capacitors
C1 N0 0 10f
C2 N1 0 10f

.control
  * Transient analysis for 3 clock cycles
  tran 10p 40n
  
  * Measure delay from CLK rising edge to OUTP rising
  meas tran t_clk_rise find time when v(LABEL_NET_4)=0.9 rise=1
  meas tran t_out_rise find time when v(N0)=1.44 rise=1
  let delay = t_out_rise - t_clk_rise
  print delay
  
  * Measure average power
  meas tran i_vdd_avg avg i(VVDD) from=0 to=37.5n
  meas tran i_n2_avg avg i(V_N2) from=0 to=37.5n
  let power_avg = -(i_vdd_avg + i_n2_avg) * 1.8
  print power_avg
  
  * Measure final differential voltage during evaluation phase
  meas tran v_outp find v(N0) at=6n
  meas tran v_outn find v(N1) at=6n
  let v_diff = v_outp - v_outn
  print v_diff
  
  quit
.endc
.end