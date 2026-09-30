* Oscillator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

* DUT
XM1 N0 N2 P GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N0 P GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Testbench components
VVDD VDD 0 1.8
I_tail P 0 2m
L1 N0 VDD 5n
L2 N2 VDD 5n
C1 N0 N2 3.1p

* Initial condition to kickstart oscillation
.ic v(N0)=1.8 v(N2)=1.7

.control
  tran 10p 20n
  
  * Measure power consumption
  meas tran avg_current avg i(VVDD) from=10n to=20n
  let avg_power = -avg_current * 1.8
  print avg_power
  
  * Measure oscillation frequency
  meas tran t1 trig v(N0) val=1.8 rise=10
  meas tran t2 trig v(N0) val=1.8 rise=11
  let osc_freq = 1 / (t2 - t1)
  print osc_freq
  
  * Measure voltage swing
  meas tran vmax max v(N0) from=10n to=20n
  meas tran vmin min v(N0) from=10n to=20n
  let swing = vmax - vmin
  print swing
  
  quit
.endc
.end