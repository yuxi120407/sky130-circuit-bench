* 900-MHz LNA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param Cp=1.2p
.param W_m1=90.0
.param L_m1=0.15

* DUT (Resistor values appended and missing NMOS added)
L1 N2 GND 2nH
L2 In N0 22nH
L3 VDD OUT 8.7nH
R1 VDD OUT 1k
R2 VDD OUT 1k
R3 VDD OUT 1k
C1 In GND 2pF
C2 N0 GND Cp
XM1 OUT N0 N2 GND sky130_fd_pr__nfet_01v8 W={W_m1} L={L_m1}
Cout OUT GND 3.5p

* Sources
VVDD VDD GND 1.8
VIN In GND DC 0.7 AC 1 SIN(0.7 0.01 900MEG 0 0)

.control
* DC Operating Point
op
let id_m1 = -i(VVDD)
let power = id_m1 * 1.8
print id_m1 power

* AC Analysis
ac dec 100 100MEG 10G
let gain_db = vdb(OUT)
let zin_mag = mag(v(In)/(-i(VIN)))

meas ac max_gain MAX gain_db
meas ac peak_freq MAX_AT gain_db
meas ac gain_900mhz find gain_db at=900MEG
meas ac zin_900mhz find zin_mag at=900MEG

* Transient Analysis
tran 10p 10n
meas tran vout_pp pp v(OUT)

quit
.endc
.end