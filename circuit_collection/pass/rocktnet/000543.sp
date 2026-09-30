* Cross-coupled NMOS LC VCO Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* DUT (Cross-coupled pair)
.param W_xm1=10.0 L_xm1=0.15
.param W_xm2=10.0 L_xm2=0.15

XM1 N1 N2 0 0 sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N1 0 0 sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Testbench Components (Supply and LC Tank)
VDD VDD 0 1.8
L1 VDD N1 5n
L2 VDD N2 5n
C1 N1 0 1.2p
C2 N2 0 1.2p
R1 N1 VDD 1k
R2 N2 VDD 1k

* Kickstart current pulse to induce oscillation
Ikick N1 N2 PWL(0 0 100p 10m 200p 0)

.control
  * Run transient analysis for 50ns
  tran 5p 50n
  
  * Measure oscillation frequency (period between 25th and 26th rising edge)
  meas tran t1 trig v(N1) val=1.8 rise=25 targ v(N1) val=1.8 rise=26
  let oscillation_frequency = 1 / t1
  print oscillation_frequency
  
  * Measure peak-to-peak voltage swing
  meas tran vmax max v(N1) from=30n to=50n
  meas tran vmin min v(N1) from=30n to=50n
  let voltage_swing_pkpk = vmax - vmin
  print voltage_swing_pkpk
  
  * Measure DC power consumption
  meas tran ivdd avg i(VDD) from=30n to=50n
  let power_consumption = -ivdd * 1.8
  print power_consumption
  
  * Measure DC-to-RF efficiency
  * P_RF = 2 * (V_rms^2 / R) = 2 * ((vpp/2/sqrt(2))^2 / 1000) = vpp^2 / 4000
  let p_rf = (voltage_swing_pkpk * voltage_swing_pkpk) / 4000
  let dc_to_rf_efficiency = (p_rf / power_consumption) * 100
  print dc_to_rf_efficiency
  
  quit
.endc
.end