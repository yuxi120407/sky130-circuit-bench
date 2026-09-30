* Dual Current Source Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

XM1 N7 VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

VVDD VDD 0 1.8
VVBIAS VBIAS 0 0.54

* Connect drains to VDD to keep in saturation. V1 has AC=1 for Rout measurement.
V1 N7 0 DC 1.8 AC 1
V2 N3 0 DC 1.8

.control
op
let id1 = -i(V1)
let id2 = -i(V2)
let total_power = (id1 + id2) * 1.8
print id1 id2 total_power

ac dec 10 1 1G
let rout1 = 1 / mag(i(V1))
meas ac rout_val find rout1 at=1k

quit
.endc
.end
