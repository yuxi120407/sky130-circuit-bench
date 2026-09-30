* 5.2-GHz CMOS Receiver Mixer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5

* DUT
XM1 N5 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N9 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N8 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 N10 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N3 N10 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 N9 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N7 N6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}

* Biasing and Loads
VVDD VDD 0 1.8
Ibias VDD N2 100u

* RF Bias
R_RF1 N2 N0 10k
R_RF2 N2 N6 10k

* LO Bias
V_LOBIAS N_LOBIAS 0 1.2
R_LO1 N_LOBIAS N9 10k
R_LO2 N_LOBIAS N10 10k

* Mixer Loads (8k to set V(N1,N3) ~ 1.0V for PMOS bias)
R_L1 VDD N1 8k
R_L2 VDD N3 8k

* PMOS Loads (10k to GND)
R_L3 N5 0 10k
R_L4 N4 0 10k

* AC Coupling and Sources
* RF Sources (5.3 GHz, 10mV peak each -> 20mV diff)
V_RF_P N_RFP 0 dc 0 sin(0 10m 5.3G 0 0 0)
V_RF_N N_RFN 0 dc 0 sin(0 10m 5.3G 0 0 180)
C_RF1 N_RFP N0 1p
C_RF2 N_RFN N6 1p

* LO Sources (2.6 GHz, 300mV peak each)
V_LO_P N_LOP 0 dc 0 sin(0 300m 2.6G 0 0 0)
V_LO_N N_LON 0 dc 0 sin(0 300m 2.6G 0 0 180)
C_LO1 N_LOP N9 1p
C_LO2 N_LON N10 1p

* Behavioral mixers for IF extraction (IF = 5.3G - 2.6G = 2.7G)
* 2 * pi * 2.7G = 16.9646G
B_mix_i V_mix_i 0 V = (v(N5) - v(N4)) * sin(16.9646G * time)
B_mix_q V_mix_q 0 V = (v(N5) - v(N4)) * cos(16.9646G * time)

.control
tran 10p 20n

* Measure Power
meas tran I_vdd avg i(VVDD) from=10n to=20n
let power_mW = -I_vdd * 1.8 * 1000
print power_mW

* Measure Conversion Gain
meas tran I_avg avg v(V_mix_i) from=10n to=20n
meas tran Q_avg avg v(V_mix_q) from=10n to=20n
let IF_amp = 2 * sqrt(I_avg*I_avg + Q_avg*Q_avg)
let conv_gain = IF_amp / 20m
let conv_gain_db = 20 * log10(conv_gain)
print conv_gain_db

* Measure DC bias at mixer output
meas tran V_N1_dc avg v(N1) from=10n to=20n
print V_N1_dc

quit
.endc
.end
