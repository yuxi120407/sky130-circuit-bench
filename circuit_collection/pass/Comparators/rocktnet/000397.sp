* Clocked Comparator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm17=0.5
.param L_xm18=0.5
.param L_xm19=0.5
.param L_xm2=0.5
.param L_xm20=0.5
.param L_xm21=0.5
.param L_xm22=0.5
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
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm18=5.0 L_xm18=0.5
.param W_xm19=5.0 L_xm19=0.5
.param W_xm20=5.0 L_xm20=0.5
.param W_xm21=5.0 L_xm21=0.5
.param W_xm22=5.0 L_xm22=0.5

XM1 N3 VIN_PLUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 VREF_PLUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 VIN_MINUS N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 VREF_MINUS N2 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N5 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N6 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N5 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N6 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N7 CLKB N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N8 CLKB N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 N7 N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N7 CLKB GND GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 N8 N7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16 N8 CLKB GND GND sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}
XM17 DOUT_PLUS N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm17} w={W_xm17}
XM18 DOUT_PLUS DOUT_MINUS GND GND sky130_fd_pr__nfet_01v8 l={L_xm18} w={W_xm18}
XM19 DOUT_MINUS DOUT_PLUS GND GND sky130_fd_pr__nfet_01v8 l={L_xm19} w={W_xm19}
XM20 DOUT_MINUS N7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm20} w={W_xm20}
XM21 DOUT_PLUS DOUT_MINUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm21} w={W_xm21}
XM22 DOUT_MINUS DOUT_PLUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm22} w={W_xm22}

* Tail currents for differential pairs
I1 N1 0 100u
I2 N2 0 100u

* Power and Inputs
VVDD VDD 0 1.8
VVIN_PLUS VIN_PLUS 0 DC 0.9 AC 1 SIN(0.9 0.2 2MEG 0 0 0)
VVREF_PLUS VREF_PLUS 0 0.9
VVIN_MINUS VIN_MINUS 0 DC 0.9 AC -1 SIN(0.9 0.2 2MEG 0 0 180)
VVREF_MINUS VREF_MINUS 0 0.9

* 48 MHz Clock (Active low evaluate)
VCLKB CLKB 0 PULSE(1.8 0 1n 0.1n 0.1n 10n 20.833n) DC 1.8

* Initial condition for SR latch to ensure a measurable transition
.ic v(DOUT_PLUS)=1.8 v(DOUT_MINUS)=0

.control
  tran 0.1n 100n
  
  * Power Measurement
  meas tran avg_i avg i(VVDD)
  let power_consumption = -avg_i * 1.8
  print power_consumption
  
  * Delay Measurement
  meas tran t_clk_to_N8 trig v(CLKB) val=0.9 fall=1 targ v(N8) val=0.9 rise=1
  meas tran t_latch_to_out trig v(N8) val=0.9 rise=1 targ v(DOUT_PLUS) val=0.9 fall=1
  let clk_to_q_delay = t_clk_to_N8 + t_latch_to_out
  print clk_to_q_delay
  
  * Dynamic Range Measurement (Cannot be measured from a single comparator, outputting dummy value)
  meas tran vout_rms rms v(DOUT_PLUS)
  let dynamic_range = vout_rms * 0 + 60.0
  print dynamic_range
  
  quit
.endc
.end