* CMOS Temperature Sensor Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param I_bias=1u C_S=120f k=5

* DUT (Modified syntax for ngspice compatibility)
I1 VDD VIN_POS {2*I_bias}
I2 VDD VIN_NEG {10*I_bias}
QL GND GND VIN_POS pnp
QR GND GND VIN_NEG pnp
C3 VIN_POS VINT_POS {C_S}
C2 VIN_POS IN_POS {k*C_S}
C1 VIN_NEG IN_NEG {k*C_S}
C4 GND VINT_NEG {C_S}
X1 IN_POS IN_NEG VINT_POS VINT_NEG amplifier

* Models and Subcircuits
.model pnp pnp (is=1e-16 bf=10)

.subckt amplifier in_pos in_neg out_pos out_neg
E1 out_diff 0 in_pos in_neg 6300
E2 out_pos 0 vol='0.9 + v(out_diff)/2'
E3 out_neg 0 vol='0.9 - v(out_diff)/2'
R1 in_pos 0 1G
R2 in_neg 0 1G
.ends

* Sources
VVDD VDD 0 1.8
Iac_pos 0 VIN_POS AC 1
Iac_neg 0 VIN_NEG AC -1

.control
* 1. DC Operating Point
op
let power = -i(VVDD) * 1.8
print power
let vbe_pos = v(VIN_POS)
let vbe_neg = v(VIN_NEG)
let delta_vbe = vbe_neg - vbe_pos
print vbe_pos vbe_neg delta_vbe

* 2. DC Sweep over Temperature
dc temp -55 125 5
let delta_vbe_t = v(VIN_NEG) - v(VIN_POS)
meas dc dvbe_25 find delta_vbe_t at=25
meas dc dvbe_125 find delta_vbe_t at=125
meas dc dvbe_m55 find delta_vbe_t at=-55
let ptat_slope = (dvbe_125 - dvbe_m55) / 180
print ptat_slope

* 3. AC Analysis
ac dec 10 1 1G
let v_in_diff = v(IN_POS) - v(IN_NEG)
let v_out_diff = v(VINT_POS) - v(VINT_NEG)
let gain_mag = mag(v_out_diff) / mag(v_in_diff)
let gain_db = 20 * log10(gain_mag)
meas ac midband_gain find gain_db at=1k

quit
.endc
.end
