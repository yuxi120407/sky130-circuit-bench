* Q-Enhanced LC Bandpass Filter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

* DUT
.param W_xm7=5.0 L_xm7=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm6=5.0 L_xm6=0.5

XM7 VOUT_PLUS N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM5 VOUT_MINUS VOUT_PLUS VOUT_PLUS VOUT_PLUS sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM2 VOUT_PLUS VIN_MINUS N6 N6 sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM1 VOUT_MINUS VIN_PLUS N2 N2 sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM4 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM3 N3 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM8 N4 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM6 VOUT_PLUS VOUT_MINUS VOUT_PLUS VOUT_PLUS sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

* Fix floating nodes (connect diff pair sources to tail current drain)
Vshort1 N2 N3 0
Vshort2 N6 N3 0

* Biasing and Supplies
VVDD VDD 0 1.8
VVIN_PLUS VIN_PLUS 0 DC 0.9 AC 0.5
VVIN_MINUS VIN_MINUS 0 DC 0.9 AC -0.5
VN0 N0 0 0.9
VN4 N4 0 0.9

* LC Tank (Tuned to ~2.1 GHz)
L1 VDD VOUT_PLUS 3.7n
L2 VDD VOUT_MINUS 3.7n
C1 VOUT_PLUS 0 1.55p
C2 VOUT_MINUS 0 1.55p
R1 VOUT_PLUS VDD 10k
R2 VOUT_MINUS VDD 10k

* Differential Output
E_diff VOUT_DIFF 0 VOUT_PLUS VOUT_MINUS 1

.control
op
let power = -i(VVDD) * 1.8
print power

ac dec 100 100MEG 10G
meas ac peak_gain MAX vdb(VOUT_DIFF)
meas ac peak_freq MAX_AT vdb(VOUT_DIFF)
quit
.endc
.end
