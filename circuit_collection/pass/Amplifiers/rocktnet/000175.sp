* Testbench for Folded Cascode OTA

.param W_xm16=20.0 L_xm16=0.5
.param W_xm5=20.0 L_xm5=0.5
.param W_xm6=20.0 L_xm6=0.5
.param W_xm18=20.0 L_xm18=0.5
.param W_xm8=20.0 L_xm8=0.5
.param W_xm1=20.0 L_xm1=0.5
.param W_xm2=20.0 L_xm2=0.5
.param W_xm19=20.0 L_xm19=0.5
.param W_xm9=20.0 L_xm9=0.5
.param W_xm4=30.0 L_xm4=0.5
.param W_xm3=30.0 L_xm3=0.5

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* DUT
XM16 N_M18_S VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}
XM5 N_TAIL VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N_M8_S VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM18 VO_PLUS G_M18 N_M18_S VDD sky130_fd_pr__pfet_01v8 l={L_xm18} w={W_xm18}
XM8 VO_MINUS G_M8 N_M8_S VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM1 N_M19_S VI_MINUS N_TAIL VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N_M9_S VI_PLUS N_TAIL VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM19 VO_PLUS G_M19 N_M19_S GND sky130_fd_pr__nfet_01v8 l={L_xm19} w={W_xm19}
XM9 VO_MINUS G_M9 N_M9_S GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM4 N_M19_S VB4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM3 N_M9_S VB4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

* Power Supply
VVDD VDD 0 1.8

* Bias Voltages
VVB1 VB1 0 1.1
VVB2 VB2 0 0.6
VVB3 VB3 0 1.1
VVB4_DC VB4_DC 0 0.7

* Connect gates to bias
R1 G_M18 VB2 0
R2 G_M8 VB2 0
R3 G_M19 VB3 0
R4 G_M9 VB3 0

* Ideal CMFB to set output common-mode to 0.9V
E_CMFB VB4 0 vol='v(VB4_DC) + 10*( (v(VO_PLUS) + v(VO_MINUS))/2 - 0.9 )'

* Input Signals
V_IN_CM V_IN_CM 0 0.9
V_IN_P VI_PLUS V_IN_CM dc 0 ac 0.5
V_IN_M VI_MINUS V_IN_CM dc 0 ac -0.5

* Load Capacitors
CL1 VO_PLUS 0 1p
CL2 VO_MINUS 0 1p

* Differential Output
E_DIFF V_OUT_DIFF 0 vol='V(VO_PLUS) - V(VO_MINUS)'

.control
  op
  let power = -i(VVDD) * 1.8
  print power

  * Differential AC Analysis
  ac dec 100 1 1G
  let gain_db = vdb(V_OUT_DIFF)
  let phase = 180/PI * cph(v(V_OUT_DIFF))
  let phase_margin_vec = 180 + phase
  
  meas ac dc_gain find gain_db at=10
  meas ac ugf when gain_db=0 fall=1
  meas ac phase_margin find phase_margin_vec when gain_db=0 fall=1
  
  print dc_gain
  print ugf
  print phase_margin

  set dc_gain_val = $&dc_gain

  * Common-Mode AC Analysis
  alter V_IN_CM ac=1
  alter V_IN_P ac=0
  alter V_IN_M ac=0
  ac dec 100 1 1G
  let cm_gain_db = vdb(V_OUT_DIFF)
  meas ac cm_gain_dc find cm_gain_db at=10
  print cm_gain_dc
  
  let cmrr = $dc_gain_val - cm_gain_dc
  print cmrr
  
  quit
.endc
.end