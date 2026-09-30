* Testbench for NMOS Differential Pair
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xmp=10.0 L_xmp=0.15
.param W_xmn=10.0 L_xmn=0.15

* DUT
XMP VOUTN VINP N0 GND sky130_fd_pr__nfet_01v8 l={L_xmp} w={W_xmp}
XMN VOUTP VINN N0 GND sky130_fd_pr__nfet_01v8 l={L_xmn} w={W_xmn}

* Biasing and Loads
VVDD VDD 0 1.8
R1 VDD VOUTN 10k
R2 VDD VOUTP 10k
C1 VOUTN 0 50f
C2 VOUTP 0 50f
I1 N0 0 100u

* Inputs
VVINP VINP 0 DC 0.9 AC 0.5 SIN(0.9 0.01 100MEG 0 0)
VVINN VINN 0 DC 0.9 AC -0.5 SIN(0.9 -0.01 100MEG 0 0)

* Differential to Single-Ended Converters for Measurement
E_OUT VOUT_DIFF 0 VOUTP VOUTN 1
E_IN VIN_DIFF 0 VINP VINN 1

.control
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

ac dec 100 1MEG 100G
let gain_db = db(v(VOUT_DIFF))
meas ac voltage_gain find gain_db at=1MEG
meas ac unity_gain_frequency when gain_db=0 fall=1

tran 10p 20n
meas tran vout_diff_max MAX v(VOUT_DIFF) from=10n to=20n
meas tran vout_diff_min MIN v(VOUT_DIFF) from=10n to=20n
let output_swing = vout_diff_max - vout_diff_min
print output_swing

quit
.endc
.end