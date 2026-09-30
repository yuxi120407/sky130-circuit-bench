* Substrate Noise Model Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* DUT
R1 N1 substrate 0.03
R2 VSS substrate 0.14
C1 VDD N1 1.26n
C2 VDD VSS 2.28n

* Sources
VVDD VDD 0 DC 1.8 AC 1
VVSS VSS 0 DC 0

.control
ac dec 100 1k 100G

* Calculate transfer function in dB and total capacitance
let transfer_db = vdb(substrate)
let C_tot = mag(i(VVDD)) / (2 * 3.14159265 * frequency)

* Measure metrics
meas ac Total_Capacitance find C_tot at=10k
meas ac HF_Transfer_Gain find transfer_db at=100G

* Pole frequency is 3dB below the HF gain (-1.68 dB - 3.01 dB = -4.69 dB)
meas ac Pole_Frequency when transfer_db=-4.69 rise=1

print Total_Capacitance HF_Transfer_Gain Pole_Frequency
quit
.endc
.end