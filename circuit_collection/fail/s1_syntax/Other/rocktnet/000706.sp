* High-Frequency LC VCO Equivalent Model Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param Rval=10k
.param Cval=126f Rval=1k Rser=10 Ival=1m

* DUT (with values appended for SPICE compatibility)
I1 vin_minus 0 Ival
I2 vin_plus 0 Ival
C1 VPI2 0 {Cval}
R1 VPI2 0 {Rval}
C2 VPI1 0 {Cval}
R2 VPI1 0 {Rval}
R3 vin_plus VPI2 Rser
R4 vin_minus VPI1 Rser

* Sources
VVIN_MINUS vin_minus 0 DC 0.9 AC -1 SIN(0.9 0.1 20G 0 0)
VVIN_PLUS vin_plus 0 DC 0.9 AC 1 SIN(0.9 0.1 20G 0 0)

.control
* AC Analysis for Impedance
ac dec 100 1G 100G
let I_in = -i(VVIN_PLUS)
let V_in = v(vin_plus)
let Y_in = I_in / V_in
let G_in = real(Y_in)
let B_in = imag(Y_in)
let R_p = 1 / G_in
let C_p = B_in / (2 * pi * frequency)

meas ac Cp_20GHz find C_p at=20G
meas ac Rp_20GHz find R_p at=20G

* Transient Analysis
tran 1p 200p
meas tran v_max max v(vin_plus)
meas tran v_min min v(vin_plus)

print Cp_20GHz Rp_20GHz
quit
.endc
.end
