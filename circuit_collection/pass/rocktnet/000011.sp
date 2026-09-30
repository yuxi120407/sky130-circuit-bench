* Common-Source Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

* DUT
XM1 N4 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

* Supplies and Bias
VVDD VDD 0 1.8
Ibias N2 0 10u
Vshort N3 N2 0

* Self-biasing feedback for high-gain region
Rfb N4 N1 10Meg
Cin in_ac N1 1u
Vac in_ac 0 DC 0 AC 1

* Load
Cload N4 0 1p

.control
* DC Operating Point and Power
op
let power = -i(VVDD) * 1.8
print power
print v(N4)
print v(N1)

* AC Analysis for Gain and Bandwidth
ac dec 100 1 1G
let gain_db = vdb(N4)
let phase = 180/PI * cph(v(N4))

meas ac dc_gain find gain_db at=100
meas ac ugf when gain_db=0 fall=1
meas ac phase_at_ugf find phase when gain_db=0 fall=1

* Transient Analysis
tran 1n 2u

quit
.endc
.end