* Cross-coupled latch testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Parameters
.param W_m1=5.0 L_m1=0.15
.param R_load=1k C_load=10f I_tail=1m

* Supply and Bias
VVDD VDD 0 1.8
Ibias N2 0 {I_tail}

* DUT (Adapted from NPN to SKY130 CMOS for compatibility)
XM1 Vout Vout_bar N2 0 sky130_fd_pr__nfet_01v8 w={W_m1} l={L_m1}
XM2 Vout_bar Vout N2 0 sky130_fd_pr__nfet_01v8 w={W_m1} l={L_m1}
CL1 VDD Vout_bar {C_load}
CL2 VDD Vout {C_load}
RL1 VDD Vout {R_load}
RL2 VDD Vout_bar {R_load}

* Initial conditions to trigger regeneration (2mV initial difference)
.ic v(Vout)=1.299 v(Vout_bar)=1.301

.control
  * Run transient analysis
  tran 1p 2n
  
  * 1. Power Consumption
  meas tran avg_current avg i(VVDD)
  let power_consumption = -avg_current * 1.8
  print power_consumption
  
  * 2. Voltage Swing
  meas tran vout_max max v(Vout_bar)
  meas tran vout_min min v(Vout)
  let voltage_swing = vout_max - vout_min
  print voltage_swing
  
  * 3. Regeneration Time (Time to grow from 10mV to 800mV difference)
  let vdiff = v(Vout_bar) - v(Vout)
  meas tran regeneration_time trig vdiff val=0.01 rise=1 targ vdiff val=0.8 rise=1
  print regeneration_time
  
  quit
.endc
.end