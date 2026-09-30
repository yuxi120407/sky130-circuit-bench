* Testbench for Adaptive ENG Amplifier Current Rectifier

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

* Parameters
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm3=5.0 L_xm3=0.5

* DUT
XM1 IO GND II1 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 GND II1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM4 N0 GND II2 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM8 IO N0 VSS GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM6 IO N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 N0 VSS GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM3 IO GND II2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

* Sources
VVDD VDD 0 1.8
VVSS VSS 0 0
VGND GND 0 0

* Output bias (mid-supply to keep output mirrors in saturation)
VIO IO 0 0.9

* Input sources (Currents in nA range for weak inversion operation)
IIN1 0 II1 DC 0 AC 0 SIN(0 50n 1k)
IIN2 0 II2 DC 0 AC 0

.control
  * 1. DC Sweep IIN1 (Transfer characteristic for II1)
  dc IIN1 -100n 100n 1n
  let iout1 = i(VIO)
  meas dc iout_p50 find iout1 at=50n
  meas dc iout_p40 find iout1 at=40n
  let gain1_p = (iout_p50 - iout_p40) / 10n
  meas dc iout_m50 find iout1 at=-50n
  meas dc iout_m40 find iout1 at=-40n
  let gain1_m = (iout_m50 - iout_m40) / -10n
  print gain1_p gain1_m

  * 2. DC Sweep IIN2 (Transfer characteristic for II2)
  dc IIN2 -100n 100n 1n
  let iout2 = i(VIO)
  meas dc iout2_p50 find iout2 at=50n
  meas dc iout2_p40 find iout2 at=40n
  let gain2_p = (iout2_p50 - iout2_p40) / 10n
  meas dc iout2_m50 find iout2 at=-50n
  meas dc iout2_m40 find iout2 at=-40n
  let gain2_m = (iout2_m50 - iout2_m40) / -10n
  print gain2_p gain2_m

  * 3. AC Analysis (Bandwidth)
  alter IIN1 DC = 50n
  alter IIN1 AC = 1n
  ac dec 10 1 100Meg
  let iout_ac = i(VIO)
  let gain_ac_db = 20 * log10(mag(iout_ac) / 1n)
  meas ac bw_3db when gain_ac_db=-3 fall=1
  print bw_3db

  * 4. Transient Analysis (Full-wave rectification)
  alter IIN1 DC = 0
  tran 10u 5m
  let iout_tran = i(VIO)
  meas tran iout_avg avg iout_tran from=1m to=5m
  print iout_avg

  quit
.endc
.end
