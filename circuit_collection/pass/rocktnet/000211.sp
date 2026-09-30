* Colpitts Oscillator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param C2_val=1p
.param L_val=0.5
.param L_xm1=0.5
.param R_val=10k

.param W_xm1=20 L_xm1=0.15
.param C1_val=5p C2_val=5p L_val=1n R_val=1k I_bias=5m

VVDD VDD 0 1.8

I1 VDD N1 {I_bias}
C1 N1 0 {C1_val}
C2 N0 0 {C2_val}
XM1 N1 N0 0 0 sky130_fd_pr__nfet_01v8 W={W_xm1} L={L_xm1}
R N1 0 {R_val}
L N0 N1 {L_val}

.ic v(N1)=1.8 v(N0)=0

.control
  tran 10p 20n uic
  
  meas tran v_max max v(N1) from=10n to=20n
  meas tran v_min min v(N1) from=10n to=20n
  let output_voltage_pp = v_max - v_min
  print output_voltage_pp
  
  meas tran t_period trig v(N1) val=0.9 rise=20 targ v(N1) val=0.9 rise=21
  let oscillation_frequency = 1 / t_period
  print oscillation_frequency
  
  meas tran I_vdd avg i(VVDD) from=10n to=20n
  let power_consumption = -I_vdd * 1.8
  print power_consumption
  
  let min_bias_current = -I_vdd
  print min_bias_current
  
  quit
.endc
.end