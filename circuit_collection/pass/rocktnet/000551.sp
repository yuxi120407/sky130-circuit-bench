* Frequency Divider Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

* Redefine W/L for high-frequency operation in 130nm
.param W_xm1=20.0 L_xm1=0.15
.param W_xm3=20.0 L_xm3=0.15
.param W_xm2=20.0 L_xm2=0.15

* DUT
XM1 N0 N1 P GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM3 P VIN GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM2 N1 N0 P GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Sources
VVDD VDD 0 1.8
* Inject 20 GHz signal at the tail
VVIN VIN 0 DC 1.0 SIN(1.0 0.5 20G)

* LC Tank tuned to ~10 GHz
L1 VDD N0 1n
L2 VDD N1 1n
C1 N0 N1 0.1p
R1 N0 VDD 1k
R2 N1 VDD 1k

* Initial condition to break symmetry and start oscillation
IKICK 0 N0 PULSE(0 1m 10p 1p 1p 10p 100n)

.control
tran 1p 10n

* Measure output frequency
meas tran t1 trig v(N0) val=1.8 rise=30 targ v(N0) val=1.8 rise=31
let output_frequency = 1/t1
print output_frequency

* Measure power consumption
meas tran avg_I avg i(VVDD) from=5n to=10n
let power_consumption = -avg_I * 1.8
print power_consumption

* Calculate division ratio
let division_ratio = 20e9 / output_frequency
print division_ratio

quit
.endc
.end