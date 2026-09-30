* Standing-Wave Oscillator Model Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param R_val=5
.param L_val=0.5n
.param C_val=0.5p
.param Rneg_val=-150

* DUT
R IN N1 {R_val}
L N1 OUT {L_val}
C OUT GND {C_val}
R2 OUT GND Rneg_val

* Ground definition
* VGND GND 0 DC 0

* Stimulus
VIN IN 0 DC 0 AC 1 PULSE(0 1 0 1p 1p 10p 10n)

.control
  * AC Analysis
  ac dec 1000 1G 100G
  let vout_mag = db(v(OUT))
  meas ac resonant_peak_magnitude max vout_mag
  
  * Transient Analysis
  tran 1p 2n
  meas tran osc_period TRIG v(OUT) VAL=0 RISE=10 TARG v(OUT) VAL=0 RISE=11
  let oscillation_frequency = 1 / osc_period
  
  print oscillation_frequency
  print resonant_peak_magnitude
  quit
.endc
.end