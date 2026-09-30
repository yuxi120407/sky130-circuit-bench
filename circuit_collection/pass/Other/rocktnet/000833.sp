* ESD Equivalent Circuit Testbench

* Define parameters for the resistors
.param Rs_val=50
.param Rp_ESD_val=1000
.param Rs_prime_val=500

* DUT Netlist (modified to use parameters and AC source)
V1 VS GND DC 1 AC 1
Rs VS RF_IN Rs_val
Rp_ESD RF_IN GND Rp_ESD_val
Rs_prime RF_IN GND Rs_prime_val

.control
* 1. DC Operating Point for Input Resistance
op
let i_in = -i(V1)
let r_in = v(VS) / i_in
print r_in

* 2. AC Analysis for Signal Attenuation
ac dec 100 1G 10G
let atten_db = vdb(RF_IN)
meas ac attenuation_at_5_5GHz find atten_db at=5.5G

print attenuation_at_5_5GHz
quit
.endc
.end