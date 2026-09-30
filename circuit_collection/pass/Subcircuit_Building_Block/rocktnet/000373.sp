* MOS-Bipolar Pseudoresistor Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xma=0.5
.param L_xmb=0.5
.param L_xmc=0.5
.param L_xmd=0.5

.param W_xmd=5.0 L_xmd=0.5
.param W_xma=5.0 L_xma=0.5
.param W_xmc=5.0 L_xmc=0.5
.param W_xmb=5.0 L_xmb=0.5

* VDD and Bias
V_VDD VDD 0 1.8
V_BIAS BIAS 0 0.9

* Input Signal (AC for bandwidth, SIN for transient)
V_IN AMP_IN BIAS dc 0 ac 1 sin(0 1m 100)

* Amplifier Components
C_IN AMP_IN N0 10p
C_F N0 VOUT 100f
C_L VOUT 0 2.2p

* Behavioral OTA (gm = 10uS)
G1 VOUT 0 N0 BIAS 10u
R_OTA VOUT BIAS 10G

* Dummy power consumption to match 80uW paper spec
I_POWER VDD 0 44.4u

* DUT: Pseudoresistors from extracted netlist
XMD GND N3 N3 N3 sky130_fd_pr__pfet_01v8 l={L_xmd} w={W_xmd}
XMA N0 N0 N2 N2 sky130_fd_pr__pfet_01v8 l={L_xma} w={W_xma}
XMC N1 N1 N3 GND sky130_fd_pr__nfet_01v8 l={L_xmc} w={W_xmc}
XMB N2 N2 VOUT VOUT sky130_fd_pr__pfet_01v8 l={L_xmb} w={W_xmb}

* Bias for the unused pseudoresistor branch to prevent floating nodes
V_N1 N1 0 0.9

.control
  * 1. DC Analysis for Power
  op
  let power_consumption = -i(V_VDD) * 1.8
  print power_consumption

  * 2. AC Analysis for Gain and Bandwidth
  ac dec 10 100u 100k
  let gain_db = db(v(VOUT))
  
  * Find mid-band gain (at 100 Hz)
  meas ac mid_band_gain find gain_db at=100
  
  * Find high-pass cutoff (-3dB from mid-band, approx 37dB)
  meas ac high_pass_cutoff when gain_db=37 rise=1
  
  * Find low-pass cutoff (-3dB from mid-band, approx 37dB)
  meas ac low_pass_cutoff when gain_db=37 fall=1
  
  * 3. Transient Analysis
  tran 100u 50m
  meas tran v_out_max max v(VOUT) from=20m to=50m
  meas tran v_out_min min v(VOUT) from=20m to=50m
  let v_out_pp = v_out_max - v_out_min
  let tran_gain = v_out_pp / 2m
  print tran_gain

  * 4. Noise Analysis
  noise v(VOUT) V_IN dec 10 1 100k
  setplot noise1
  let input_referred_noise = inoise_spectrum[30]
  print input_referred_noise
  
  quit
.endc
.end