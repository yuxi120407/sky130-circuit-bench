* Testbench for Quadrature Mixer
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
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
.param W_xm10=5.0 L_xm10=0.5

* DUT
XM1 IF_Ip LO_In N5 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 IF_In LO_Ip N5 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 IF_Qp LO_Qn N5 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 IF_Qn LO_Qp N5 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N6 VBIAS N10 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 IF_Qp LO_Qp N6 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N5 VBIAS N2 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 IF_Ip LO_Ip N6 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 IF_In LO_In N6 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 IF_Qn LO_Qn N6 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Power and Bias
VVDD VDD 0 1.8
VVBIAS VBIAS 0 0.9

* IF Load Resistors
R1 IF_Ip VDD 10k
R2 IF_In VDD 10k
R3 IF_Qp VDD 10k
R4 IF_Qn VDD 10k

* RF Inputs (2.402 GHz and 2.403 GHz for two-tone test)
VRF_p N10 N10_mid DC 0 SIN(0 10m 2.402G 0 0 0) AC 1
VRF_p2 N10_mid 0 DC 0 SIN(0 10m 2.403G 0 0 0)
VRF_n N2 N2_mid DC 0 SIN(0 10m 2.402G 0 0 180)
VRF_n2 N2_mid 0 DC 0 SIN(0 10m 2.403G 0 0 180)

* LO Inputs (2.4 GHz Quadrature)
VLO_Ip LO_Ip 0 DC 1.2 SIN(1.2 0.6 2.4G 0 0 0)
VLO_In LO_In 0 DC 1.2 SIN(1.2 0.6 2.4G 0 0 180)
VLO_Qp LO_Qp 0 DC 1.2 SIN(1.2 0.6 2.4G 0 0 90)
VLO_Qn LO_Qn 0 DC 1.2 SIN(1.2 0.6 2.4G 0 0 270)

* Behavioral sources for differential IF
B1 IF_I_diff 0 V=v(IF_Ip)-v(IF_In)
B2 IF_Q_diff 0 V=v(IF_Qp)-v(IF_Qn)

.control
  * Run transient analysis for 10us
  tran 20p 10u
  
  * Measure power consumption
  meas tran I_VDD avg i(VVDD) from=2u to=10u
  let power_consumption = -1 * $&I_VDD * 1.8
  print power_consumption
  
  * Measure Conversion Gain (Time-domain beat signal peak-to-peak)
  meas tran IF_max max v(IF_I_diff) from=2u to=10u
  meas tran IF_min min v(IF_I_diff) from=2u to=10u
  * For two equal tones, peak-to-peak of the beat envelope is 4x the single tone amplitude
  let fund_amp_time = ($&IF_max - ($&IF_min)) / 4
  * Input differential peak amplitude per tone is 20mV
  let conversion_gain = 20 * log10(fund_amp_time / 0.02)
  print conversion_gain
  
  * Measure IIP3 (FFT)
  linearize v(IF_I_diff)
  fft v(IF_I_diff)
  
  let IF_mag = mag(v(IF_I_diff))
  meas sp fund_amp_fft MAX IF_mag from=1.9Meg to=2.1Meg
  meas sp im3_amp_fft MAX IF_mag from=0.9Meg to=1.1Meg
  
  let fund_db = 20 * log10($&fund_amp_fft)
  let im3_db = 20 * log10($&im3_amp_fft)
  * Input power per tone: 20mV diff peak -> 14.14mV rms -> -23.979 dBm (in 50 ohms)
  let pin_dbm = -23.979
  let iip3 = pin_dbm + (fund_db - im3_db)/2
  print iip3
  
  * Measure Noise Figure
  * Unbalance the LO to measure DC noise figure as an approximation for the switching mixer
  alter VLO_Ip dc=1.5
  alter VLO_In dc=0.9
  noise v(IF_Ip,IF_In) VRF_p dec 10 1Meg 10Meg
  setplot noise1
  let k = 1.380649e-23
  let T = 298.15
  let Rs = 50
  let inoise_sq = inoise_spectrum * inoise_spectrum
  meas noise inoise_sq_avg avg inoise_sq from=1Meg to=10Meg
  let noise_figure = 10 * log10($&inoise_sq_avg / (4 * k * T * Rs))
  print noise_figure
  
  quit
.endc
.end