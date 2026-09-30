* Differential Source Follower Testbench
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 VOUTP N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VDD N0 VOUTN GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VDD N6 VOUTP GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VOUTN N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

VVDD VDD 0 1.8
* Bias for current sinks
VB1 N4 0 0.7
VB2 N5 0 0.7

* Differential inputs (N6=VINP, N0=VINN)
VCM VCM 0 1.2
VINP N6 VCM DC 0 AC 0.5 SIN(0 0.1 10MEG 0 0)
VINN N0 VCM DC 0 AC -0.5 SIN(0 -0.1 10MEG 0 0)

* Dependent sources to calculate differential signals
E_OUT VOUT_DIFF 0 VOUTP VOUTN 1.0
E_IN VIN_DIFF 0 N6 N0 1.0

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.control
* DC Operating Point
op
let power = -i(VVDD) * 1.8
print power
print v(VOUTP) v(VOUTN)

* AC Analysis for Gain and Bandwidth
ac dec 20 1MEG 10G
* Since VIN_DIFF AC magnitude is 1.0, vdb(VOUT_DIFF) is the gain in dB
let gain_db = vdb(VOUT_DIFF)
meas ac midband_gain_db find gain_db at=10MEG
let gain_db_3db = midband_gain_db - 3
meas ac bw_3db when gain_db = gain_db_3db fall=1

* Transient Analysis for large-signal swing
tran 1n 500n
meas tran vout_diff_pp pp v(VOUT_DIFF)
* Input differential peak-to-peak is 0.4V (0.2V amplitude)
let gain_tran = vout_diff_pp / 0.4
print gain_tran

quit
.endc
.end
