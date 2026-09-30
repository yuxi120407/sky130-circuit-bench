* RF Front-End Passive Mixer Core Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

* DUT
XM1 N2 LABEL_NET_0 N3 N3 sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 LABEL_NET_5 N10 N10 sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N11 LABEL_NET_8 LABEL_NET_7 N11 sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N12 LABEL_NET_11 LABEL_NET_10 N12 sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* LO Signals (1.9 GHz, 0.9V DC bias, 1.8Vpp swing)
V_LO_p LABEL_NET_0 0 dc 0.9 sin(0.9 0.9 1.9G)
V_LO_p2 LABEL_NET_8 0 dc 0.9 sin(0.9 0.9 1.9G)
V_LO_n LABEL_NET_5 0 dc 0.9 sin(0.9 0.9 1.9G 0 0 180)
V_LO_n2 LABEL_NET_11 0 dc 0.9 sin(0.9 0.9 1.9G 0 0 180)

* RF Signals (Two-tone for IIP3/IIP2, AC for Noise, 0V DC bias)
V_RF_ac RF_ac 0 dc 0 ac 1
V_RF_tone1 tone1 RF_ac dc 0 sin(0 20m 2.0G)
V_RF_tone2 RF_diff_src tone1 dc 0 sin(0 20m 2.01G)

E_RF_p_src N3_src 0 RF_diff_src 0 0.5
E_RF_p2_src N10_src 0 RF_diff_src 0 0.5
E_RF_n_src LABEL_NET_7_src 0 RF_diff_src 0 -0.5
E_RF_n2_src LABEL_NET_10_src 0 RF_diff_src 0 -0.5

R_RF_p N3_src N3 50
R_RF_p2 N10_src N10 50
R_RF_n LABEL_NET_7_src LABEL_NET_7 50
R_RF_n2 LABEL_NET_10_src LABEL_NET_10 50

* IF Output Connections (Routing DUT drains to IF ports)
V_short_IFp1 N2 IF_p 0
V_short_IFp2 N12 IF_p 0
V_short_IFn1 N0 IF_n 0
V_short_IFn2 N11 IF_n 0

* IF Load (Low-pass filter to extract 100 MHz IF, suppress RF/LO)
Rload_p IF_p 0 10k
Cload_p IF_p 0 0.1p
Rload_n IF_n 0 10k
Cload_n IF_n 0 0.1p

* Differential IF Voltage Source for Measurement
E_diff IF_diff 0 IF_p IF_n 1

.control
  * Run transient analysis for 500ns, saving from 100ns to 500ns
  tran 10p 500n 100n
  
  * Measure IF DC Offset
  meas tran IF_DC_Offset avg v(IF_diff) from=100n to=500n
  print IF_DC_Offset
  
  * Linearize and FFT
  linearize
  set specwindow = rectangular
  fft v(IF_diff)
  
  * Measure magnitudes at specific frequencies
  let if_mag = mag(v(IF_diff))
  meas sp fund1_mag MAX if_mag from=99Meg to=101Meg
  meas sp fund2_mag MAX if_mag from=109Meg to=111Meg
  meas sp im3_mag MAX if_mag from=89Meg to=91Meg
  meas sp im2_mag MAX if_mag from=9Meg to=11Meg
  
  * Calculate Voltage Conversion Gain (Source is 20mV peak)
  let Voltage_Conversion_Gain = 20 * log10(fund1_mag / 0.02)
  print Voltage_Conversion_Gain
  
  * Calculate IIP3 and IIP2
  * Pin_dBm for 20mV peak diff into 100 ohms available power
  let Pin_dBm = 10 * log10( (0.02 * 0.02 / 8) / 100 * 1000 )
  let fund1_dBV = 20 * log10(fund1_mag)
  let im3_dBV = 20 * log10(im3_mag)
  let im2_dBV = 20 * log10(im2_mag)
  
  let IIP3 = Pin_dBm + (fund1_dBV - im3_dBV) / 2
  let IIP2 = Pin_dBm + (fund1_dBV - im2_dBV)
  
  print IIP3
  print IIP2
  
  * Run Noise Analysis
  noise v(IF_diff) V_RF_ac lin 11 95Meg 105Meg
  setplot noise1
  meas noise inoise_val MAX inoise_spectrum from=99Meg to=101Meg
  
  let k = 1.380649e-23
  let T = 298.15
  let Rs = 100
  let Noise_Figure = 10 * log10((inoise_val * inoise_val) / (4 * k * T * Rs))
  print Noise_Figure
  
  quit
.endc
.end