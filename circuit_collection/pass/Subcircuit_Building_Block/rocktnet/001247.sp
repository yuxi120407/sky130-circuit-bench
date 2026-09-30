* Incomplete Loop Filter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Supply and Input Voltages
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9

* DUT (Extracted Netlist with 0A defaults added to prevent syntax errors)
I4 LABEL_NET_0 0 0
I2 VDD N0 0
I3 LABEL_NET_1 0 0
I1 VDD N1 0
R N2 0 1k
C2 N2 0 1u
C1 N3 0 1u
Vc N2 N3 DC 0

* Dummy resistors to prevent floating node singular matrix errors
R_dummy_N0 N0 0 1G
R_dummy_N1 N1 0 1G

.control
op

* Measure Power Consumption
let power = -i(VVDD) * 1.8
print power

* Measure Filter Voltage
print v(N2)
print v(N3)

quit
.endc
.end