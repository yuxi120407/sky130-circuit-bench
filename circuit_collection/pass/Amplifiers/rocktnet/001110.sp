* Differential Amplifier Testbench

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 N0 LABEL_NET_3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N3 N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 N3 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 LABEL_NET_4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Power supplies
VVDD VDD 0 1.8
V6 N6 0 1.8
V7 N7 0 1.8

* Bias
V3 N3 0 0.5

* Self-biasing feedback resistors to set stable DC operating point
R1 N0 LABEL_NET_3 100k
R2 N1 LABEL_NET_4 100k

* AC coupling capacitors
C1 IN_P LABEL_NET_3 10u
C2 IN_N LABEL_NET_4 10u

* Input sources (Differential 1V AC, 20mVpp Tran at 10MHz)
V_IN_P IN_P 0 DC 0 AC 0.5 SIN(0 5m 10Meg)
V_IN_N 0 IN_N DC 0 AC 0.5 SIN(0 5m 10Meg)

* Differential to single-ended converter for easy measurement
E1 out_diff 0 N1 N0 1

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.control
  * 1. DC Operating Point & Power
  op
  let power_consumption = -(i(VVDD) + i(V6) + i(V7)) * 1.8
  print power_consumption

  * 2. AC Analysis for Gain and Bandwidth
  ac dec 20 10k 10G
  meas ac voltage_gain MAX vdb(out_diff)
  let gain_3db = voltage_gain - 3
  meas ac bandwidth WHEN vdb(out_diff)="$&gain_3db" FALL=1
  print voltage_gain
  print bandwidth

  * 3. Transient Analysis for Output Swing
  tran 1n 300n
  meas tran vout_diff_max MAX v(out_diff) from=100n to=300n
  meas tran vout_diff_min MIN v(out_diff) from=100n to=300n
  let output_swing = vout_diff_max - vout_diff_min
  print output_swing
  
  quit
.endc
.end