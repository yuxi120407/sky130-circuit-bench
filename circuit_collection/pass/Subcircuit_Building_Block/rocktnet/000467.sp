* LDO Feedback Network Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param R1_val=100k
.param R2_val=100k
.param C1_val=5p

* DUT (Values parameterized to fix extraction syntax)
RF1 Vs Vx {R1_val}
RF2 Vx GND {R2_val}
CF1 Vs Vx {C1_val}

* Stimulus
V_Vs Vs GND DC 1.8 AC 1 pulse(0 1.8 1n 1n 1n 10u 20u)

.control
  * AC Analysis
  ac dec 100 1k 10Meg
  let gain_mag = mag(v(Vx))/mag(v(Vs))
  let phase_deg = 57.2957795131 * (ph(v(Vx)) - ph(v(Vs)))
  
  * Measure DC feedback factor at low frequency (1kHz)
  meas ac dc_feedback_factor find gain_mag at=1k
  
  * Measure zero frequency (approximate by phase reaching 10 degrees)
  meas ac zero_frequency when phase_deg=10 rise=1
  
  * Measure pole frequency (approximate by phase returning to 10 degrees)
  meas ac pole_frequency when phase_deg=10 fall=1

  * Transient Analysis
  tran 1n 5u
  meas tran vx_max max v(Vx)
  meas tran vx_final find v(Vx) at=4u
  let transient_overshoot = (vx_max - vx_final)/vx_final * 100
  print transient_overshoot
  
  quit
.endc
.end