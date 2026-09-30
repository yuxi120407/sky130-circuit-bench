* Folded Cascode OTA Testbench

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
XM1 N3 INN N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 BIAS_4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 OUTN BIAS_3 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUTP BIAS_2 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 OUTN BIAS_2 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 BIAS_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 INP N0 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N10 BIAS_4 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N2 BIAS_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 OUTP BIAS_3 N10 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N7 BIAS_4 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}

* Fix floating N6 node (assumed ground connection for bottom current sources)
V_N6 N6 0 0

* Power Supply
V_VDD VDD 0 1.8

* Biasing
V_BIAS4 BIAS_4 0 0.6
V_BIAS3 BIAS_3 0 1.0
V_BIAS2 BIAS_2 0 0.8

* Ideal CMFB for BIAS_1 to hold output common-mode at 0.9V
B_CMFB BIAS_1 0 V=1.0+10*(v(OUTP)+v(OUTN)-1.8)

* Input Signals (Common mode = 0.9V, AC = 1V diff, Transient = 100mV diff peak)
V_INCM IN_CM 0 0.9
V_INP INP IN_CM DC 0 AC 0.5 SIN(0 0.05 1MEG 0 0)
V_INN INN IN_CM DC 0 AC -0.5 SIN(0 -0.05 1MEG 0 0)

* Load Capacitors (from paper)
C_LP OUTP 0 3.5p
C_LN OUTN 0 3.5p

* Differential Output VCVS for easy measurement
E_DIFF OUT_DIFF 0 OUTP OUTN 1

.control
  * DC Operating Point
  op
  let power = -i(V_VDD) * 1.8
  print power
  print v(OUTP) v(OUTN) v(BIAS_1)

  * AC Analysis
  ac dec 100 1 1G
  let gain_db = vdb(OUT_DIFF)
  let phase = 180/PI * cph(v(OUT_DIFF))
  let phase_margin = 180 + phase
  
  meas ac dc_gain find gain_db at=10
  meas ac ugf when gain_db=0 fall=1
  meas ac pm find phase_margin when gain_db=0 fall=1

  * Transient Analysis
  tran 10n 5u
  meas tran vout_diff_max max v(OUT_DIFF)
  meas tran vout_diff_min min v(OUT_DIFF)
  
  quit
.endc
.end
