* Transmission Gate Delay Measurement
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

VDD vdd 0 1.8

Vin vin 0 PULSE(0 1.8 1n 10p 10p 2n 4n)

XM1 vout vdd vin 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
XM2 vout 0 vin vdd sky130_fd_pr__pfet_01v8 w=5.0 l=0.15

Cload vout 0 50f

.tran 1p 5n

.control
run
meas tran tplh TRIG v(vin) VAL=0.9 RISE=1 TARG v(vout) VAL=0.9 RISE=1
meas tran tphl TRIG v(vin) VAL=0.9 FALL=1 TARG v(vout) VAL=0.9 FALL=1
let propagation_delay = (tplh + tphl) / 2
print propagation_delay
.endc

.end