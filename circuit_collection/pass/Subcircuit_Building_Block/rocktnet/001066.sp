* Constant Slew Rate Ethernet Line Driver Bias Circuit Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

* Parameters
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

* DUT
XM1 VDD N3 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 N0 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

* Sources and Biasing
VVDD VDD 0 1.8
VIN N3 0 PULSE(0 1.8 2n 0.1n 0.1n 10n 20n)
VBIAS N2 0 0.9

* Tail current and Load
I_TAIL N1 0 100u
R_LOAD VDD N0 10k
C_LOAD N0 0 50f

* Analysis
.control
  * Operating Point for Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * Transient Analysis for Timing
  tran 10p 30n
  
  * The output N0 swings between approx 0.8V (when XM2 is ON) and 1.8V (when XM2 is OFF)
  * 10% to 90% of this 1V swing is 0.9V to 1.7V
  meas tran t_rise trig v(N0) val=0.9 rise=1 targ v(N0) val=1.7 rise=1
  meas tran t_fall trig v(N0) val=1.7 fall=1 targ v(N0) val=0.9 fall=1
  
  * Calculate Slew Rate (V/us) = dV / dt = 0.8V / t_rise * 1e-6
  let slew_rate = 0.8 / t_rise * 1e-6
  
  print t_rise t_fall slew_rate
  quit
.endc
.end