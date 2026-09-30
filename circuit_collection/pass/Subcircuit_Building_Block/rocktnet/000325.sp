* AFFC Small-Signal Model Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param R1_val=100k
.param C1_val=11p
.param ra_val=1k
.param Ca_val=3p
.param RL_val=100k
.param CL_val=100p
.param gm_val=1m

* DUT
R1 V2 GND {R1_val}
C1 V2 GND {C1_val}
I1 GND V2 DC 0 AC 1
G1 Vo GND V2 GND {gm_val}
ra Va GND {ra_val}
Ca Va Vo {Ca_val}
RL Vo GND {RL_val}
CL Vo GND {CL_val}

* Dummy VDD for power measurement
Vdd VDD GND 1.8

.control
op
let power_consumption = -i(Vdd)*1.8
print power_consumption

ac dec 100 1 100Meg
let gain_db = db(v(Vo))
meas ac dc_gain find gain_db at=1
let target_gain = dc_gain - 3
meas ac bandwidth when gain_db=target_gain fall=1

print dc_gain
print bandwidth
quit
.endc
.end