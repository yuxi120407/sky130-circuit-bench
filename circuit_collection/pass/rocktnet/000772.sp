* Pseudo-differential cascode amplifier testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

* Power supply
VDD VDD 0 1.8

* Load resistors (5k ohms for reasonable gain)
R1 VDD N11 5k
R2 VDD N10 5k
R3 VDD N6 5k
R4 VDD N7 5k

* Bias and Input Sources
Vbias_casc N2 0 1.2
Vbias_in1 LABEL_NET_1 0 0.9 ac 1
Vbias_in3 LABEL_NET_3 0 0.9 ac -1
Vbias_in4 N4 0 0.9 ac 1
Vbias_in9 N9 0 0.9 ac -1

* DUT
XM1 N11 N2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N6 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N10 N2 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N7 N9 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 LABEL_NET_3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

.control
  * DC Operating Point and Power
  op
  let power = -i(VDD) * 1.8
  print power

  * AC Analysis
  ac dec 100 1Meg 100G
  
  * Cascode Amplifier Gain
  let vout_diff = v(N10) - v(N11)
  let gain_mag = mag(vout_diff) / 2
  let gain_db = 20 * log10(gain_mag)
  
  * Common-Source Amplifier Gain
  let vout_cs_diff = v(N6) - v(N7)
  let gain_cs_mag = mag(vout_cs_diff) / 2
  let gain_cs_db = 20 * log10(gain_cs_mag)
  
  * Measurements
  meas ac gain_max max gain_db
  meas ac gain_cs_max max gain_cs_db
  meas ac gain_2G4 find gain_db at=2.4Gig
  meas ac bw_0db when gain_db=0 fall=1
  
  print gain_max gain_cs_max gain_2G4 bw_0db
  quit
.endc
.end