* Testbench for PMOS Current Mirror
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

XM2 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 OUT N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}

VVDD VDD 0 DC 1.8
VOUT OUT 0 DC 0
VIREF N0 N0_src DC 0
IREF N0_src 0 DC 10u AC 1u

.control
* DC Analysis
op
let i_in = i(VIREF)
let i_out = i(VOUT)
let mirror_ratio = i_out / i_in
let power_consumption = -i(VVDD) * 1.8
print mirror_ratio
print power_consumption

* AC Analysis
ac dec 100 1 100G
let current_gain_mag = mag(i(VOUT)) / mag(i(VIREF))
let current_gain_db = 20 * log10(current_gain_mag)
meas ac max_gain MAX current_gain_db
meas ac bandwidth when current_gain_db='max_gain - 3' fall=1
print bandwidth

quit
.endc
.end