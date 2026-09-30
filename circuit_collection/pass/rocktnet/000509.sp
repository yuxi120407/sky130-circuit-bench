* Passive Input Network Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* DUT
C1 IN N1 0.1u
R1 N1 N2 1k
R2 N2 N3 1k
R3 IN GND 50
C2 N3 GND 1p
L1 N3 to_chip 1n

* Dummy VDD for power measurement
VDD vdd GND 1.8

* Load representing TIA input impedance
Rload to_chip GND 50

* Sources
VIN IN GND DC 0 AC 1 pulse(0 1 1n 100p 100p 5n 10n)

.control
* AC Analysis
ac dec 100 1Meg 10G
let v_out_db = db(v(to_chip))
meas ac transimpedance_gain max v_out_db
let target_gain = transimpedance_gain - 3
meas ac bandwidth when v_out_db=target_gain fall=1

* Transient Analysis
tran 10p 20n
meas tran delay trig v(IN) val=0.5 rise=1 targ v(to_chip) val=0.012 rise=1

* DC Analysis
op
let power_consumption = -i(VDD) * 1.8
print power_consumption

quit
.endc
.end