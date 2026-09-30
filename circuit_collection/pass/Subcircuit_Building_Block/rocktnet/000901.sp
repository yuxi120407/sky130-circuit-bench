* RC Sampling Network Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param R_val=50
.param C_val=1p

* DUT (with component values appended to generic netlist)
V_en_Rsrc_2 N2 N0 dc 0
V_en_Ron N1 Vout_2 dc 0
V_en_Rmatch N2 N3 dc 0
Rmatch N3 GND {R_val}
Ron N1 N2 {R_val}
Rsrc_2 N0 GND {R_val}
Ch Vout_2 GND {C_val}

* Sources
VDD vdd 0 1.8
Vin N2 0 dc 0.9 ac 1 pulse(0 1.8 0 10p 10p 5n 10n)

.control
  * AC Analysis
  ac dec 100 10M 10G
  let gain_db = vdb(Vout_2)
  meas ac bandwidth when gain_db=-3 fall=1
  meas ac loss_2_4G find gain_db at=2.4G
  print bandwidth loss_2_4G

  * Transient Analysis
  tran 1p 10n
  meas tran rise_time trig v(Vout_2) val=0.18 rise=1 targ v(Vout_2) val=1.62 rise=1
  print rise_time
  
  quit
.endc
.end