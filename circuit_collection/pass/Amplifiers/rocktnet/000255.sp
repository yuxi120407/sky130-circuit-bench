* Testbench for Fully Differential Pre-Amplifier

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_n=0.5
.param L_p=0.5

* Parameters
.param W_p=20.0 L_p=1.0
.param W_n=10.0 L_n=1.0

* DUT
X_T3P NET_T4P_S NET_T4CM_S GND GND sky130_fd_pr__nfet_01v8 w='W_n' l='L_n'
X_T11 NET_T11_D VB4 GND GND sky130_fd_pr__nfet_01v8 w='W_n' l='L_n'
X_T4CM NET_T4CM_D NET_T4CM_D NET_T4CM_S GND sky130_fd_pr__nfet_01v8 w='W_n' l='L_n'
X_T3CM NET_T4CM_S VCM GND GND sky130_fd_pr__nfet_01v8 w='W_n' l='L_n'
X_T1 NET_T1_D VB2 NET_T0_D VDD sky130_fd_pr__pfet_01v8 w='W_p' l='L_p'
X_T9P NET_T11_D NET_T11_D NET_T8P_D VDD sky130_fd_pr__pfet_01v8 w='W_p' l='L_p'
X_T2 NET_T4_S IN_PLUS NET_T1_D VDD sky130_fd_pr__pfet_01v8 w='W_p' l='L_p'
X_T4P NET_T5P_S NET_T4CM_D NET_T4P_S GND sky130_fd_pr__nfet_01v8 w='W_n' l='L_n'
X_T6 OUT_MINUS OUT_MINUS NET_T7_D VDD sky130_fd_pr__pfet_01v8 w='W_p' l='L_p'
X_T5 OUT_MINUS VB3 NET_T5_S GND sky130_fd_pr__nfet_01v8 w='W_n' l='L_n'
X_T8P NET_T8P_D NET_T8P_D NET_T9PTOP_D VDD sky130_fd_pr__pfet_01v8 w='W_p' l='L_p'
X_T13 NET_T4CM_D VB2 NET_T12_D VDD sky130_fd_pr__pfet_01v8 w='W_p' l='L_p'
X_T9PTOP NET_T9PTOP_D VB2 NET_T10P_D VDD sky130_fd_pr__pfet_01v8 w='W_p' l='L_p'
X_T10P NET_T10P_D VB1 VDD VDD sky130_fd_pr__pfet_01v8 w='W_p' l='L_p'
X_T3 NET_T4_S NET_T4CM_S GND GND sky130_fd_pr__nfet_01v8 w='W_n' l='L_n'
X_T12 NET_T12_D VB1 VDD VDD sky130_fd_pr__pfet_01v8 w='W_p' l='L_p'
X_T5P OUT_PLUS VB3 NET_T5P_S GND sky130_fd_pr__nfet_01v8 w='W_n' l='L_n'
X_T7 NET_T7_D NET_T7_D NET_T9TOP_D VDD sky130_fd_pr__pfet_01v8 w='W_p' l='L_p'
X_T0 NET_T0_D VB1 VDD VDD sky130_fd_pr__pfet_01v8 w='W_p' l='L_p'
X_T10 NET_T10_D VB1 VDD VDD sky130_fd_pr__pfet_01v8 w='W_p' l='L_p'
X_T9 NET_T11_D NET_T11_D NET_T8_D VDD sky130_fd_pr__pfet_01v8 w='W_p' l='L_p'
X_T6P OUT_PLUS OUT_PLUS NET_T7P_D VDD sky130_fd_pr__pfet_01v8 w='W_p' l='L_p'
X_T4 NET_T5_S NET_T4CM_D NET_T4_S GND sky130_fd_pr__nfet_01v8 w='W_n' l='L_n'
X_T7P NET_T7P_D NET_T7P_D NET_T9PTOP_D VDD sky130_fd_pr__pfet_01v8 w='W_p' l='L_p'
X_T8 NET_T8_D NET_T8_D NET_T9TOP_D VDD sky130_fd_pr__pfet_01v8 w='W_p' l='L_p'
X_T9TOP NET_T9TOP_D VB2 NET_T10_D VDD sky130_fd_pr__pfet_01v8 w='W_p' l='L_p'
X_T2P NET_T4P_S IN_MINUS NET_T1_D VDD sky130_fd_pr__pfet_01v8 w='W_p' l='L_p'

* Sources
VVDD VDD 0 1.8
VVB1 VB1 0 1.0
VVB2 VB2 0 0.6
VVB3 VB3 0 0.9
E_VB4 VB4 0 NET_T11_D 0 1.0
E_VCM VCM 0 NET_T4CM_S 0 1.0

* Common mode and differential inputs
V_IN_CM IN_CM 0 0.6
E_IN_PLUS IN_PLUS IN_CM IN_DIFF 0 0.5
E_IN_MINUS IN_MINUS IN_CM IN_DIFF 0 -0.5
V_IN_DIFF IN_DIFF 0 DC 0 AC 1 SIN(0 0.1 1k 0 0)

* Load capacitors
C_L1 OUT_PLUS 0 1p
C_L2 OUT_MINUS 0 1p

.control
  * OP Analysis
  op
  let power = -i(VVDD) * 1.8
  print power

  * AC Analysis for Differential Gain
  ac dec 100 0.1 100MEG
  let vout_diff = v(OUT_PLUS) - v(OUT_MINUS)
  let gain_db = db(vout_diff)
  
  meas ac dc_gain find gain_db at=0.1
  meas ac bw_3db when gain_db='dc_gain - 3' fall=1
  
  print dc_gain
  print bw_3db
  
  * Transient Analysis
  tran 1u 2m
  let vout_diff_tran = v(OUT_PLUS) - v(OUT_MINUS)
  meas tran vout_diff_max max vout_diff_tran
  meas tran vout_diff_min min vout_diff_tran
  
  quit
.endc
.end