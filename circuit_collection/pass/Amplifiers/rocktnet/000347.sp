* Cascode LNA Core Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

* Upsized W and L for RF LNA operation
.param W_xm1=50.0 L_xm1=0.15
.param W_xm2=50.0 L_xm2=0.15

* DUT
* Note: XM1 gate was changed from GND to VB to allow proper cascode biasing.
XM1 N7 VB N2 N2 sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Biasing and Supply
VVDD VDD 0 1.8
VVB VB 0 1.8

* Input Source (Two-tone for OIP3, DC bias 0.9V, AC 1V)
V_in N_src N_tone2 dc 0.9 ac 1 sin(0.9 0.01 5.2G)
V_tone2 N_tone2 0 dc 0 sin(0 0.01 5.3G)
R_src N_src LABEL_NET_0 50

* Tuned Load (Resonates near 5.2 GHz)
L1 VDD N7 1n
C1 N7 0 0.5p
R1 N7 VDD 500

.control
* 1. DC Analysis
op
let idc = -i(VVDD)
let dc_power = idc * 1.8
print dc_power

* 2. AC Analysis
ac dec 100 1G 10G
let gain_db = db(v(N7))
meas ac voltage_gain find gain_db at=5.2G
meas ac max_gain max gain_db
meas ac peak_frequency max_at gain_db
print voltage_gain peak_frequency

* 3. Noise Analysis
* Calculates input-referred noise spectrum and derives Noise Figure (NF)
noise v(N7) V_in lin 1 5.2G 5.2G
setplot noise1
* Thermal noise of 50 ohm resistor at 300K is 4*k*T*R = 8.28e-21 V^2/Hz
let nf_val = (inoise_spectrum * inoise_spectrum) / 8.28e-21
let noise_figure = 10 * log10(nf_val)
print noise_figure

* 4. Transient Analysis for OIP3
* Two-tone at 5.2 GHz and 5.3 GHz. IM3 is at 5.1 GHz and 5.4 GHz.
tran 10p 100n
linearize v(N7)
fft v(N7)
let mag_v = mag(v(N7))
meas sp fund_mag MAX mag_v from=5.15G to=5.25G
meas sp im3_mag MAX mag_v from=5.05G to=5.15G
let p_fund = 20 * log10($&fund_mag) + 10
let p_im3 = 20 * log10($&im3_mag + 1e-20) + 10
let oip3 = p_fund + (p_fund - p_im3)/2
print oip3

quit
.endc
.end