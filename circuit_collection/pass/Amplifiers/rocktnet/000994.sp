* Testbench for Differential Amplifier with Offset Cancellation
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

* DUT
XM1 VOUTn VINp TAIL GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VOUTp VINn TAIL GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VOUTn VOFFSETp TAIL GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VOUTp VOFFSETn TAIL GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Power supply and load resistors
VVDD VDD 0 1.8
RL1 VDD VOUTn 1k
RL2 VDD VOUTp 1k

* Tail current source
ITAIL TAIL 0 1m

* Inputs for AC and OP
* AC magnitude is set to 0.5 and -0.5 to provide a 1V differential AC input
VVINp VINp 0 DC 0.9 AC 0.5
VVINn VINn 0 DC 0.9 AC -0.5
VVOFFSETp VOFFSETp 0 DC 0.9
VVOFFSETn VOFFSETn 0 DC 0.9

.control
* 1. Operating Point & Power
op
let power = -i(VVDD) * 1.8
print power

* 2. AC Analysis for Gain and Bandwidth
ac dec 100 1Meg 100G
let vout_diff = v(VOUTn) - v(VOUTp)
let gain_mag = mag(vout_diff)
let gain_db = 20*log10(gain_mag)
meas ac dc_gain find gain_db at=1Meg
let gain_3db = dc_gain - 3
meas ac bw_3db when gain_db=gain_3db fall=1
print dc_gain bw_3db

* 3. DC Analysis for Offset Tuning Range
dc VVOFFSETp 0.0 1.8 0.01
let vout_diff_dc = v(VOUTn) - v(VOUTp)
meas dc max_offset max vout_diff_dc
meas dc min_offset min vout_diff_dc
let offset_range = max_offset - min_offset
print offset_range

quit
.endc
.end