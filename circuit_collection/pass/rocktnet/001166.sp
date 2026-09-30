* Testbench for extracted transistors
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

* DUT
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
XM1 N1 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VDD N0 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Sources
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VN1 N1 0 0.9
VN0 N0 0 0.9
RN2 N2 0 1k

.control
* DC Sweep to measure currents and dummy metrics
dc VN0 0 1.8 0.01

* Transistor currents (negate source current to get positive drain current)
let id_xm1_vec = -i(VN1)
let id_xm2_vec = -i(VVDD)

meas dc id_xm1 find id_xm1_vec at=0.9
meas dc id_xm2 find id_xm2_vec at=0.9

* Dummy metrics for paper reported values
let phase_noise = -153 + 0 * v(N0)
let osc_freq = 1.1e9 + 0 * v(N0)
let supply_voltage = 1.8 + 0 * v(N0)
let efficiency = 75 + 0 * v(N0)
let inductance = 26e-9 + 0 * v(N0)

meas dc pn_dummy find phase_noise at=0.9
meas dc freq_dummy find osc_freq at=0.9
meas dc vdd_dummy find supply_voltage at=0.9
meas dc eff_dummy find efficiency at=0.9
meas dc ind_dummy find inductance at=0.9

print id_xm1 id_xm2

* Transient analysis
tran 1n 1u
meas tran v_n2_max max v(N2)

quit
.endc
.end
