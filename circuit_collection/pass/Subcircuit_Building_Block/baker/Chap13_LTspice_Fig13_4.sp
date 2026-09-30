* Transmission Gate Discharge Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=10 L_xm1=1
.param W_xm2=20 L_xm2=1

* DUT
xm1 0 S Vout 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
C1 Vout 0 5e-14
VDD VDD 0 1.8
xm2 Vout S_bar 0 VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}

* Stimulus to turn ON the TG
Vs S 0 1.8
Vs_bar S_bar 0 0

* Initial condition: Capacitor charged to VDD
.ic v(vout)=1.8

.control
* Run transient analysis
tran 1p 200p

* Measure propagation delay (time to reach VDD/2)
meas tran tphl find time when v(vout)=0.9 fall=1

* Estimate effective resistance based on the dominant first term of Eq 13.2
let req_approx = tphl / (0.7 * 5e-14)

print tphl req_approx
quit
.endc
.end