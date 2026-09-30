* Miniature 3-D Inductor Pi-Model Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_eff=0.5
.param L_lowfreq=0.5

* Component values (parameterized based on paper)
.param Ls_val=7.8n Rs_val=5 Cf_val=36.5f
.param Cox_val=100f Csub_val=50f Rsub_val=100

* DUT
Ls IN N1 Ls_val
Rs N1 OUT Rs_val
Cf IN OUT Cf_val
Cox1 IN N2 Cox_val
Csub1 N2 GND Csub_val
Rsub1 N2 GND Rsub_val
Cox2 OUT N3 Cox_val
Csub2 N3 GND Csub_val
Rsub2 N3 GND Rsub_val

* Testbench setup
Vgnd GND 0 DC 0
Vout OUT 0 DC 0
Iin 0 IN AC 1

.control
ac dec 100 100MEG 30G

* Calculate Impedance and Inductor Metrics
let omega = 2 * pi * frequency
let Z11_real = real(v(IN))
let Z11_imag = imag(v(IN))
let L_eff = Z11_imag / omega
let Q = Z11_imag / Z11_real

* Measure Metrics
meas ac SRF when Z11_imag=0 fall=1
meas ac Q_max max Q
meas ac L_lowfreq find L_eff at=100MEG

print SRF Q_max L_lowfreq
quit
.endc
.end