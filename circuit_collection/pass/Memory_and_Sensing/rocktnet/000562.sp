* SRAM Cell N-Curve and Standby Power Testbench
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

VVDD VDD 0 1.8
VWL WL 0 0
Vforce BL_L 0 0

XM1 BL_L BL_H VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 BL_H BL_L VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 BL_H BL_L GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 BL_L BL_H GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 BL_L WL BL_L GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 BL_H WL BL_H GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

.control
  * 1. Operating Point for Standby Power
  op
  let standby_power = -i(VVDD) * 1.8
  print standby_power

  * 2. DC Sweep for N-Curve (Stability and Write Margin)
  dc Vforce 0 1.8 0.01
  * Current entering the node from the source
  let I_node = -i(Vforce)
  
  meas dc I_SINM max I_node
  meas dc I_WTI min I_node
  meas dc V_trip when v(BL_H)=0.9 fall=1
  
  quit
.endc
.end