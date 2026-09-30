* Differential Pair Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

* DUT
XM1 N5 N3 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N4 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Power and Bias
VDD VDD 0 1.8
VCM VCM 0 0.9
ISS N0 0 100u

* Loads
RD1 VDD N5 20k
RD2 VDD N2 20k

* Inputs
VIN_DIFF VIN_DIFF 0 dc 0 ac 1 sin(0 10m 10Meg)
E1 N3 VCM VIN_DIFF 0 0.5
E2 N4 VCM VIN_DIFF 0 -0.5

* Differential Output Extraction
E_diff OUT_DIFF 0 N5 N2 1

.control
* DC Operating Point
op
let power = 1.8 * -i(VDD)
print power

* AC Analysis
ac dec 100 1k 10G
let gain_db = vdb(OUT_DIFF)
meas ac max_gain MAX gain_db
let gain_3db = max_gain - 3
meas ac f3db when gain_db=gain_3db fall=1

* Transient Analysis
tran 1n 200n
meas tran vout_diff_pp pp v(OUT_DIFF)
quit
.endc
.end
