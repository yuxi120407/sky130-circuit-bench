* Flash ADC Preamplifier Testbench
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

* DUT
XM1 N1 INN N4 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUTP CLK GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 BIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUTP OUTP GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 OUTP CLK GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N6 N6 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 OUTP N6 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 N1 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 OUTP N1 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N6 INP N4 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 OUTP OUTN GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}

* Fix floating nodes from extraction
V_N5 N5 VDD 0
V_N2 N2 VDD 0
V_OUTN OUTN 0 0

* Power and Bias
VVDD VDD 0 1.8
VBIAS BIAS 0 0.7
VCLK CLK 0 DC 0 PULSE(0 1.8 5n 0.1n 0.1n 5n 10n)

* Inputs
VINP INP 0 DC 0.9 AC 0.5
VINN INN 0 DC 0.9 AC -0.5

.control
  * 1. DC Operating Point & Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. AC Analysis for Gain, Bandwidth, and Input Capacitance
  ac dec 100 1Meg 100G
  let vdiff = v(N1) - v(N6)
  let gain_mag = mag(vdiff)
  let gain_db = 20 * log10(gain_mag)
  
  meas ac dc_gain find gain_db at=1Meg
  meas ac bw_3db when gain_db='dc_gain - 3' fall=1
  
  let i_in_mag = mag(i(VINP))
  meas ac i_in_1g find i_in_mag at=1G
  let cin = i_in_1g / (2 * 3.14159 * 1e9 * 0.5)
  print cin

  * 3. Transient Analysis for Reset Behavior
  tran 0.1n 20n
  meas tran outp_max max v(OUTP)
  meas tran outp_min min v(OUTP)
  
  quit
.endc
.end
