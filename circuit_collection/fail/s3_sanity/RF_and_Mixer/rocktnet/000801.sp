* CMOS Passive Mixer Testbench

.param W_xm2_n=5.0 L_xm2_n=0.5
.param W_xm1_n=5.0 L_xm1_n=0.5
.param W_xm1_p=5.0 L_xm1_p=0.5
.param W_xm2_p=5.0 L_xm2_p=0.5

* DUT
XM2_N IF_N LOCN N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2_n} w={W_xm2_n}
XM1_N IF_P LON N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1_n} w={W_xm1_n}
XM1_P IF_P N1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1_p} w={W_xm1_p}
XM2_P IF_N N0 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2_p} w={W_xm2_p}

* Biasing and Signals
* RF and IF DC bias set to 0V to ensure Vgs > Vth when LO is high
V_IF_CM IF_CM 0 dc 0

* RF Source (Two-tone: 5.004 GHz and 5.005 GHz, 10mV peak each)
VRF1 N2_ac N2_ac2 dc 0 sin(0 0.01 5.004G) ac 1
VRF2 N2_ac2 0 dc 0 sin(0 0.01 5.005G)
R_RF N2_ac N2 50

* LO Sources (5 GHz, 1.2V peak-to-peak, DC=0.75V)
VLO_P LO_P 0 dc 0.75 sin(0.75 0.6 5G 0 0 0)
VLO_N LO_N 0 dc 0.75 sin(0.75 0.6 5G 0 0 180)

* Connect LO to mixer gates (parallel transistors driven together for basic test)
R_LON LO_P LON 1
R_N1  LO_P N1  1
R_LOCN LO_N LOCN 1
R_N0   LO_N N0   1

* IF Load (Low pass filter to extract 1MHz IF, fc ~ 16MHz)
R_IFP IF_P IF_CM 10k
C_IFP IF_P IF_CM 1p
R_IFN IF_N IF_CM 10k
C_IFN IF_N IF_CM 1p

* Differential IF output for easy measurement
E_diff IF_DIFF 0 IF_P IF_N 1.0

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1_n=0.5
.param L_xm1_p=0.5
.param L_xm2_n=0.5
.param L_xm2_p=0.5

.control
  * Run transient for 6us, save from 2us to 6us (4us window)
  * 4us / 15.2587890625p = 262144 points (exactly 2^18)
  * Frequency resolution = 250 kHz
  tran 15.2587890625p 6u 2u
  
  * Linearize to ensure uniform time steps for FFT
  linearize v(IF_DIFF) v(N2)
  
  * Set rectangular window to avoid spectral leakage
  set specwindow=rectangular
  
  * Perform FFT on IF output and RF input
  fft v(IF_DIFF) v(N2)
  
  * Calculate magnitudes
  let if_mag = mag(v(IF_DIFF))
  let n2_mag = mag(v(N2))
  
  * Measure tones (resolution is 250kHz, so bins are exact)
  meas ac p_IF1 MAX if_mag from=3.9Meg to=4.1Meg
  meas ac p_IF2 MAX if_mag from=4.9Meg to=5.1Meg
  meas ac p_IM3 MAX if_mag from=2.9Meg to=3.1Meg
  meas ac p_IM2 MAX if_mag from=0.9Meg to=1.1Meg
  meas ac p_RF_in MAX n2_mag from=5.0035G to=5.0045G
  
  * Calculate Conversion Gain
  let cg_linear = p_IF1 / (p_RF_in + 1e-15)
  let cg_db = 20 * log10(cg_linear + 1e-15)
  
  * Calculate IIP3 and IIP2
  * Available power of the source per tone is -36.0206 dBm
  let pin_dbm = -36.0206
  
  let im3_dbc = 20 * log10((p_IM3 + 1e-15) / (p_IF1 + 1e-15))
  let iip3_dbm = pin_dbm - im3_dbc / 2
  
  let im2_dbc = 20 * log10((p_IM2 + 1e-15) / (p_IF1 + 1e-15))
  let iip2_dbm = pin_dbm - im2_dbc
  
  * Run noise analysis for Flicker Noise Corner
  * Apply a DC offset to the RF source to generate 1/f noise
  alter VRF1 dc=0.1
  noise v(IF_DIFF, 0) VRF1 dec 10 1 1G
  
  * Switch to noise spectrum plot
  setplot noise1
  
  * Compensate for the 15.915 MHz RC low-pass filter at the IF output
  let onoise_unfiltered = onoise_spectrum * sqrt(1 + (frequency / 15.915e6) * (frequency / 15.915e6))
  
  * Measure thermal noise floor at 100 MHz
  meas ac n_therm find onoise_unfiltered at=100Meg
  
  * Find the 1/f corner frequency (where noise power is 2x thermal, so voltage is sqrt(2)x)
  let n_corner_val = sqrt(2) * n_therm
  meas ac f_corner when onoise_unfiltered=n_corner_val fall=1
  
  * Print all target metrics
  print cg_db iip3_dbm iip2_dbm f_corner
  
  quit
.endc
.end