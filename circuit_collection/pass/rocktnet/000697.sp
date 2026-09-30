* LC-Ladder Matching Network Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Parameters for 5 GHz center frequency and 50 ohm system
.param R=50
.param f0=5G
.param w0='2*3.1415926535*f0'

* DUT (Values evaluated using parameters)
C1 ZIN GND {1/(w0*R)}
L1 ZIN N1 {R/w0}
R1 N1 GND R

* Stimulus: 1A AC current source to directly measure impedance as voltage
I1 GND ZIN AC 1

.control
* AC sweep from 1 GHz to 20 GHz
ac dec 100 1G 20G

* Calculate Impedance Magnitude and Phase
let z_mag = mag(v(ZIN))
let z_phase = 180/PI * cph(v(ZIN))

* Calculate S11 (Return Loss) referenced to 50 ohms
let s11_mag = mag((v(ZIN) - 50) / (v(ZIN) + 50))
let s11_db = 20 * log10(s11_mag + 1e-12)

* Measure metrics at 5 GHz
meas ac z_mag_5G find z_mag at=5G
meas ac z_phase_5G find z_phase at=5G
meas ac s11_db_5G find s11_db at=5G

print z_mag_5G z_phase_5G s11_db_5G
quit
.endc

.end