* On-Chip Spiral Inductor Model Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param Ls_val=2n Rs_val=2 Cp_val=50f Csub_val=100f Rsub_val=100

* DUT
Csub IN N1 Csub_val
Rsub N1 GND Rsub_val
Cp IN GND Cp_val
Ls IN N2 Ls_val
Rs N2 GND Rs_val

* AC Current Source for Impedance Measurement (Z = V(IN)/1 = V(IN))
I1 GND IN AC 1

.control
* AC analysis from 100 MHz to 20 GHz
ac dec 100 100MEG 20G

* Calculate Impedance, Q, and Leq
let Z = v(IN)
let ReZ = real(Z)
let ImZ = imag(Z)
let Q = ImZ / ReZ
let omega = 2 * pi * frequency
let Leq = ImZ / omega

* Measure Self-Resonant Frequency (SRF)
meas ac srf when ImZ=0 fall=1

* Measure Peak Q and Frequency at Peak Q
meas ac max_Q max Q
meas ac freq_max_Q MAX_AT Q

* Measure Equivalent Inductance at 1 GHz
meas ac Leq_1G find Leq at=1G

print srf max_Q freq_max_Q Leq_1G
quit
.endc
.end