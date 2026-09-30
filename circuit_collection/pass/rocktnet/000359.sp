* VCO Active Core Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm4=5.0 L_xm4=0.5

* DUT
XM6 N2 VCON N3 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 VMOD N3 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM2 N2 N3 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 N2 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM1 N4 IBIAS6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM4 IBIAS6 IBIAS6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Ideal LC Tank for 2.4 GHz
L1 N2 VDD 2n
L2 N3 VDD 2n
C1 N2 N3 1p

* Sources
VVDD VDD 0 1.8
VIBIAS6 IBIAS6 0 1.2
VVCON VCON 0 2.0
VVMOD VMOD 0 2.5

* Initial condition to kickstart oscillation
.ic v(N2)=1.8 v(N3)=1.7

.control
  * 1. Measure DC Power
  op
  let P_dc = -i(VVDD) * 1.8
  print P_dc

  * 2. Transient Analysis for f_osc and Vpp at VCON = 2.0V
  tran 10p 100n uic
  
  let vdiff = v(N2) - v(N3)
  
  * Measure frequency over 10 cycles to ensure steady state
  meas tran t1 WHEN vdiff=0 rise=80
  meas tran t2 WHEN vdiff=0 rise=90
  let f_osc = 10 / (t2 - t1)
  print f_osc
  set f1 = $&f_osc
  
  * Measure peak-to-peak voltage
  meas tran vmax MAX vdiff from=40n to=100n
  meas tran vmin MIN vdiff from=40n to=100n
  let Vpp = vmax - vmin
  print Vpp

  * 3. Transient Analysis for Kvco at VCON = 2.5V
  alter VVCON 2.5
  tran 10p 100n uic
  
  let vdiff2 = v(N2) - v(N3)
  meas tran t3 WHEN vdiff2=0 rise=80
  meas tran t4 WHEN vdiff2=0 rise=90
  let f_osc2 = 10 / (t4 - t3)
  print f_osc2
  
  * Calculate tuning sensitivity
  let Kvco = (f_osc2 - $f1) / 0.5
  print Kvco
  
  quit
.endc
.end