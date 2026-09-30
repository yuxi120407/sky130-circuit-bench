* Switched Capacitor Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param Cval=1p
.model switch_ideal sw vt=0.9 vh=0.1 ron=100 roff=1G

* DUT (Corrected for ngspice switch syntax: added control nodes phi1/phi2 and removed parentheses)
S1 N0 GND phi2 GND switch_ideal
S2 N6 GND phi2 GND switch_ideal
S3 VOUT N5 phi2 GND switch_ideal
S4 VOUT GND phi1 GND switch_ideal
CP VOUT GND {Cval}
C2A N2 N5 {Cval}
S5 N2 GND phi2 GND switch_ideal
S6 N1 GND phi1 GND switch_ideal
S7 N5 GND phi1 GND switch_ideal
S8 N1 VOUT phi2 GND switch_ideal
C1 VOUT N6 {Cval}
S9 N0 VIN phi1 GND switch_ideal
C2B N0 N1 {Cval}
S10 VIN N6 phi1 GND switch_ideal
S11 N2 VIN phi1 GND switch_ideal

* Sources
VVIN VIN GND DC 0.9
Vphi1 phi1 GND PULSE(0 1.8 0 1n 1n 50n 125n)
Vphi2 phi2 GND PULSE(0 1.8 62.5n 1n 1n 50n 125n)

* Analysis
.control
tran 1n 500n

* Measure gain during the second transfer phase (phi2 is high)
meas tran vout_settled find v(VOUT) at=225n
meas tran vin_val find v(VIN) at=225n
let voltage_gain = vout_settled / vin_val
print voltage_gain

* Measure dynamic power from the input source
meas tran pwr_vin integ i(VVIN) from=0 to=500n
let dynamic_power = -pwr_vin * 0.9 / 500n
print dynamic_power

* Measure settling time
meas tran vout_settled1 find v(VOUT) at=110n
let vout_target = vout_settled1 * 0.95
meas tran t1 WHEN v(VOUT)=$&vout_target CROSS=1
let settling_time = t1 - 62.5n
print settling_time

quit
.endc
.end