* LC Resonator Testbench

* Default parameters for passives to resonate in the GHz range
.param L2_val=2n L3_val=2n
.param RL2_val=2 RL3_val=2
.param CP1_val=500f CP2_val=200f CP3_val=200f CM4_val=200f

* DUT
RL3 GND N1 RL3_val
L3 N1 N2 L3_val
CP3 N2 GND CP3_val
CM4 N2 GND CM4_val
CP2 N2 GND CP2_val
RL2 N2 N3 RL2_val
L2 N3 OUT L2_val
CP1 OUT GND CP1_val

* Stimulus: 1A AC current source to measure impedance directly as V(OUT)
I1 GND OUT AC 1

.control
* AC Analysis from 100 MHz to 10 GHz
ac dec 200 100MEG 10G

* Calculate impedance magnitude and phase
let z_mag = mag(v(out))
let z_db = vdb(out)
let z_phase = 180/PI * cph(v(out))

* Find primary resonant frequency and peak impedance
meas ac z_max max z_mag
meas ac f_res when z_mag=z_max

* Calculate Q factor using 3dB bandwidth
let z_max_3db = z_max / 1.41421356
meas ac f_low when z_mag=z_max_3db rise=1
meas ac f_high when z_mag=z_max_3db fall=1
let bw = f_high - f_low
let q_factor = f_res / bw

print f_res z_max q_factor
.endc

.end