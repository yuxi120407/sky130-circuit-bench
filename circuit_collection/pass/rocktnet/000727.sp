* PMOS Stack Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

XM1 N4 INPUT OUTPUT VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUTPUT INPUT N8 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}

* Supply and Bias Sources
VVDD VDD 0 1.8
VN8 N8 0 1.8
VN4 N4 0 0
VINPUT INPUT 0 DC 0.9 AC 1 SIN(0.9 0.1 1MEG 0 0)

* Load to prevent floating nodes if both PMOS turn off
Rload OUTPUT 0 1MEG

.control
* 1. DC Operating Point & Power
op
let vout_dc = v(OUTPUT)
let power_dc = -i(VVDD) * 1.8 - i(VN8) * 1.8
print vout_dc
print power_dc

* 2. AC Analysis
ac dec 10 1k 100MEG
let gain_db = vdb(OUTPUT)
meas ac gain_1mhz find gain_db at=1MEG

* 3. Transient Analysis
tran 10n 5u
meas tran vout_max max v(OUTPUT)
meas tran vout_min min v(OUTPUT)
let vout_pp = vout_max - vout_min
print vout_pp

quit
.endc
.end