* Limiting Driver Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.15
.param L_xm2=0.15
.param L_xm3=0.15
.param L_xm4=5.0

.param W_xm1=40.0
.param W_xm2=40.0
.param W_xm3=80.0
.param W_xm4=0.42

XM1 OUTP DINN N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUTN DINP N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 VOA VSS GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUTN OUTN OUTP GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

VVDD VDD 0 1.8
VVSS VSS 0 0
VVOA VOA 0 1.0

* 50-ohm loads as described in the paper
R_OUTP VDD OUTP 50
R_OUTN VDD OUTN 50

* Differential Inputs (1 GHz sine wave for transient)
V_DINP DINP 0 dc 1.2 ac 0.5 sin(1.2 0.2 1G 0 0 0)
V_DINN DINN 0 dc 1.2 ac 0.5 180 sin(1.2 0.2 1G 0 0 180)

.control
* 1. DC Operating Point & Power
op
let power_consumption = -i(VVDD)*1.8
print power_consumption

* 2. AC Analysis for Gain and Bandwidth
ac dec 10 1M 100G
let out_diff = v(OUTP) - v(OUTN)
let gain_db = db(out_diff)
meas ac voltage_gain find gain_db at=1MEG
let gain_3db = voltage_gain - 3
meas ac bandwidth when gain_db=gain_3db fall=1

* 3. Transient Analysis for Output Swing
tran 1p 5n
let vout_diff = v(OUTP) - v(OUTN)
meas tran vout_diff_max max vout_diff from=2n to=5n
meas tran vout_diff_min min vout_diff from=2n to=5n
let output_swing = vout_diff_max - vout_diff_min
print output_swing

quit
.endc
.end