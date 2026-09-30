* Differential Pair Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

* DUT
XM1 VOUT_N LABEL_NET_2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VOUT_P N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}

* Biasing and Loads
VVDD VDD 0 1.8
RL1 VDD VOUT_N 1k
RL2 VDD VOUT_P 1k
ISS N1 0 2m

* Input Signals (Common mode = 0.9V)
VVIN_P N0 0 DC 0.9 AC 0.5 0 SIN(0.9 0.1 100MEG 0 0)
VVIN_N LABEL_NET_2 0 DC 0.9 AC 0.5 180 SIN(0.9 -0.1 100MEG 0 0)

* VCVS to calculate differential output for AC analysis
E1 VOUT_DIFF 0 VOUT_P VOUT_N 1.0

.control
  * DC Operating Point
  op
  let power = -i(VVDD) * 1.8
  print power

  * AC Analysis
  ac dec 100 1MEG 100G
  let gain_db = vdb(VOUT_DIFF)
  meas ac dc_gain find gain_db at=1MEG
  let gain_db_3db = dc_gain - 3
  meas ac bw when gain_db=$&gain_db_3db fall=1

  * Transient Analysis
  tran 10p 20n
  meas tran vout_p_max max v(VOUT_P)
  meas tran vout_p_min min v(VOUT_P)
  let vout_p_swing = vout_p_max - vout_p_min
  print vout_p_swing
  
  quit
.endc
.end