* Fully Differential OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xms3=5.0 L_xms3=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xms4=5.0 L_xms4=0.5

VVDD VDD 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 0.9

* Common-mode and Differential-mode inputs
VCM IN_CM 0 0.9
VDM IN_DM 0 DC 0 AC 1 SIN(0 0.1 1MEG 0 0)
E1 IN_PLUS IN_CM IN_DM 0 0.5
E2 IN_MINUS IN_CM IN_DM 0 -0.5

* CMFB Circuit to set output common-mode to 0.9V
Rcm1 OUT_PLUS OUT_CM 100MEG
Rcm2 OUT_MINUS OUT_CM 100MEG
VREF VREF 0 0.9
E_CMFB VCM_CTRL_INT 0 OUT_CM VREF 100
V_OFFSET VCM_CTRL VCM_CTRL_INT 0.9

* DUT
XMS3 OUT_MINUS VCM_CTRL VDD VDD sky130_fd_pr__pfet_01v8 l={L_xms3} w={W_xms3}
XM2 OUT_PLUS IN_MINUS N0 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUT_MINUS IN_PLUS N0 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XMS4 OUT_PLUS VCM_CTRL VDD VDD sky130_fd_pr__pfet_01v8 l={L_xms4} w={W_xms4}

* Load Capacitance
CL1 OUT_PLUS 0 1p
CL2 OUT_MINUS 0 1p

.control
  * DC Operating Point for Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * AC Analysis for Gain, UGBW, and Phase Margin
  ac dec 100 1 1G
  let vout_diff = v(OUT_PLUS) - v(OUT_MINUS)
  let gain_db = db(vout_diff)
  let phase = 180/PI * ph(vout_diff)
  
  meas ac dc_gain find gain_db at=10
  meas ac ugbw when gain_db=0 fall=1
  meas ac phase_at_ugbw find phase when gain_db=0 fall=1
  meas ac phase_margin param='180 + phase_at_ugbw'
  
  print dc_gain
  print ugbw
  print phase_margin

  quit
.endc
.end