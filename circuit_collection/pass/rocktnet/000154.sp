* Interconnect Model Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Parameterized component values for the interconnect model
.param r1_val=50 r2_val=100 l1_val=1n l2_val=0.5n c1_val=100f

* DUT (Interconnect Model)
R1 IN N1 {r1_val}
L1 N1 VOUT {l1_val}
R2 IN N2 {r2_val}
L2 N2 VOUT {l2_val}
C1 VOUT 0 {c1_val}

* Stimulus Sources
* AC source for bandwidth measurement, Pulse source for transient step response
VIN IN 0 DC 0 AC 1 PULSE(0 1.8 100p 20p 20p 500p 1n)

.control
  * AC Analysis
  ac dec 100 1Meg 100G
  let gain_db = db(v(VOUT))
  meas ac bandwidth when gain_db=-3 fall=1
  
  * Transient Analysis
  tran 1p 2n
  meas tran delay trig v(IN) val=0.9 rise=1 targ v(VOUT) val=0.9 rise=1
  meas tran rise_time trig v(VOUT) val=0.36 rise=1 targ v(VOUT) val=1.44 rise=1
  meas tran overshoot max v(VOUT)
  
  print bandwidth delay rise_time overshoot
  quit
.endc

.end