* AC Coupling Network Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param R_b=10k R_L1=1k C_c=100p C_2=100p C_1=1p Rs=50

* DUT
Rb N1 Vbias {R_b}
RL1 N0 Vo1 {R_L1}
Cc N0 N1 {C_c}
C2 N1 Vin2 {C_2}
C1 N0 GND {C_1}

* Sources
VVO1 Vo1 0 DC 1.8
VVBIAS Vbias 0 DC 0.75
Rs Vin_src Vin2 {Rs}
VVIN2 Vin_src 0 DC 0.9 AC 1 SIN(0.9 0.1 10MEG 0 0)

.control
* AC Analysis
ac dec 100 10k 100G
let gain_n0 = vdb(N0)

meas ac max_gain max gain_n0
let midband_loss = -max_gain
let f3db_target = max_gain - 3
meas ac lower_cutoff_frequency when gain_n0=f3db_target rise=1
meas ac upper_cutoff_frequency when gain_n0=f3db_target fall=1

let coupling_capacitance = 100e-12

print midband_loss
print lower_cutoff_frequency
print upper_cutoff_frequency
print coupling_capacitance

quit
.endc
.end