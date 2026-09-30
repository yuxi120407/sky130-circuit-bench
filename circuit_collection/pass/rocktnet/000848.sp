* Testbench for NMOS Switch
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

.param W_xm1=5.0 L_xm1=0.5

* DUT
XM1 N1 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* Stimulus
VGS N0 GND 0
VDS N1_drain GND 1.8
VD_meas N1_drain N1 0

.control
* 1. DC Sweep VGS for Vth and I_off
dc VGS 0 1.8 0.01
meas dc i_off find i(VD_meas) at=0
* Vth measured at Id = 1uA * (W/L) = 10uA
meas dc vth find v(N0) when i(VD_meas)=10u

* 2. DC Sweep VDS for R_on
alter VGS 1.8
dc VDS 0 0.2 0.01
meas dc id_at_100mv find i(VD_meas) at=0.1
let r_on = 0.1 / id_at_100mv
print r_on

quit
.endc
.end
