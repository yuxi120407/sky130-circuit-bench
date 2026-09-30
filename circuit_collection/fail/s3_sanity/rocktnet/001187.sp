* Cascode Differential Amplifier Testbench
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5

* DUT
XM1 N3 N10 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N11 N6 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N5 INN N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 BIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N4 INP N0 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 N9 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N8 N9 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}

* Biasing and Supplies
VVDD VDD 0 1.8
VBIAS BIAS 0 0.65
VCASC N9 0 1.3

* RF Inputs (DC biased to keep tail in saturation)
VINP INP 0 DC 0.9 AC 0.5 SIN(0.9 0.1 2.4G 0 0 0)
VINN INN 0 DC 0.9 AC -0.5 SIN(0.9 0.1 2.4G 0 0 180)

* Loads for Cascode Stage
R1 VDD N2 10k
R2 VDD N8 10k

* Biasing and Loads for Secondary Pair
I2 N7 0 100u
V10 N10 0 1.2
V6 N6 0 1.2
R3 VDD N3 10k
R4 VDD N11 10k

* Differential Output Extraction
E1 out_diff 0 N8 N2 1.0

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.control
set reltol=1e-5

* DC Operating Point
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

* AC Analysis for Gain and Bandwidth
ac dec 100 1M 100G
let gain_db = db(v(out_diff))
meas ac voltage_gain max gain_db
let gain_3db = $&voltage_gain - 3
meas ac bandwidth when gain_db=gain_3db fall=1
print voltage_gain
print bandwidth

* Noise Analysis
noise v(out_diff) VINP dec 10 1M 100M
setplot noise1
meas noise onoise_3m find onoise_spectrum at=3Meg
let phase_noise = 10 * log10($&onoise_3m)
print phase_noise

* Transient Analysis for IIP3
tran 10p 100n
linearize v(out_diff)
set specwindow=rectangular
fft v(out_diff)
let vout_mag = mag(v(out_diff))
meas ac v1_mag max vout_mag from=2.39G to=2.41G
meas ac v3_mag max vout_mag from=7.19G to=7.21G
let iip3 = -4 + (20*log10($&v1_mag) - 20*log10($&v3_mag) - 9.54)/2
print iip3

quit
.endc
.end