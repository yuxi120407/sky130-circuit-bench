* Pseudo-differential baseband amplifier testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm3=5.0 L_xm3=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm4=5.0 L_xm4=0.5

XM3 VOUTn VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM1 VOUTp VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 VINp GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM4 N0 VINn GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Connect NMOS drains to PMOS drains
Vshort1 VOUTn N3 0
Vshort2 VOUTp N0 0

* Power and Bias
VVDD VDD 0 1.8
VVB1 VB1 0 0.6

* Self-biasing feedback to set optimal DC operating point
Rfb1 VOUTn VINp 100Meg
Rfb2 VOUTp VINn 100Meg

* AC coupling and inputs
Cinp VINp_ac VINp 10u
Cinn VINn_ac VINn 10u
VVINp_ac VINp_ac 0 DC 0 AC 1
VVINn_ac VINn_ac 0 DC 0 AC -1

* Load capacitance (1pF sets bandwidth to ~1.2MHz)
C1 VOUTp 0 1p
C2 VOUTn 0 1p

.control
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

ac dec 100 10 100MEG
let vout_diff = v(VOUTp) - v(VOUTn)
let gain_mag = mag(vout_diff) / 2
let gain_db = 20 * log10(gain_mag)
meas ac voltage_gain MAX gain_db
let gain_db_3db = voltage_gain - 3
meas ac bandwidth when gain_db=gain_db_3db fall=1

print voltage_gain
print bandwidth
quit
.endc
.end