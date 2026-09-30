* 2-GHz CMOS Image-Reject Receiver Mixer Core
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

VVDD VDD 0 1.8
RL1 VOUT_P VDD 1k
RL2 VOUT_N VDD 1k

XM1 N1 VIN_P GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 VIN_N GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VOUT_P VLO_P N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VOUT_N VLO_N N1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VOUT_P VLO_P N2 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VOUT_N VLO_N N2 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

* Buffers to prevent filter loading
E1 VOUT_P_BUF 0 VOUT_P 0 1
E2 VOUT_N_BUF 0 VOUT_N 0 1

* 2-stage RC Low-pass filters (fc ~ 160MHz) to extract IF
R_f1a VOUT_P_BUF VOUT_P_F1 1k
C_f1a VOUT_P_F1 0 300f
R_f1b VOUT_P_F1 VOUT_P_F 1k
C_f1b VOUT_P_F 0 300f

R_f2a VOUT_N_BUF VOUT_N_F1 1k
C_f2a VOUT_N_F1 0 300f
R_f2b VOUT_N_F1 VOUT_N_F 1k
C_f2b VOUT_N_F 0 300f

* Difference signal for measurement
B1 VOUT_DIFF 0 V = V(VOUT_P_F) - V(VOUT_N_F)

* Sources (RF=2GHz, LO=1.81GHz -> IF=190MHz)
VVIN_P VIN_P 0 DC 1.0 SIN(1.0 0.01 2G 0 0 0)
VVIN_N VIN_N 0 DC 1.0 SIN(1.0 0.01 2G 0 0 180)
VVLO_P VLO_P 0 DC 1.2 SIN(1.2 0.5 1.81G 0 0 0)
VVLO_N VLO_N 0 DC 1.2 SIN(1.2 0.5 1.81G 0 0 180)

.control
tran 10p 150n

* 1. Power Consumption
let power = -i(VVDD) * 1.8
meas tran Power_consumption avg power from=50n to=150n

* 3. Operating Frequency (RF)
meas tran trf1 WHEN v(VIN_P)=1.0 RISE=1 FROM=51.1n
meas tran trf2 WHEN v(VIN_P)=1.0 RISE=2 FROM=51.1n
let Operating_frequency = 1 / (trf2 - trf1)

* LO Frequency
meas tran tlo1 WHEN v(VLO_P)=1.2 RISE=1 FROM=51.1n
meas tran tlo2 WHEN v(VLO_P)=1.2 RISE=2 FROM=51.1n
let LO_frequency = 1 / (tlo2 - tlo1)

* 2. IF Frequency
let IF_Frequency = Operating_frequency - LO_frequency

* 4. Gain (Conversion Gain)
let pi_val = 3.141592653589793
let omega_if = 2 * pi_val * 190e6
let sin_if = sin(omega_if * time)
let cos_if = cos(omega_if * time)
let v_out_diff_unfiltered = v(VOUT_P) - v(VOUT_N)
let v_if_sin = v_out_diff_unfiltered * sin_if
let v_if_cos = v_out_diff_unfiltered * cos_if

meas tran I_sin avg v_if_sin from=50n to=150n
meas tran I_cos avg v_if_cos from=50n to=150n

let v_if_amp = 2 * sqrt(I_sin * I_sin + I_cos * I_cos)
let Gain = 20 * log10((v_if_amp + 1e-20) / 0.02)

* 5. Output Power (dBm)
* Differential load is 2k (1k + 1k)
let p_out_w = (v_if_amp * v_if_amp) / 4000
let Output_power = 10 * log10((p_out_w + 1e-30) / 1e-3)

print Power_consumption
print IF_Frequency
print Operating_frequency
print Gain
print Output_power
quit
.endc
.end