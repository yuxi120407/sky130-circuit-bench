* Testbench for PMOS Pull-up Driver
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0

XM1 N1 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N0 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 LABEL_NET_2 LABEL_NET_3 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

VVDD VDD 0 1.8
* Inputs for transient (active low to turn on PMOS)
VN0 N0 0 PULSE(1.8 0 2n 0.1n 0.1n 80n 100n)
VL1 LABEL_NET_1 0 PULSE(1.8 0 2n 0.1n 0.1n 80n 100n)
VL3 LABEL_NET_3 0 0

* Load
Cload LABEL_NET_2 0 1p
Rload LABEL_NET_2 0 1Meg

.control
  tran 10p 90n
  
  * Measure rise time (10% to 80% of 1.8V)
  meas tran t_rise trig v(LABEL_NET_2) val=0.18 rise=1 targ v(LABEL_NET_2) val=1.44 rise=1
  
  * Measure average power
  let pwr = -i(VVDD) * 1.8
  meas tran p_avg avg pwr
  
  * Measure peak pull-up current (current out of VVDD is negative)
  meas tran i_peak min i(VVDD)
  let i_pullup_peak = -i_peak
  
  print i_pullup_peak t_rise p_avg
  quit
.endc
.end