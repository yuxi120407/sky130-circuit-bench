* Substrate Noise Model Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* DUT
R1 substrate N6 0.75
R2 N2 substrate 0.21
R3 substrate VSS 0.12
R4 substrate N7 0.57
C1 VDDE VSS 145p
C2 VSS VSSE 218p
C3 VSSE N7 52p
C4 VDD N6 19p
C5 VDD VSS 77p
C6 VDDE N2 53p
C7 VDDE VSSE 42p
C8 VDD VSSE 30p
C9 VDD VDDE 33p

* DC paths for floating nodes to prevent singular matrix errors
R_dc_vdde VDDE 0 1G
R_dc_vsse VSSE 0 1G

* Sources
VVDD VDD 0 DC 1.8 AC 1
VVSS VSS 0 DC 0

.control
ac dec 100 1Meg 10G

let coupling_db = vdb(substrate)
let z_vdd_mag = 1 / mag(i(VVDD))

meas ac coupling_100M find coupling_db at=100MEG
meas ac coupling_1G find coupling_db at=1G
meas ac z_vdd_100M find z_vdd_mag at=100MEG
meas ac z_vdd_1G find z_vdd_mag at=1G

print coupling_100M coupling_1G z_vdd_100M z_vdd_1G
quit
.endc
.end