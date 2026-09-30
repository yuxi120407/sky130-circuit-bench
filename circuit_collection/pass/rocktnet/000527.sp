* Passive VGA Testbench
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.01 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5

* DUT
XM1 N6 N11 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 VDD GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 VDD GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 IFY VDD N4 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N7 N9 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N5 LOY GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N10 VDD GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 IFX VDD N0 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 IFX LABEL_NET_2 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 IFY N8 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Power Supply
VVDD VDD 0 1.8

* Control Voltages (Cross-coupling gates)
Vctrl1 LABEL_NET_2 0 0.0
Vctrl2 N8 0 0.0

* DC Bias for Inputs (Common Mode)
V_IFX_DC IFX_DC 0 0.0
V_IFY_DC IFY_DC 0 0.0

* AC Inputs (Differential 1V peak-to-peak)
V_IFX IFX IFX_DC AC 0.5
V_IFY IFY IFY_DC AC -0.5

* Terminate floating nodes to prevent singular matrix errors
R1 N6 0 1G
R2 N7 0 1G
R3 N5 0 1G
R4 N10 0 1G
V_N11 N11 0 0
V_N9 N9 0 0
V_LOY LOY 0 0

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.control
  * 1. Measure Max Gain (Vctrl = 0V)
  alter Vctrl1 0
  alter Vctrl2 0
  ac dec 10 1k 100G
  let vout_diff = v(N0) - v(N4)
  let vin_diff = v(IFX) - v(IFY)
  let gain_mag = mag(vout_diff) / mag(vin_diff)
  let gain_db = 20 * log10(gain_mag)
  
  meas ac max_gain MAX gain_db
  meas ac bandwidth when gain_db='max_gain - 3' fall=1
  
  let r_in = mag(vin_diff) / mag(i(V_IFX))
  meas ac input_resistance find r_in at=1k
  
  * 2. Measure Min Gain (Vctrl = 1.8V)
  alter Vctrl1 1.8
  alter Vctrl2 1.8
  ac dec 10 1k 100G
  let vout_diff2 = v(N0) - v(N4)
  let vin_diff2 = v(IFX) - v(IFY)
  let gain_mag2 = mag(vout_diff2) / mag(vin_diff2)
  let gain_db2 = 20 * log10(gain_mag2)
  meas ac min_gain MAX gain_db2
  
  print max_gain min_gain bandwidth input_resistance
  quit
.endc
.end