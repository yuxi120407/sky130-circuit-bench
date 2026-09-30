* Differential Inductive Load Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_900M_L=0.5
.param L_900M_R=0.5
.param L_est_L=0.5
.param L_est_R=0.5

* DUT
L1 VDD OUTR 16.5nH
L2 VDD OUTL 16.5nH

* DC Supply
VVDD VDD 0 1.8

* AC Current Sources for Impedance Measurement
* Injecting 1A AC current into the nodes to measure impedance directly as voltage
I1 0 OUTR DC 0 AC 1
I2 0 OUTL DC 0 AC 1

* Analysis
.ac dec 100 100MEG 10G

.control
  run
  
  * Calculate impedance magnitude (V = I*Z, since I=1A, mag(V) = mag(Z))
  let Z_mag_R = mag(v(OUTR))
  let Z_mag_L = mag(v(OUTL))
  
  * Measure impedance at 900 MHz
  meas ac Z_900M_R find Z_mag_R at=900MEG
  meas ac Z_900M_L find Z_mag_L at=900MEG
  
  * Extract inductance L=Z / (2 * pi * f)
  let L_est_R = Z_mag_R / (2 * 3.1415926535 * frequency)
  let L_est_L = Z_mag_L / (2 * 3.1415926535 * frequency)
  
  * Measure extracted inductance at 900 MHz
  meas ac L_900M_R find L_est_R at=900MEG
  meas ac L_900M_L find L_est_L at=900MEG
  
  print Z_900M_R Z_900M_L L_900M_R L_900M_L
  quit
.endc
.end
