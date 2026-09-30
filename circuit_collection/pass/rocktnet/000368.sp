* Testbench for Delay Cell
.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

* DUT
XM2 Y X Y GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM1 X Y GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM3 GND Y GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 GND X GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Sources and external components
VVDD VDD 0 1.8
Rpullup X VDD 10k
VY Y 0 PULSE(0 1.8 1n 100p 100p 4.9n 10n)

* Load PDK
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.control
  * Transient Analysis
  tran 10p 20n
  
  * Measure delays
  meas tran t_delay_fall trig v(Y) val=0.9 rise=1 targ v(X) val=0.9 fall=1
  meas tran t_delay_rise trig v(Y) val=0.9 fall=1 targ v(X) val=0.9 rise=1
  
  * Measure rise and fall times
  meas tran t_rise trig v(X) val=0.36 rise=1 targ v(X) val=1.44 rise=1
  meas tran t_fall trig v(X) val=1.44 fall=1 targ v(X) val=0.36 fall=1
  
  * Measure power
  let inst_power = -i(VVDD) * 1.8
  meas tran avg_power avg inst_power from=0 to=20n
  
  * DC Analysis
  dc VY 0 1.8 0.01
  meas dc v_threshold when v(X)=0.9 fall=1
  
  print t_delay_fall t_delay_rise t_rise t_fall avg_power v_threshold
  quit
.endc
.end
