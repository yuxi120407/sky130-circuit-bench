* Substrate Parasitic Model Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* DUT
Cox N0 N1 10f
Rox N0 N1 1.7k
Rsi N1 GND 60

* Test Source (1A AC current injected into N0)
I1 GND N0 AC 1

.control
ac dec 100 1G 100G

* Calculate metrics over frequency
let omega = 2 * pi * frequency
let Z_mag = mag(v(N0))
let Z_phase = 180/PI * cph(v(N0))
let Z_real = real(v(N0))
let Z_imag = imag(v(N0))

let Y_real = real(1/v(N0))
let Y_imag = imag(1/v(N0))

let Rp = 1 / Y_real
let Cp = Y_imag / omega
let Q = abs(Z_imag) / Z_real

* Measure at 35 GHz (LNA operating frequency)
meas ac Z_mag_35G find Z_mag at=35G
meas ac Z_phase_35G find Z_phase at=35G
meas ac Rp_35G find Rp at=35G
meas ac Cp_35G find Cp at=35G
meas ac Q_35G find Q at=35G

print Z_mag_35G Z_phase_35G Rp_35G Cp_35G Q_35G
quit
.endc
.end