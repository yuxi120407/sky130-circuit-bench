* Stacked LNA and Mixer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm2=5.0 L_xm2=0.5

XM3 N2 N3 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 VLO N2 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM1 N7 VIN N6 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM5 N5 N2 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM2 N1 VB1 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Connections (Stacking LNA output N1 to Mixer source N2)
Vshort N1 N2 0
Vn6 N6 0 0
Vn0 N0 0 0
Vn5 N5 VDD 0

* IF Load (LC Tank tuned to 800 MHz to filter out RF/LO)
Ltank N4 VDD 10n
Ctank N4 VDD 3.958p
Rtank N4 VDD 5k

* Sources
VVDD VDD 0 1.8
VVB1 VB1 0 1.4
VVB2 N3 0 0.9

* RF Input (2.4 GHz, 10mV amplitude)
VVIN VIN 0 DC 1.0 AC 1 SIN(1.0 0.01 2.4G 0 0)

* LO Input (1.6 GHz, 300mV amplitude)
VVLO VLO 0 DC 1.6 SIN(1.6 0.3 1.6G 0 0)

.control
* DC Operating Point
op
let power_consumption = -i(VVDD) * 1.8
let lna_dc_current = i(Vn6)
print power_consumption lna_dc_current

* Transient Analysis for Conversion Gain
tran 10p 200n
* Measure peak-to-peak of IF output after settling
meas tran vout_max max v(N4) from=150n to=200n
meas tran vout_min min v(N4) from=150n to=200n
let vout_pp = vout_max - vout_min
* Input amplitude is 10mV, so input peak-to-peak is 20mV
let cg_linear = vout_pp / 0.02
let conversion_gain = 20 * log10(cg_linear)
print conversion_gain

* Noise Analysis
noise v(N4) VVIN lin 1 800meg 800meg
let noise_figure = 10 * log10(1 + inoise_spectrum[0] / 8.00776e-21)
print noise_figure
quit
.endc
.end