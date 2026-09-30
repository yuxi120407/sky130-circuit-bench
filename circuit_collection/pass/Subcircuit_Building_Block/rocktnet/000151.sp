* Inductor Pi-Model Characterization Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_1_4G=0.5
.param L_ind=0.5

* Define the DUT as a subcircuit to pass parameters cleanly without modifying the original netlist syntax
.subckt ind_pi IN OUT GND Ls=2n Rs=2 Cs=50f Cox=100f Rsi=50 Csi=50f
LS IN N1 Ls
RS N1 OUT Rs
CS IN OUT Cs
Cox1 IN N2 Cox
RSi1 N2 GND Rsi
CSi1 N2 GND Csi
Cox2 OUT N3 Cox
RSi2 N3 GND Rsi
CSi2 N3 GND Csi
.ends

* Instantiate the DUT
* Port 2 (OUT) is grounded for 1-port Z-parameter measurement
X1 IN 0 0 ind_pi

* AC Current Source at Port 1 (IN)
* 1A AC current makes v(IN) directly equal to Z11
IIN 0 IN AC 1

.control
* Sweep from 100 MHz to 20 GHz to capture 1.4 GHz and SRF
ac dec 100 100MEG 20G

* Calculate Z11, Inductance, and Q
let Z11 = v(IN)
let L_ind = imag(Z11) / (2 * pi * frequency)
let Q_ind = imag(Z11) / real(Z11)

* Measure metrics at 1.4 GHz (operating frequency from paper)
meas ac L_1_4G find L_ind at=1.4G
meas ac Q_1_4G find Q_ind at=1.4G

* Measure Self-Resonant Frequency (where Q crosses 0, transitioning from inductive to capacitive)
meas ac SRF when Q_ind=0 fall=1

print L_1_4G Q_1_4G SRF
quit
.endc
.end