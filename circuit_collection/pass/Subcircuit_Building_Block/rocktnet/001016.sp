* Peak Detector / Track-and-Hold Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Parameters
.param C_hold=325f

* DUT (Corrected syntax for standard SPICE diode)
D1 IN OUT DMOD
Ch OUT 0 {C_hold}

* Generic Diode Model (since specific SKY130 diode isn't instantiated by name)
.model DMOD D(IS=1e-14 RS=10 N=1)

* Sources
VIN IN 0 DC 0.9 AC 1 SIN(0.9 0.9 1MEG 0 0)

* Analyses
.control
  * Run transient analysis for 1ms to reach steady state
  tran 2n 1m
  
  * Measure peak voltage in steady state (last 10us)
  meas tran v_peak max v(OUT) from=990u to=1m
  
  * Measure minimum voltage in steady state to calculate ripple
  meas tran v_min min v(OUT) from=990u to=1m
  let ripple = v_peak - v_min
  print ripple
  
  * Measure average power drawn from VIN
  let p_in = -v(IN)*i(VIN)
  meas tran power_consumption avg p_in from=990u to=1m
  
  quit
.endc
.end