* Spiral Inductor Pi-Model Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_2140MHz=0.5
.param L_s=0.5

* Component values based on typical 270pH inductor
.param val_LS=270p val_RS=0.5 val_CS=10f val_CP1=20f val_CP2=20f val_RSUB1=50 val_RSUB2=50

* DUT
CP1 P1 N1 {val_CP1}
RSUB1 N1 GND {val_RSUB1}
CP2 P2 N2 {val_CP2}
RSUB2 N2 GND {val_RSUB2}
LS P1 N3 {val_LS}
RS N3 P2 {val_RS}
CS P1 P2 {val_CS}

* Stimulus and Biasing
* Drive port 1 with 1A AC to directly measure Z11 as V(P1)
I1 0 P1 dc 0 ac 1
* Ground port 2 for 1-port measurement
V2 P2 0 dc 0
* Connect netlist GND to SPICE global ground 0
V3 GND 0 dc 0

.control
* AC sweep from 100 MHz to 50 GHz to capture SRF
ac dec 100 100MEG 50G

* Calculate Impedance, Inductance, and Q-factor
let omega = 2 * pi * frequency
let Z = v(P1)
let R_s = real(Z)
let X_s = imag(Z)
let L_s = X_s / omega
let Q_factor = X_s / R_s

* Measure metrics at the paper's center frequency (2.14 GHz)
meas ac L_2140MHz find L_s at=2.14G
meas ac Q_2140MHz find Q_factor at=2.14G

* Measure Self-Resonance Frequency (where reactance crosses 0)
meas ac SRF when X_s=0 fall=1

print L_2140MHz Q_2140MHz SRF
quit
.endc
.end