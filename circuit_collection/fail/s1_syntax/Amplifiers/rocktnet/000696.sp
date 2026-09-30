* Shunt-Feedback LNA Core Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_m1=0.5

* Parameters
.param W_m1=50 L_m1=0.15
.param R_f=10k R_s=50 R_l=500

* Circuit Netlist (Adapted for SKY130 NMOS)
RF VO N1 {R_f}
RS VS N1 {R_s}
M1 VO N1 GND GND sky130_fd_pr__nfet_01v8 W={W_m1} L={L_m1}
RL VCC VO {R_l}

* Sources
VS VS GND DC 0.9 AC 1
VCC VCC GND DC 1.8

* Control Block
.control
  * 1. DC Operating Point for Power
  op
  let power = -i(VCC) * 1.8
  print power
  
  * 2. AC Analysis for Gain and Bandwidth
  ac dec 100 1Meg 100G
  let gain_db = vdb(VO)
  
  * Measure Maximum Gain
  meas ac max_gain max gain_db
  
  * Measure -3dB Bandwidth
  let gain_3db = max_gain - 3
  meas ac bw_3db when gain_db=gain_3db fall=1
  
  quit
.endc
.end
