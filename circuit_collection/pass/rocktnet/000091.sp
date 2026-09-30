* Common-Source Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm1=5.0 L_xm1=0.15 M_xm1=10
.param W_xm2=5.0 L_xm2=0.15 M_xm2=10

XM1 N3 LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1} m={M_xm1}
XM2 N3 N1 0 0 sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2} m={M_xm2}

* Power Supplies
VVDD VDD 0 1.8

* PMOS Active Load Bias
VLABEL_NET_1 LABEL_NET_1 0 0.2

* Self-bias feedback resistor to keep NMOS in saturation
Rbias N3 N1 10Meg

* AC and Transient Input Source
Rsrc IN_AC_SRC IN_AC 50
Cac IN_AC N1 1u
Vac IN_AC_SRC 0 DC 0 AC 1 SIN(0 10m 1.9G)

* Load capacitance to simulate next stage / parasitics
Cload N3 0 10f

.control
  * DC Operating Point
  op
  let DC_Power = -i(VVDD) * 1.8
  print DC_Power

  * AC Analysis
  ac dec 100 1k 10G
  let gain_db = db(v(N3))
  meas ac Low_Freq_Gain find gain_db at=1Meg
  print Low_Freq_Gain
  
  meas ac Gain_1_9GHz find gain_db at=1.9G
  print Gain_1_9GHz
  
  meas ac Bandwidth_3dB when gain_db='Low_Freq_Gain-3' fall=1
  print Bandwidth_3dB

  * Noise Analysis
  noise v(N3) Vac dec 100 1k 10G
  
  * Switch to AC plot to allow 'meas' command on noise data
  setplot ac1
  let inoise_spec = noise1.inoise_spectrum
  * Calculate Noise Figure for a 50 Ohm source at 300K
  let NF_vec = 20*log10(inoise_spec) + 180.815
  meas ac Noise_Figure find NF_vec at=1.9G
  print Noise_Figure

  quit
.endc
.end