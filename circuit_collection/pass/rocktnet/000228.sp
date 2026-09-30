* LDO Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5

VVDD FULL_VDD 0 dc 1.8 ac 1
VVDD_bulk VDD 0 1.8
VREF N5 0 0.9

Iload VCO_SUPPLY_V 0 dc 5u pulse(2u 10u 1u 0.1u 0.1u 4u 10u)
Cload VCO_SUPPLY_V 0 2p

XM1 VCO_SUPPLY_V N4 FULL_VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N7 N7 FULL_VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N7 VCO_SUPPLY_V N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 N5 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N6 N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N4 N7 FULL_VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 N6 FULL_VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N6 N6 FULL_VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 GND GND N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 GND N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}

.control
* 1. DC Operating Point
op
let VOUT_DC = v(VCO_SUPPLY_V)
let Power_Consumption = -i(VVDD) * 1.8
print VOUT_DC Power_Consumption

* 2. AC Analysis for PSRR
ac dec 10 1 1G
let psrr_db = db(v(VCO_SUPPLY_V))
meas ac PSRR_1kHz find psrr_db at=1k
print PSRR_1kHz

* 3. DC Sweep for Load Regulation
dc Iload 1u 10u 0.5u
meas dc vout_min_load find v(VCO_SUPPLY_V) at=1u
meas dc vout_max_load find v(VCO_SUPPLY_V) at=10u
let Load_Regulation = (vout_min_load - vout_max_load) / 9u
print Load_Regulation

* 4. DC Sweep for Line Regulation
dc VVDD 1.6 2.0 0.01
meas dc vout_1v6 find v(VCO_SUPPLY_V) at=1.6
meas dc vout_2v0 find v(VCO_SUPPLY_V) at=2.0
let Line_Regulation = (vout_2v0 - vout_1v6) / 0.4
print Line_Regulation

* 5. Transient for Load Step
tran 10n 10u
meas tran vout_max max v(VCO_SUPPLY_V) from=1u to=10u
meas tran vout_min min v(VCO_SUPPLY_V) from=1u to=10u
let Transient_Ripple = vout_max - vout_min
print Transient_Ripple

quit
.endc
.end