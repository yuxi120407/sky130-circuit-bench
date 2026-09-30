* Small-Signal Model Testbench for Frequency Divider

* Define small-signal parameters for SKY130 estimation
.param gmp1_val=100u GL_val=100u gmn3_val=1m CL_val=5f gmn1_val=114u

* DUT (Translated from paper's small-signal pseudo-netlist)
R1 VDD Vo {1/gmp1_val}
R2 VDD Vo {1/GL_val}
G1 Vo 0 Vin 0 gmn3_val
C1 Vo 0 CL_val
G2 Vo 0 Vo 0 gmn1_val

* Sources
VVDD VDD 0 DC 1.8
VVin Vin 0 DC 0 AC 1

* Analysis
.control
ac dec 100 1M 100G

* Measure DC Gain
let gain_db = vdb(Vo)
meas ac dc_gain find gain_db at=1M

* Measure 3dB Bandwidth
let gain_3db = dc_gain - 3
meas ac bw_3db when gain_db=gain_3db fall=1

* Measure Unity Gain Frequency
meas ac ugf when gain_db=0 fall=1

print dc_gain bw_3db ugf
quit
.endc
.end