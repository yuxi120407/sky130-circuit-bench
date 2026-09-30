* RC Track-and-Hold Network Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param R_val=50
.param C_val=325f

* DUT
r IN OUT {R_val}
Ch OUT GND {C_val}

* Sources
VIN IN GND DC 0.9 AC 1 PULSE(0 1.8 100p 1p 1p 500p 1n)

.control
* AC Analysis for Bandwidth
ac dec 100 1Meg 100G
let gain_db = vdb(OUT)
meas ac bw_3db when gain_db=-3 fall=1

* Transient Analysis for Step Response
tran 0.1p 2n
meas tran t_rise trig v(OUT) val=0.18 rise=1 targ v(OUT) val=1.62 rise=1
meas tran t_fall trig v(OUT) val=1.62 fall=1 targ v(OUT) val=0.18 fall=1

print bw_3db t_rise t_fall
quit
.endc
.end