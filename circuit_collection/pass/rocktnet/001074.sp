* Inductor Pi-Model Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_2G4=0.5
.param L_eff=0.5

* AC Current Source for 1-port Z-parameter measurement
I1 GND N0 dc 0 ac 1

* Ground Port 2
V1 N1 GND dc 0

* DUT (Inductor Pi-Model with typical values for 2.7nH)
Cp2 N1 GND 100f
Cp1 N0 GND 100f
L N0 N2 2.7n
Cs N0 N1 50f
Rp1 N0 GND 500
Rs N1 N2 4
Rp2 N1 GND 500

.control
* Run AC analysis from 100 MHz to 20 GHz
ac dec 100 100Meg 20G

* Calculate Impedance, Inductance, and Q
let Z = v(N0)
let ReZ = real(Z)
let ImZ = imag(Z)
let freq = frequency
let L_eff = ImZ / (2 * pi * freq)
let Q = ImZ / ReZ

* Measure metrics at 2.4 GHz
meas ac L_2G4 find L_eff at=2.4G
meas ac Q_2G4 find Q at=2.4G

* Measure Self-Resonance Frequency (SRF)
meas ac SRF when ImZ=0 fall=1

print L_2G4 Q_2G4 SRF
quit
.endc
.end