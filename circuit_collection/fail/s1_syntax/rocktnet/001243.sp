* Testbench for Dual-Path PLL Loop Filter
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* DUT
D1 N2 N0
D2 N2 N0
D4 N2 N0
D3 N3 N0
C1 N3 GND 5.2p
C2 14uA GND 41p
C3 140uA GND 1.7p
R1 140uA GND 153k
C4 N2 GND 52p
R2 N3 140uA 51k
R3 14uA N2 5k

* Bias the VCO tank node to ground
V_N0 N0 0 0V

* Add a large resistor to prevent floating nodes on the integral path
R_leak 14uA 0 1G

* AC Current sources for the two paths
I_int 0 14uA AC 1
I_prop 0 140uA AC 1

* Dummy diode models in case the parser requires them for D1-D4
.model DMOD D (CJO=1p)
.model N0 D (CJO=1p)

.control
ac dec 10 10 1Meg

* Integral path impedance
let z_int = v(14uA)
let z_int_mag = mag(z_int)
let phase_int = 180/PI * cph(z_int)

* Proportional path impedance
let z_prop = v(140uA)
let z_prop_mag = mag(z_prop)
let phase_prop = 180/PI * cph(z_prop)

meas ac z_prop_dc find z_prop_mag at=10
meas ac z_int_100k find z_int_mag at=100k
meas ac z_prop_100k find z_prop_mag at=100k
meas ac phase_int_100k find phase_int at=100k
meas ac phase_prop_100k find phase_prop at=100k

print z_prop_dc z_int_100k z_prop_100k phase_int_100k phase_prop_100k
quit
.endc
.end
