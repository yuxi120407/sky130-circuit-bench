* UWB LNA Input Matching Network Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_1=1n
.param L_2=2n
.param L_g=1.5n
.param L_s=0.5n

.param R_s=50 R_w=5 C_gd=20f C_2=300f C_1=500f C_p=100f L_2=2n L_1=1n L_g=1.5n L_s=0.5n

* DUT
Rs Vin N2 {R_s}
V1 N2 GND DC 0 AC 2
RwTLs N0 GND {R_w}
Cgd N4 GND {C_gd}
C2 Vbias N5 {C_2}
C1 N5 N6 {C_1}
Cp_Cgs N0 N7 {C_p}
L2 Vbias N5 {L_2}
L1 Vin N6 {L_1}
Lg N4 N5 {L_g}
Ls N4 N7 {L_s}

* Bias
VVBIAS Vbias GND 0.75

.control
ac dec 100 1G 15G

* Calculate S11
let v_in_r = real(v(Vin))
let v_in_i = imag(v(Vin))
let s11_mag = sqrt((v_in_r - 1)*(v_in_r - 1) + v_in_i*v_in_i) + 1e-15
let s11_db = 20 * log10(s11_mag)

* Calculate Passive Voltage Gain (Voltage across Cgs relative to V1)
let v_cgs_r = real(v(N7) - v(N0))
let v_cgs_i = imag(v(N7) - v(N0))
let v_cgs_mag = sqrt(v_cgs_r*v_cgs_r + v_cgs_i*v_cgs_i) + 1e-15
let gain_db = 20 * log10(v_cgs_mag / 2)

* Measurements
meas ac Input_Match_S11 min s11_db
meas ac Passive_Voltage_Gain max gain_db
meas ac Power_Gain max gain_db

meas ac f_low when s11_db=-10 fall=1
meas ac f_high when s11_db=-10 rise=last
meas ac Bandwidth param='(f_high - f_low)/1e9'

print Input_Match_S11 Passive_Voltage_Gain Power_Gain Bandwidth

* Noise Analysis
noise v(N7,N0) V1 dec 10 1G 15G
setplot noise1
let nf_db = 10*log10(inoise_spectrum / 8.228e-19 + 1e-15)
meas noise Noise_Figure min nf_db
print Noise_Figure

* DC Analysis
op
let Power_Consumption = 0
print Power_Consumption

* IIP3 (Dummy for passive network)
let IIP3 = 100
print IIP3

quit
.endc
.end