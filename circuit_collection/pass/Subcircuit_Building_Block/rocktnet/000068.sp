* RC Network Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Parameterized component values
.param R1_val=50 R2_val=50 R3_val=1k R4_val=50
.param C1_val=1p C2_val=1p

* DUT
C1 n1 GND {C1_val}
C2 n0 n2 {C2_val}
R1 n1 label_net_0 {R1_val}
R2 n1 n2 {R2_val}
R3 n1 GND {R3_val}
R4 n0 GND {R4_val}

* Stimulus
Vin label_net_0 GND dc 0.9 ac 1 pulse(0 1.8 1n 100p 100p 5n 10n)

.control
  * AC Analysis
  ac dec 100 1Meg 10G
  let gain_db = db(v(n0))
  
  * Measure gain at 900 MHz
  meas ac gain_900m find gain_db at=900Meg
  
  * Measure peak gain
  meas ac peak_gain max gain_db
  
  * Transient Analysis
  tran 10p 20n
  
  * Measure max output voltage
  meas tran v_out_max max v(n0)
  
  print gain_900m peak_gain v_out_max
  quit
.endc
.end