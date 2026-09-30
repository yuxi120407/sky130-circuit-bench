* Testbench for LNA and Quadrature Mixer
.param W_xm3=5.0 L_xm3=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm5=5.0 L_xm5=0.5

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

* DUT
XM3 N9 N0 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM8 N1 LO_Q N6 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM2 N4 VB2 N11 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM4 N7 LO_I N9 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM6 N6 N0 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM1 N11 VIN N5 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM7 N10 LO_Q_BAR N6 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM5 N2 LO_I_BAR N9 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}

* Connections
V_N4_N3 N4 N3 0
V_N5 N5 0 0
V_N0 N0 VB1 0

* Power Supply
VVDD VDD 0 1.8

* Biases
VVB1 VB1 0 1.3
VVB2 VB2 0 1.0
VVIN_DC VIN_DC 0 0.7

* RF Input (2.4 GHz, 30mV peak, AC=1 for AC analysis)
VRF VIN VIN_DC dc 0 ac 1 sin(0 30m 2.4G 0 0)

* LO Signals (2.3 GHz, 200mV peak, 1.5V DC)
VLO_I LO_I 0 dc 1.5 sin(1.5 0.2 2.3G 0 0 0)
VLO_I_BAR LO_I_BAR 0 dc 1.5 sin(1.5 0.2 2.3G 0 0 180)
VLO_Q LO_Q 0 dc 1.5 sin(1.5 0.2 2.3G 0 0 90)
VLO_Q_BAR LO_Q_BAR 0 dc 1.5 sin(1.5 0.2 2.3G 0 0 270)

* Loads
R1 N7 VDD 10k
R2 N2 VDD 10k
R3 N1 VDD 10k
R4 N10 VDD 10k

.control
  * 1. DC Power
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  * 2. AC Analysis for LNA Gain and Operating Frequency
  ac dec 10 1G 10G
  meas ac lna_gain find vdb(N4) at=2.4G
  let operating_frequency = 2.4e9
  print lna_gain
  print operating_frequency

  * 3. Noise Analysis
  noise v(N7,N2) VRF dec 10 1G 10G
  setplot noise1
  meas ac inoise_24g find inoise_spectrum at=2.4G
  let k = 1.380649e-23
  let T = 298.15
  let R = 50
  let noise_figure = 10 * log10(inoise_24g / (4 * k * T * R))
  print noise_figure

  * 4. Transient Analysis for Conversion Gain, IF Frequency, and IIP3
  tran 10p 100n
  let v_if_i = v(N7) - v(N2)
  
  let pi = 3.141592653589793
  
  * Synchronous detection for 100 MHz (Fundamental)
  let if_sin = sin(2 * pi * 100e6 * time)
  let if_cos = cos(2 * pi * 100e6 * time)
  let mix_sin = v_if_i * if_sin
  let mix_cos = v_if_i * if_cos
  meas tran int_sin integ mix_sin from=0 to=100n
  meas tran int_cos integ mix_cos from=0 to=100n
  let fund_sin = int_sin / 50n
  let fund_cos = int_cos / 50n
  let fund = sqrt(fund_sin * fund_sin + fund_cos * fund_cos)
  
  * Synchronous detection for 300 MHz (HD3)
  let if3_sin = sin(2 * pi * 300e6 * time)
  let if3_cos = cos(2 * pi * 300e6 * time)
  let mix3_sin = v_if_i * if3_sin
  let mix3_cos = v_if_i * if3_cos
  meas tran int3_sin integ mix3_sin from=0 to=100n
  meas tran int3_cos integ mix3_cos from=0 to=100n
  let hd3_sin = int3_sin / 50n
  let hd3_cos = int3_cos / 50n
  let hd3 = sqrt(hd3_sin * hd3_sin + hd3_cos * hd3_cos)
  
  let if_frequency = 100e6
  let rf_amp = 30e-3
  let conversion_gain_linear = fund / rf_amp
  let conversion_gain = 20 * log10(conversion_gain_linear)
  
  let hd3_safe = hd3 + 1e-15
  let hd3_dbc = 20 * log10(hd3_safe / fund)
  let im3_dbc = hd3_dbc + 9.54
  let pin_dbm = 10 * log10((rf_amp * rf_amp / 2) / 50) + 30
  let iip3 = pin_dbm - im3_dbc / 2
  
  print conversion_gain
  print if_frequency
  print iip3
  
  quit
.endc
.end