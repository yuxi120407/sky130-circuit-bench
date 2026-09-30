* Switched-Capacitor DC-DC Converter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param VDD=1.8
.param FSW=8.2Meg
.param TPER={1/FSW}
.param THALF={TPER/2 - 1n}

* Supply and Clocks
VVIN VIN 0 DC {VDD}
Vphi1 phi1 0 PULSE(0 {VDD} 0 1n 1n THALF TPER)
Vphi2 phi2 0 PULSE(0 {VDD} {TPER/2} 1n 1n THALF TPER)

* Ground reference for N0
R_N0 N0 0 1m

* Load
Rload VOUT 0 100

* --- DUT ---
S1 VOUT VIN phi1 0 switch_ideal
S2 VIN VIN phi2 0 switch_ideal
S3 N2 VIN phi1 0 switch_ideal
S4 N0 VOUT phi2 0 switch_ideal
C2 N0 VOUT 10n
C1 N2 VIN 1n
S5 N0 N0 phi1 0 switch_ideal
S6 VOUT N2 phi2 0 switch_ideal

.model switch_ideal SW(Ron=1 Roff=1Meg Vt=0.9)

* Analysis
.tran 1n 5u

.control
run

* Measure output voltage and ripple
meas tran output_voltage avg v(VOUT) from=3u to=5u
meas tran vout_max max v(VOUT) from=3u to=5u
meas tran vout_min min v(VOUT) from=3u to=5u
let output_ripple = vout_max - vout_min

* Measure efficiency
meas tran pin_avg avg i(VVIN) from=3u to=5u
let pin = -pin_avg * 1.8
let pout = (output_voltage * output_voltage) / 100
let efficiency = (pout / pin) * 100

print output_voltage output_ripple efficiency

quit
.endc
.end