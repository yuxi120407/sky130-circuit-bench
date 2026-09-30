* Testbench for Capacitive Network

.param c_val=1p

* DUT (Values appended to satisfy SPICE syntax)
CDS N0 GND {c_val}
CFIX N0 IN {c_val}
CGS N1 GND {c_val}
CGD N0 N1 {c_val}

* Sources
VGND GND 0 DC 0
VIN IN GND DC 0 AC 1

.control
ac dec 100 100MEG 10G

* Calculate equivalent capacitance and impedance
let omega = 2 * PI * frequency
let i_in = -i(VIN)
let z_in = 1 / i_in
let c_eq = imag(i_in) / omega

* Measure at 2.5 GHz
meas ac C_eq_2_5G find c_eq at=2.5G
meas ac Z_in_2_5G find mag(z_in) at=2.5G

print C_eq_2_5G Z_in_2_5G
.endc

.end