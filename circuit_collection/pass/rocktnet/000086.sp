* Testbench for Passive RF Network

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Parameter definitions
.param val_c1=10p
.param val_c2=100f
.param val_r1=50

* DUT Instantiation
C1 n0 n1 {val_c1}
C2 n1 GND {val_c2}
R1 n0 GND {val_r1}

* Stimulus
Vin n1 GND dc 0 ac 1

* Control block
.control
  * AC Analysis from 1 MHz to 10 GHz
  ac dec 100 1Meg 10G
  
  * Calculate gain in dB
  let gain_db = db(v(n0))
  
  * Measure gain at 2.4 GHz
  meas ac gain_2_4GHz find gain_db at=2.4G
  
  * Measure -3dB cutoff frequency
  meas ac cutoff_frequency when gain_db=-3.0 rise=1
  
  * Print results
  print gain_2_4GHz
  print cutoff_frequency
  
  quit
.endc
.end