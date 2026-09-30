* CMOS Voltage Reference Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Parameterized W/L
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm5=5.0 L_xm5=0.5

* DUT
XM1 VDD N0 N0 N0 sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 V1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VDD V2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM5 VDD N0 V1 V1 sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}

* Sources
VVDD VDD 0 1.8
VV2 V2 0 0

.control
op
let Vref = v(V1)
let Power = -i(VVDD) * 1.8
print Vref Power

dc temp -40 125 1
meas dc vref_max max v(V1)
meas dc vref_min min v(V1)
let TC = (vref_max - vref_min) / 165.0
print TC

dc VVDD 1.0 2.0 0.1
meas dc vref_vdd_max max v(V1)
meas dc vref_vdd_min min v(V1)
let Line_Regulation = (vref_vdd_max - vref_vdd_min) / 1.0
print Line_Regulation
.endc
.end