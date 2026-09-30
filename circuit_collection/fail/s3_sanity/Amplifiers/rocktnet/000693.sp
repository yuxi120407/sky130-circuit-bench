* UWB LNA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Parameterized sizing for RF performance (~5mA total current)
.param W_xm1=50.0 L_xm1=0.15
.param W_xm2=50.0 L_xm2=0.15
.param W_xm3=20.0 L_xm3=0.15

* DUT (Extracted from paper)
XM2 V_OUT V_CAS N4 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VDD V_OUT V_OUT_PRIME GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM1 N4 N8 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* Biasing and Passives
VVDD VDD 0 1.8
V_CAS V_CAS 0 1.2
V_BIAS N8_bias 0 0.6
R_bias N8_bias N8 10k
C_in IN N8 10p
V_IN IN 0 dc 0 ac 1 sin(0 0.03162277 2.4G)
L_deg N3 0 0.5n
R_load VDD V_OUT 300
R_out V_OUT_PRIME 0 500

.control
* 1. DC Operating Point for Power Consumption
op
let power_consumption = -i(VVDD) * 1.8
print power_consumption

* 2. AC Analysis for Gain and Bandwidth
ac dec 50 100k 100G
meas ac voltage_gain MAX vdb(V_OUT_PRIME)
meas ac f_low when vdb(V_OUT_PRIME)='voltage_gain - 3' rise=1
meas ac f_high when vdb(V_OUT_PRIME)='voltage_gain - 3' fall=last
let bandwidth = f_high - f_low
print voltage_gain bandwidth

* 3. Noise Figure
noise v(V_OUT_PRIME) V_IN dec 50 100k 100G
setplot noise1
meas noise inoise_2G4 find inoise_spectrum at=2.4G
let noise_figure = 10 * log10( (inoise_2G4 * inoise_2G4) / 8.28e-19 )
print noise_figure

* 4. IIP3 (Transient Analysis)
tran 2p 50n 10n
linearize v(V_OUT_PRIME)
set specwindow = rectangular
fft v(V_OUT_PRIME)
let vout_mag = mag(v(V_OUT_PRIME))
meas sp vout_fund find vout_mag at=2.4G
meas sp vout_3rd find vout_mag at=7.2G
let iip3 = -24.77 + 10 * log10(vout_fund / vout_3rd)
print iip3

quit
.endc
.end