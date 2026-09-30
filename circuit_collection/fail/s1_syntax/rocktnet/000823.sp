* Frequency Doubler Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_val=0.0011
.param C_val=1p
.param R_val=1k

* Connect GND to 0
VGND GND 0 DC 0

* Original Netlist
Cd3 Vg2 GND {C_val}
C1 N0 GND {C_val}
L4 N1 VDD {L_val}
Cd4 VDD GND {C_val}
L1 N2 IN {L_val}
Rg N2 Vg1 {R_val}
C2 N5 N7 {C_val}
Cd1 Vg1 GND {C_val}
L3 N5 Vg2 {L_val}
Rs2 N0 GND {R_val}
L2 N0 N7 {L_val}
C3 N1 OUT {C_val}

* Added Transistors (DUT core, missing from extraction)
XM1 N7 N2 GND GND sky130_fd_pr__nfet_01v8 W=50.0 L=0.15
XM2 N1 N5 N0 GND sky130_fd_pr__nfet_01v8 W=50.0 L=0.15

* Sources and Biasing
VVDD VDD 0 DC 1.8
VVg1 Vg1 0 DC 0.7
VVg2 Vg2 0 DC 1.6

* Input Signal (2.5 GHz, 1V peak-to-peak -> 0.5V peak)
VIN IN_AC 0 DC 0 SIN(0 0.5 2.5G 0 0)
Cin IN_AC IN 10p

* Output Load
Rout OUT 0 50

.control
* DC Analysis
op
let p_dc = -i(VVDD) * 1.8
print p_dc

* Transient Analysis
tran 1p 10n
* Measure output frequency
meas tran t1 trig v(OUT) val=0 rise=10 targ v(OUT) val=0 rise=11
let freq_out = 1/t1
print freq_out

* Measure output power and conversion gain
meas tran vout_max max v(OUT) from=5n to=10n
meas tran vout_min min v(OUT) from=5n to=10n
let vout_pp = vout_max - vout_min
let p_out_w = (vout_pp/2)*(vout_pp/2) / 100
let p_out_dbm = 10 * log10(p_out_w * 1000 + 1e-20)
print p_out_dbm

let vin_pp = 1.0
let p_in_w = (vin_pp/2)*(vin_pp/2) / 100
let p_in_dbm = 10 * log10(p_in_w * 1000)
let conversion_gain = p_out_dbm - p_in_dbm
print conversion_gain

quit
.endc
.end
