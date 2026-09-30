* Differential Delay Cell Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

.param W_xm4=5.0 L_xm4=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm5=5.0 L_xm5=0.5

XM4 VOUT_MINUS RBIAS N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM1 VOUT_MINUS VIN_PLUS N3 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VOUT_PLUS VIN_MINUS N3 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM5 VOUT_PLUS RBIAS N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}

* Supply and Bias
VVDD VDD 0 1.8
VN4 N4 VDD 0
VVBIAS VBIAS 0 0.9
B_CMFB RBIAS 0 V=1.0+(V(VOUT_PLUS)+V(VOUT_MINUS)-2.4)*5

* Differential Inputs
VVIN_PLUS VIN_PLUS 0 DC 1.2 AC 0.5
VVIN_MINUS VIN_MINUS 0 DC 1.2 AC -0.5

* Load Capacitance
CL1 VOUT_PLUS 0 10f
CL2 VOUT_MINUS 0 10f

.control
* DC Analysis for Power
dc VVDD 1.8 1.8 1
let power = -i(VVDD) * 1.8
meas dc dc_power MAX power
print dc_power

* AC Analysis for Gain and Bandwidth
ac dec 20 1k 100G
let vout_diff = v(VOUT_PLUS) - v(VOUT_MINUS)
let gain_db = 20 * log10(mag(vout_diff))
meas ac voltage_gain MAX gain_db
meas ac bandwidth when gain_db="voltage_gain - 3" fall=1
print voltage_gain bandwidth

* Noise Analysis for Phase Noise
noise v(VOUT_PLUS, VOUT_MINUS) VVIN_PLUS dec 10 1k 10G
setplot noise1
let phase_noise_vec = 20 * log10(onoise_spectrum)
meas noise phase_noise find phase_noise_vec at=1MEG
print phase_noise

quit
.endc
.end