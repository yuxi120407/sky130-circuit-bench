* Testbench for Dual-Band Transceiver VGA Stage

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm_tail=0.5

.param W_xm4=5.0 L_xm4=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm_tail=5.0 L_xm_tail=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm8=5.0 L_xm8=0.5

* DUT
XM4 VDD GAIN_BAR N6 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM1 VOUT_MINUS VDD N7 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM_TAIL N5 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm_tail} w={W_xm_tail}
XM7 N7 VIN_PLUS N0 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM3 VDD GAIN_BAR N7 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM2 VOUT_MINUS N7 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM5 VOUT_PLUS GAIN N6 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VOUT_PLUS VDD N6 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM8 N6 VIN_MINUS N4 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

* Missing connections for the tail (connecting floating sources to tail drain)
V_N0 N0 N5 0
V_N4 N4 N5 0

* Loads
R_L1 VDD VOUT_PLUS 2k
R_L2 VDD VOUT_MINUS 2k

* Differential output dependent source
E_diff VOUT_DIFF 0 VOUT_PLUS VOUT_MINUS 1

* DC Sources
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VGAIN GAIN 0 0
VGAIN_BAR GAIN_BAR 0 0

* Input Sources (AC magnitude 0.5 each for 1V differential)
VVIN_PLUS VIN_PLUS 0 DC 0.9 AC 0.5 SIN(0.9 0.01 2.4G 0 0)
VVIN_MINUS VIN_MINUS 0 DC 0.9 AC -0.5 SIN(0.9 -0.01 2.4G 0 0)

.control
  * DC Analysis
  op
  let power = -i(VVDD) * 1.8
  print power
  
  * AC Analysis
  ac dec 50 100MEG 10G
  let gain_db = vdb(VOUT_DIFF)
  meas ac max_gain max gain_db
  let gain_3db = max_gain - 3
  meas ac f_3db when gain_db=gain_3db fall=1
  
  * Transient Analysis
  tran 10p 5n
  meas tran vout_max max v(VOUT_DIFF)
  meas tran vout_min min v(VOUT_DIFF)
  let vout_pp = vout_max - vout_min
  print vout_pp
  
  quit
.endc
.end
