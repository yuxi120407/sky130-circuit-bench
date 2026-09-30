* Double-Balanced Mixer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=10.0 L_xm1=0.15
.param W_xm2=10.0 L_xm2=0.15
.param W_xm3=10.0 L_xm3=0.15
.param W_xm4=20.0 L_xm4=0.15
.param W_xm5=20.0 L_xm5=0.15
.param W_xm6=10.0 L_xm6=0.15

* DUT
XM1 N4 LABEL_NET_0 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N7 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 LABEL_NET_1 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 N7 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

* Power Supply and Loads
VDD VDD 0 1.8
RL1 N3 VDD 1k
RL2 N4 VDD 1k

* LO connections
R_LO1 LABEL_NET_0 LO_minus 0
R_LO2 LABEL_NET_1 LO_minus 0

* Biasing and Signals
* RF: Two-tone at 900 MHz and 901 MHz, 10mV peak each single-ended
V_RF_bias_plus N5_bias 0 0.6
V_RF1_plus N5_1 N5_bias sin(0 10m 900Meg)
V_RF2_plus N5 N5_1 sin(0 10m 901Meg)

V_RF_bias_minus N1_bias 0 0.6
V_RF1_minus N1_1 N1_bias sin(0 10m 900Meg 0 0 180)
V_RF2_minus N1 N1_1 sin(0 10m 901Meg 0 0 180)

* LO: 890 MHz, 300mV peak single-ended
V_LO_bias_plus N7_bias 0 1.0
V_LO_bias_minus LO_minus_bias 0 1.0
V_LO_ac_plus N7 N7_bias sin(0 300m 890Meg)
V_LO_ac_minus LO_minus LO_minus_bias sin(0 300m 890Meg 0 0 180)

* IF Filter (fc = 10.6 MHz)
R_f1 N3 N3_f 10k
C_f1 N3_f 0 1.5p
R_f2 N4 N4_f 10k
C_f2 N4_f 0 1.5p

* Dependent source for differential IF (useful for noise analysis)
B_IF_diff IF_diff 0 V='v(N3_f) - v(N4_f)'

.control
  * 1. Transient Analysis for Power, Gain, and IIP3
  * tstep=0.1n ensures Nyquist > 900MHz to avoid aliasing
  tran 0.1n 4u
  
  * Power
  let power = -i(VDD) * 1.8
  meas tran avg_power avg power from=2u to=4u
  
  * FFT for Gain and IIP3
  let v_if = v(N3_f) - v(N4_f)
  linearize v_if
  set specwindow = blackman
  fft v_if
  let mag_v_if = mag(v_if)
  
  * IF1 is at 10 MHz (900 - 890)
  meas sp val_IF1 max mag_v_if from=9.5Meg to=10.5Meg
  * IM3 is at 9 MHz (2*900 - 901 - 890)
  meas sp val_IM3 max mag_v_if from=8.5Meg to=9.5Meg
  
  * Calculate Conversion Gain (using IF1 and RF1 amplitude)
  * RF1 diff amplitude is 20mV
  let rf_amp = 20m
  let conv_gain = val_IF1 / rf_amp
  let conv_gain_db = 20 * log10(conv_gain)
  
  * Calculate IIP3
  let IF1_dB = 20 * log10(val_IF1)
  let IM3_dB = 20 * log10(val_IM3)
  let IM3_diff = IF1_dB - IM3_dB
  * IIP3 in dBm (assuming 50 ohm reference: 0 dBV peak = +10 dBm)
  let iip3_dbm = 20 * log10(rf_amp) + IM3_diff / 2 + 10
  
  print avg_power
  print conv_gain_db
  print iip3_dbm
  
  * 2. Noise Analysis (Baseband approximation)
  * Note: Standard SPICE noise analysis does not fold RF noise.
  * This only measures the baseband noise of the mixer.
  noise v(IF_diff) V_RF1_plus dec 10 1Meg 100Meg
  setplot noise1
  print inoise_total
  print onoise_total
  
  quit
.endc
.end
