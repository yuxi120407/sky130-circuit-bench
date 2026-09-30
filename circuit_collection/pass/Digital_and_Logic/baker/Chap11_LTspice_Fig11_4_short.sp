* CMOS Inverter Characterization Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Parameter definitions for DUT sizing
.param W_xm1=1.0
.param L_xm1=0.15
.param W_xm2=2.0
.param L_xm2=0.15

* Circuit DUT
xm1 Vout Vin 0 0 sky130_fd_pr__nfet_01v8 w={W_xm1} l={L_xm1}
Vin Vin 0 0
VDD VDD 0 1.8
xm2 Vout Vin VDD VDD sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}

.control
* Run DC sweep of input voltage from 0 to 1.8V
dc Vin 0 1.8 0.001

* Measure output rails
meas dc voh max v(Vout)
meas dc vol min v(Vout)

* Measure switching point voltage VSP (where Vout = Vin)
meas dc vsp when v(Vout)=v(Vin)

* Measure peak crossing current through VDD supply
let iddd = -i(VDD)
meas dc icross_peak max iddd

* Calculate transfer derivative to determine unity-gain inflection points (VIL and VIH)
let gain = deriv(v(Vout))
meas dc vil when gain=-1 fall=1
meas dc vih when gain=-1 rise=1

* Compute noise margins
let nmh = voh - vih
let nml = vil - vol

print voh vol vsp icross_peak vil vih nmh nml
quit
.endc
.end