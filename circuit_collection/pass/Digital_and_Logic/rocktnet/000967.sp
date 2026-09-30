* Dual Inverter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

* DUT
XM1 OUT IN_BAR GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUT_BAR IN GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 OUT_BAR IN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUT IN_BAR VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

* Load Capacitance
C1 OUT GND 10f
C2 OUT_BAR GND 10f

* Sources
VVDD VDD 0 1.8
VIN IN 0 PULSE(0 1.8 100p 20p 20p 400p 1n) DC 0
VIN_BAR IN_BAR 0 PULSE(1.8 0 100p 20p 20p 400p 1n) DC 1.8

.control
  * DC Analysis for logic threshold
  dc VIN 0 1.8 0.01
  meas dc vth_logic when v(OUT_BAR)=0.9
  
  * Transient Analysis
  tran 1p 3n
  
  * Delay measurements (IN to OUT_BAR)
  meas tran tplh trig v(IN) val=0.9 fall=1 targ v(OUT_BAR) val=0.9 rise=1
  meas tran tphl trig v(IN) val=0.9 rise=1 targ v(OUT_BAR) val=0.9 fall=1
  let tpd = (tplh + tphl) / 2
  print tpd
  
  * Rise and fall times (OUT_BAR)
  meas tran trise trig v(OUT_BAR) val=0.36 rise=1 targ v(OUT_BAR) val=1.44 rise=1
  meas tran tfall trig v(OUT_BAR) val=1.44 fall=1 targ v(OUT_BAR) val=0.36 fall=1
  
  * Dynamic power measurement (average over 1 cycle from 1ns to 2ns)
  meas tran p_dyn_integ integ i(VVDD) from=1n to=2n
  let p_dyn = -p_dyn_integ * 1.8 / 1n
  print p_dyn
  
  quit
.endc
.end