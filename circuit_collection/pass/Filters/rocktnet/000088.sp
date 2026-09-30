* Passive High-Pass Filter / Splitter Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Component parameters (assumed for 2.4GHz operation)
.param C_val=1p
.param R_val=50

* DUT
C1 n1 n2 {C_val}
C2 n0 n3 {C_val}
R1 n2 GND {R_val}
R2 n1 GND {R_val}
R3 n3 GND {R_val}
C3 n0 n1 {C_val}

* Stimulus
Vin n0 GND dc 0 ac 1

.control
* AC Analysis from 100 MHz to 10 GHz
ac dec 100 100Meg 10G

* Calculate dB magnitudes
let v_n2_db = db(v(n2))

* Measure insertion loss at 2.4 GHz
meas ac insertion_loss_2g4 find v_n2_db at=2.4G

* Measure -3dB cutoff frequencies (assuming 0dB passband gain)
meas ac cutoff_frequency when v_n2_db=-3 rise=1

print insertion_loss_2g4 cutoff_frequency
quit
.endc
.end