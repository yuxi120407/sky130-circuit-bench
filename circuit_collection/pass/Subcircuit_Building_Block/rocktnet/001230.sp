* Testbench for Voltage-Controlled Delay Cell

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

* DUT
XM1 VOUT VIN V_CONTROL GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VOUT VIN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}

* Sources
VVDD VDD 0 1.8
VVCTRL V_CONTROL 0 0.3
* 250 MHz Pulse input
VVIN VIN 0 PULSE(0 1.8 1n 0.1n 0.1n 1.9n 4n)

* Load capacitance
Cload VOUT 0 10f

.control
  * 1. Transient Analysis for Delay and Power
  tran 10p 20n
  
  * Measure delays at 50% of VDD (0.9V)
  meas tran t_delay_fall trig v(VIN) val=0.9 rise=1 targ v(VOUT) val=0.9 fall=1
  meas tran t_delay_rise trig v(VIN) val=0.9 fall=1 targ v(VOUT) val=0.9 rise=1
  
  * Measure average power consumption
  meas tran avg_current_vdd avg i(VVDD) from=0 to=20n
  let avg_power = -avg_current_vdd * 1.8
  print avg_power
  
  * 2. DC Analysis for Switching Threshold
  dc VVIN 0 1.8 0.01
  * Measure threshold when output crosses 1.0V (approximate midpoint considering V_CONTROL=0.3V)
  meas dc v_threshold when v(VOUT)=1.0 fall=1
  
  quit
.endc
.end