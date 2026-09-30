* VGA Active Feedback Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_amp=0.5
.param L_bias=0.5

* Parameterized dimensions for the mapped MOSFETs
.param W_bias=10.0 L_bias=0.15
.param W_amp=20.0 L_amp=0.15

* Supply and Bias Sources
VVDD VDD 0 1.8
VVR Vr 0 1.2
* Input signal at Vg (DC bias + AC + Transient two-tone at 900MHz and 910MHz)
VVG Vg Vg_ac dc 1.2 ac 1
VAC1 Vg_ac Vg_ac2 sin(0 0.01 900Meg)
VAC2 Vg_ac2 0 sin(0 0.01 910Meg)

* Current sources from original netlist
I15 VDD A 2m
I12 N3 0 1m

* Passive components
R4 Vr N1 1k
R5 Vg N3 50
R6 N5 0 1k

* DUT: Original NPNs mapped to SKY130 NMOS (D G S B)
XM18 N1 N1 0 0 sky130_fd_pr__nfet_01v8 W={W_bias} L={L_bias}
XM19 N2 N1 0 0 sky130_fd_pr__nfet_01v8 W={W_bias} L={L_bias}
XM11 VDD N3 N2 0 sky130_fd_pr__nfet_01v8 W={W_amp} L={L_amp}
XM16 N4 N2 0 0 sky130_fd_pr__nfet_01v8 W={W_amp} L={L_amp}
XM15 A A N4 0 sky130_fd_pr__nfet_01v8 W={W_amp} L={L_amp}
XM13 A N4 N5 0 sky130_fd_pr__nfet_01v8 W={W_amp} L={L_amp}
XM20 N5 N1 0 0 sky130_fd_pr__nfet_01v8 W={W_bias} L={L_bias}
XM14 N6 N5 0 0 sky130_fd_pr__nfet_01v8 W={W_amp} L={L_amp}
XM17 VDD A N6 0 sky130_fd_pr__nfet_01v8 W={W_amp} L={L_amp}
XM12 VDD A N3 0 sky130_fd_pr__nfet_01v8 W={W_bias} L={L_bias}

.control
  * 1. DC Operating Point & Power
  op
  let power_consumption = -(i(VVDD)*1.8 + i(VVR)*1.2 + i(VVG)*1.2)
  print power_consumption

  * 2. AC Analysis for Gain and Bandwidth
  ac dec 50 1Meg 100Gig
  let gain_db = vdb(N6)
  
  let max_gain = 0
  meas ac max_gain max gain_db
  
  let gain_900MHz = 0
  meas ac gain_900MHz find gain_db at=900Meg
  
  let bandwidth_3dB = 0
  let gain_3db = max_gain - 3
  meas ac bandwidth_3dB when gain_db="$&gain_3db" fall=1
  
  print max_gain gain_900MHz bandwidth_3dB

  * 3. Transient Analysis for Output Swing and OIP3
  * Run longer and save only the steady-state portion to avoid startup transients
  tran 6.103515625p 399.993896484375n 200n
  
  let vout_max = 0
  let vout_min = 0
  meas tran vout_max max v(N6)
  meas tran vout_min min v(N6)
  let output_swing_pp = vout_max - vout_min
  print output_swing_pp

  linearize v(N6)
  set specwindow=rectangular
  fft v(N6)
  let v_n6_mag = mag(v(N6))
  
  let fund_mag = 0
  let im3_mag = 0
  meas sp fund_mag max v_n6_mag from=899Meg to=901Meg
  meas sp im3_mag max v_n6_mag from=889Meg to=891Meg
  
  let fund_mag_safe = fund_mag + 1e-20
  let im3_mag_safe = im3_mag + 1e-20
  let fund_dbm = 10 * log10((fund_mag_safe * fund_mag_safe) / 100) + 30
  let im3_dbm = 10 * log10((im3_mag_safe * im3_mag_safe) / 100) + 30
  let OIP3 = fund_dbm + (fund_dbm - im3_dbm) / 2
  print OIP3
  
  quit
.endc
.end