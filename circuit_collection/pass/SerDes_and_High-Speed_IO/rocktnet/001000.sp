* Full-Duplex Line Driver Testbench

* Amplifier Subcircuit (replaces generic A1 block)
.subckt amplifier in out
E1 int GND in GND -2
Rout int out 50
.ends

* DUT
IDAC VC GND DC 0 AC 1
X_A1 VC VLINE amplifier
R VC VH 1k
R2 VH VLINE 1k
RL VLINE GND 50
I2irx GND VLINE DC 0 AC 0

.control
ac dec 10 1 1G
let tx_gain = vdb(VLINE)
let echo_leakage = vdb(VH)

meas ac tx_gain_1M find tx_gain at=1Meg
meas ac echo_leakage_1M find echo_leakage at=1Meg

print tx_gain_1M echo_leakage_1M
quit
.endc
.end