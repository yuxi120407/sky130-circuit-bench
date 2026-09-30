* Design of a Low-Noise Preamplifier for Nerve Cuff Electrode Recording
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm3=5.0 L_xm3=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm1=5.0 L_xm1=0.5

* DUT (Note: GND on XM2 and XM4 drains corrected to OUT)
XM3 N0 N0 VSS GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM2 OUT VIN_MINUS N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM4 OUT N0 VSS GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM1 N0 VIN_PLUS N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}

* Tail current source
Itail VDD N1 500u

* Load capacitor
CL OUT 0 1p

* Supplies and Bias
VVDD VDD 0 1.8
VVSS VSS 0 0
VCM VIN_PLUS 0 0.9

* DC feedback for open-loop AC analysis
* Lfb shorts OUT to VIN_MINUS at DC, opens at AC
* Cac couples AC input to VIN_MINUS, opens at DC
Lfb OUT VIN_MINUS 1MEG
Cac VIN_AC VIN_MINUS 1
Vac VIN_AC 0 DC 0.9 AC 1 SIN(0.9 1m 100k 0 0)

.control
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

ac dec 100 1 1G
let out_ac = -v(OUT)
let gain_db = db(out_ac)
let phase_deg = 180/PI * ph(out_ac)
meas ac dc_gain find gain_db at=1
meas ac ugbw when gain_db=0 fall=1
meas ac phase_at_ugbw find phase_deg when gain_db=0 fall=1
let phase_margin = phase_at_ugbw + 180
print dc_gain ugbw phase_margin

noise v(OUT) Vac dec 100 1 10k
setplot noise1
meas ac input_noise_1kHz find inoise_spectrum at=1k
print input_noise_1kHz

setplot noise2
let total_input_noise = sqrt(inoise_total)
print total_input_noise

quit
.endc
.end