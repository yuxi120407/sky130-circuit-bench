* Differential LNA / IF Amplifier Testbench
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5

XM1 N1 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 LABEL_NET_2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 LABEL_NET_3 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 LABEL_NET_4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 LABEL_NET_5 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}

* Power Supply
VVDD VDD 0 1.8

* Biases
VLABEL_NET_0 LABEL_NET_0 0 0.9
* Restore missing diode connection for current mirror load (XM2 G=N2 implies XM4 is diode-connected)
V_short LABEL_NET_2 N2 0
* Turn off auxiliary PMOS devices to isolate the main diff pair
VLABEL_NET_4 LABEL_NET_4 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 1.8

* Inputs with L/C feedback for DC stability
V_INP LABEL_NET_3 0 dc 0.9 ac 0.5
V_INN_bias INN_bias 0 dc 0.9 ac -0.5

* 1T Henry inductor closes loop at DC, open at AC
L_fb N0 LABEL_NET_5 1T
* 1T Farad capacitor couples AC input, open at DC
C_ac INN_bias LABEL_NET_5 1T

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_fb=0.5
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.control
  * 1. DC Operating Point & Power
  op
  let power_mw = -i(VVDD) * 1.8 * 1000
  print power_mw

  * 2. AC Analysis for Gain and Bandwidth
  ac dec 50 1Meg 10G
  let gain_db = vdb(N0)
  meas ac gain_dc find gain_db at=1Meg
  meas ac gain_9M find gain_db at=9.45Meg
  meas ac gain_1G5 find gain_db at=1.575G
  
  let target_gain = gain_dc - 3
  meas ac bw_3db when gain_db=$&target_gain fall=1
  
  * 3. Noise Analysis at 1.575 GHz
  noise v(N0) V_INP lin 2 1.575G 1.576G
  setplot noise1
  * Calculate Noise Figure (assuming 50 Ohm source, 4kT*50 = 8.28e-21)
  * NF = 10 * log10(inoise_spectrum^2 / 8.28e-21) = 20 * log10(inoise_spectrum) + 200.8197
  let nf_db = 20 * log10(inoise_spectrum[0]) + 200.8197
  print nf_db
  
  quit
.endc
.end