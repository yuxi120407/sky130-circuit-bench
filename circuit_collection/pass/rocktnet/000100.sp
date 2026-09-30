* Gilbert Cell Up-Converter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* DUT (NPNs replaced with SKY130 NMOS for CMOS adaptation)
I1 n3 GND 5m
L1 n3 n9 1n
L2 n3 n8 1n
L3 n6 n7 2n
C1 n6 n10 230f
L4 n7 VDD 10u
L5 label_net_0 GND 1n
X1 n10 n2 n1 GND sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
L6 n7 n10 2n
X2 n6 n2 n5 GND sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
X3 n10 n0 n5 GND sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
X4 n1 label_net_1 n8 GND sky130_fd_pr__nfet_01v8 w=20.0 l=0.15
R1 n2 n4 1k
R2 n0 n4 1k
L7 n0 n2 5n
X5 n5 label_net_2 n9 GND sky130_fd_pr__nfet_01v8 w=20.0 l=0.15
X6 n6 n0 n1 GND sky130_fd_pr__nfet_01v8 w=10.0 l=0.15

* Power Supply
V1 VDD GND 1.8

* Biasing
Vbias_LO n4 GND 1.2

* Existing Testbench DC Sources (with series resistors to prevent inductor shorts)
VLABEL_NET_0 label_net_0_src GND 0.9
R_src0 label_net_0_src label_net_0 50
VLABEL_NET_1 label_net_1 IF_ac_p 0.9
VLABEL_NET_2 label_net_2 IF_ac_n 0.9

* IF Signal (200 MHz Baseband/IF)
VIF_p IF_ac_p GND dc 0 sin(0 0.01 200Meg)
VIF_n IF_ac_n GND dc 0 sin(0 0.01 200Meg 0 0 180)

* LO Signal (5 GHz Local Oscillator, AC Coupled)
VLO_p n2_ac GND dc 0 sin(0 0.3 5G)
VLO_n n0_ac GND dc 0 sin(0 0.3 5G 0 0 180)
C_LO_p n2_ac n2 1p
C_LO_n n0_ac n0 1p

.control
  * DC Operating Point for Power
  op
  let power_consumption = -i(V1) * 1.8
  print power_consumption
  let supply_voltage = 1.8
  print supply_voltage

  * Transient Analysis for Conversion Gain
  tran 10p 50n
  
  let v_if = v(label_net_1) - v(label_net_2)
  let v_rf = v(n10) - v(n6)

  * Measure conversion gain using time-domain integration (single-point DFT)
  let pi_val = 3.141592653589793
  let lo_i = sin(2 * pi_val * 5.2G * time)
  let lo_q = cos(2 * pi_val * 5.2G * time)
  let rf_i = v_rf * lo_i
  let rf_q = v_rf * lo_q
  meas tran rf_i_int INTEG rf_i from=10n to=50n
  meas tran rf_q_int INTEG rf_q from=10n to=50n
  let rf_mag = 2 * sqrt(rf_i_int * rf_i_int + rf_q_int * rf_q_int) / 40n

  let if_i = sin(2 * pi_val * 200Meg * time)
  let if_q = cos(2 * pi_val * 200Meg * time)
  let if_mix_i = v_if * if_i
  let if_mix_q = v_if * if_q
  meas tran if_i_int INTEG if_mix_i from=10n to=50n
  meas tran if_q_int INTEG if_mix_q from=10n to=50n
  let if_mag = 2 * sqrt(if_i_int * if_i_int + if_q_int * if_q_int) / 40n

  let conv_gain = (rf_mag + 1e-20) / (if_mag + 1e-20)
  let conversion_gain = 20 * log10(conv_gain)
  print conversion_gain
  
  * Measure operating frequency using FFT
  linearize v_if v_rf
  set specwindow=rectangular
  fft v_if v_rf
  let v_rf_mag = mag(v_rf)
  meas sp rf_freq MAX_AT v_rf_mag from=5.1G to=5.3G
  let operating_frequency = rf_freq
  print operating_frequency

  quit
.endc
.end