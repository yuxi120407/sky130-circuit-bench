* Testbench for Pseudo-Differential Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5

XM1 N4 VBN GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 VINN N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 VINP N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 VOUTN N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VOUTP N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VOUTP VBP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 VOUTN VBP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 VBN GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N2 VBP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N1 VBP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}

VVDD VDD 0 1.8
VVBP VBP 0 0.99

* CMFB Network to stabilize output common-mode to 0.9V
E_CMFB VBN_ideal 0 VALUE = {0.6 - 100*((V(VOUTP)+V(VOUTN))/2 - 0.9)}
R_CMFB VBN_ideal VBN 1Meg
C_CMFB VBN 0 1u

* Differential AC inputs (1V and -1V for 2V diff), 0.5V peak for transient
VVINP VINP 0 DC 0.9 AC 1 SIN(0.9 0.5 100k 0 0)
VVINN VINN 0 DC 0.9 AC -1 SIN(0.9 -0.5 100k 0 0)

* VCVS to extract differential output
E_diff VOUT_DIFF 0 VOUTP VOUTN 1

.control
  * 1. DC Operating Point & Power
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  * 2. AC Analysis for Gain and Bandwidth
  ac dec 100 1 1G
  * Subtract 6.02 dB because differential input is 2V (AC 1 - AC -1)
  let gain_db = db(v(VOUT_DIFF)) - 6.02
  meas ac differential_gain find gain_db at=10
  meas ac bandwidth_3dB when gain_db='differential_gain - 3' fall=1
  print differential_gain bandwidth_3dB

  * 3. Transient Analysis for Output Swing
  tran 10n 50u
  meas tran vout_diff_max max v(VOUT_DIFF)
  meas tran vout_diff_min min v(VOUT_DIFF)
  let max_output_swing = vout_diff_max - vout_diff_min
  print max_output_swing
  
  quit
.endc
.end