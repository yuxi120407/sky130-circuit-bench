* I/Q Upconversion Mixer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.options msubckt
.subckt sky130_fd_pr__nmos5v d g s b W=5.0 L=0.15
X1 d g s b sky130_fd_pr__nfet_01v8 w={W} l={L}
.ends
.model sky130_fd_pr__nmos5v nmos level=1 vto=0.4 kp=100u

* DUT (Adapted for standard SPICE syntax and SKY130)
R1 VCC IFON 500
R2 VCC IFOP 500
Q1 IFON LOIN N1_D npn
Q2 IFOP LOIP N1_D npn
Q5 IFON LOQN N2_D npn
Q6 IFOP LOQP N2_D npn
Q3 IFON LOQN N3_D npn
Q4 IFOP LOQP N3_D npn
Q7 IFON LOIN N4_D npn
Q8 IFOP LOIP N4_D npn
M1 N1_D BBIN N5 GND sky130_fd_pr__nmos5v W=20.0 L=0.5
M3 N2_D BBQP N7 GND sky130_fd_pr__nmos5v W=20.0 L=0.5
M2 N3_D BBIQ N6 GND sky130_fd_pr__nmos5v W=20.0 L=0.5
M4 N4_D BBQN N8 GND sky130_fd_pr__nmos5v W=20.0 L=0.5
M5 N5 VBIAS GND GND sky130_fd_pr__nmos5v W=40.0 L=0.5
M6 N6 VBIAS GND GND sky130_fd_pr__nmos5v W=40.0 L=0.5
M7 N7 VBIAS GND GND sky130_fd_pr__nmos5v W=40.0 L=0.5
M8 N8 VBIAS GND GND sky130_fd_pr__nmos5v W=40.0 L=0.5
R3 N5 N6 100
R4 N7 N8 100

* Generic NPN model for the BiCMOS switching quad
.model npn npn (bf=100 is=1e-16 vaf=50)

* DC Sources
VCC VCC 0 1.8
VVBIAS VBIAS 0 0.7

* LO signals (1 GHz, 0.6Vpp differential)
VLOIP LOIP 0 dc 1.2 sin(1.2 0.3 1G 0 0 0)
VLOIN LOIN 0 dc 1.2 sin(1.2 0.3 1G 0 0 180)
VLOQP LOQP 0 dc 1.2
VLOQN LOQN 0 dc 1.2

* BB signals (10 MHz and 11 MHz, 0.1Vpp each differential on I-channel)
VBBIQ_1 BBIQ_int 0 dc 0.9 sin(0.9 0.05 10Meg 0 0 0)
VBBIQ_2 BBIQ BBIQ_int dc 0 sin(0 0.05 11Meg 0 0 0)

VBBIN_1 BBIN_int 0 dc 0.9 sin(0.9 0.05 10Meg 0 0 180)
VBBIN_2 BBIN BBIN_int dc 0 sin(0 0.05 11Meg 0 0 180)

VBBQP BBQP 0 dc 0.9
VBBQN BBQN 0 dc 0.9

.control
  * Run transient analysis
  tran 10p 2u
  
  * 1. Measure Power Consumption
  let pwr = -i(VCC) * 1.8
  meas tran power_consumption avg pwr from=1u to=2u
  
  * 2. Measure Conversion Gain and OIP3
  let vout_diff = v(IFOP) - v(IFON)
  
  * Linearize for FFT
  linearize vout_diff
  
  * Run FFT
  fft vout_diff
  
  let vout_mag = mag(vout_diff)
  
  * Find the magnitude at 1010 MHz (Fundamental 1)
  meas ac vout_f1 max vout_mag from=1.0099G to=1.0101G
  
  * Find the magnitude at 1009 MHz (IM3 1)
  meas ac vout_im3 max vout_mag from=1.0089G to=1.0091G
  
  * Conversion Gain
  * Input amplitude per tone is 0.05V single-ended, so 0.1V differential.
  let vin_diff_pk = 0.1
  let gain = vout_f1 / vin_diff_pk
  let conversion_gain = 20 * log10(gain)
  
  * OIP3 Calculation
  * Using 50 ohms for standard dBm calculation
  let r_load = 50
  let p_f1_w = (vout_f1 * vout_f1) / (2 * r_load)
  let p_f1_dbm = 10 * log10(p_f1_w * 1000 + 1e-20)
  
  let p_im3_w = (vout_im3 * vout_im3) / (2 * r_load)
  let p_im3_dbm = 10 * log10(p_im3_w * 1000 + 1e-20)
  
  let oip3 = p_f1_dbm + (p_f1_dbm - p_im3_dbm) / 2
  
  print power_consumption
  print conversion_gain
  print oip3
  
  quit
.endc
.end