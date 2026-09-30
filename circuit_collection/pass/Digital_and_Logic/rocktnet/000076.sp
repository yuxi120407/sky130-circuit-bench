* MCML Buffer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5

* DUT
XM1 N4 N2 N1 N1 sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 GND VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N3 N1 N1 sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 GND N4 N4 sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 GND N3 N3 sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 GND VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}

* Power and Bias Sources
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9

* Input signals (Common mode 1.5V, differential swing 0.4V)
VINP N2 0 DC 1.5 AC 0.5 PULSE(1.3 1.7 0 10p 10p 100p 200p)
VINN N3 0 DC 1.5 AC -0.5 PULSE(1.7 1.3 0 10p 10p 100p 200p)

* Load capacitance (simulating next stage)
C1 N4 0 10f
C2 N0 0 10f

.control
  * 1. DC Operating Point
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. AC Analysis
  ac dec 50 10Meg 100G
  let vout_diff = v(N0) - v(N4)
  let gain_db = 20 * log10(mag(vout_diff))
  meas ac dc_gain find gain_db at=10Meg
  let target_gain = dc_gain - 3
  meas ac bw_3db when gain_db = target_gain fall=1

  * 3. Transient Analysis
  tran 1p 600p
  let vout_diff = v(N0) - v(N4)
  let vin_diff = v(N2) - v(N3)
  
  meas tran vout_max max vout_diff
  meas tran vout_min min vout_diff
  let vout_swing = vout_max - vout_min
  print vout_swing
  
  * Delay measurement (crossing 0V)
  meas tran t_delay trig vin_diff val=0 rise=2 targ vout_diff val=0 rise=2
  
  * Rise and Fall times (approximate 20-80% based on expected +/- 0.4V swing)
  meas tran t_rise trig vout_diff val=-0.2 rise=2 targ vout_diff val=0.2 rise=2
  meas tran t_fall trig vout_diff val=0.2 fall=2 targ vout_diff val=-0.2 fall=2
  
  quit
.endc
.end
