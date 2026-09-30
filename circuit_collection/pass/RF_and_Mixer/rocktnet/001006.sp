* Active Envelope Detector Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5

XM1 N3 VB VE2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VE2 VE2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N7 VBL_PLUS VE2 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 VE2 VE2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 VBL_MINUS N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N7 VBL_PLUS N2 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 VBL_MINUS N1 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}

VVDD VDD 0 1.8
VVB VB 0 0.54
VN1 N1 0 0
VN2 N2 0 0

* LC Tank Loads (Resonance at ~8GHz)
L1 VDD N7 1n
C1 N7 VDD 395f
R1 N7 VDD 2k

L2 VDD N0 1n
C2 N0 VDD 395f
R2 N0 VDD 2k

* RF Inputs (DC 0.75V, AC 1V for AC analysis, 8GHz Sine starting at 2.5ns for Tran)
VBLP VBL_PLUS 0 DC 0.75 AC 1 SIN(0.75 0.1 8G 2.5n 0 0)
VBLM VBL_MINUS 0 DC 0.75 AC 1 180 SIN(0.75 0.1 8G 2.5n 0 180)

.control
  * AC Analysis for RF Gain
  ac dec 100 1G 20G
  let gain_db = vdb(N7)
  meas ac max_gain MAX gain_db
  meas ac gain_8g find gain_db at=8G

  * Transient Analysis for Envelope Detection
  tran 1p 5n
  
  * Measure DC Power (before RF turns on)
  meas tran i_vdd avg i(VVDD) from=1n to=2n
  let power_dc = -i_vdd * 1.8
  print power_dc

  * Measure Detector DC Voltage (No RF)
  meas tran ve2_dc avg v(VE2) from=1n to=2n
  
  * Measure Detector Voltage (With RF)
  meas tran ve2_rf avg v(VE2) from=4n to=5n
  
  * Calculate DC Shift (Detection Gain)
  let ve2_shift = ve2_rf - ve2_dc
  print ve2_dc ve2_rf ve2_shift
  
  * Measure Ripple
  meas tran ve2_ripple pp v(VE2) from=4n to=5n
.endc
.end
