* Gm-C Low-Pass Filter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param Gm_val=10.3u
.param C_val=10p

* Behavioral model for the transconductance amplifier
.subckt amplifier in+ in- out
* Note: Current flows from 0 to out, so current entering 'out' is Gm*(V(in+) - V(in-))
G1 0 out in+ in- Gm_val
R1 out 0 100MEG
.ends

* DUT (Modified to use X instead of A and added capacitor values)
X1 VIN+ N1 N1 amplifier
X2 VIN+ N2 N1 amplifier
X3 N1 VOUT+ N2 amplifier
X4 N2 VOUT+ VOUT+ amplifier
X5 VIN- N3 N3 amplifier
X6 N4 VOUT- VOUT- amplifier
X7 N3 VOUT- N4 amplifier
X8 VIN- N4 N3 amplifier
C1 N1 0 {C_val}
C2 N2 0 {C_val}
C3 VOUT+ 0 {C_val}
C4 N3 0 {C_val}
C5 N4 0 {C_val}
C6 VOUT- 0 {C_val}

* Sources
VDD VDD 0 DC 1.8
VVINp VIN+ 0 DC 0.9 AC 0.5 SIN(0.9 0.1 10k 0 0)
VVINn VIN- 0 DC 0.9 AC -0.5 SIN(0.9 -0.1 10k 0 0)

* Differential Output
E_diff VOUT_DIFF 0 VOUT+ VOUT- 1.0

.control
  op
  print v(VOUT+) v(VOUT-)
  
  ac dec 100 1k 10MEG
  let gain_db = vdb(VOUT_DIFF)
  meas ac dc_gain find gain_db at=1k
  let gain_db_norm = gain_db - dc_gain
  meas ac f3db when gain_db_norm=-3 fall=1
  meas ac atten_1M find gain_db_norm at=1MEG
  
  tran 1u 500u
  meas tran vmax max v(VOUT_DIFF)
  meas tran vmin min v(VOUT_DIFF)
  let vpp = vmax - vmin
  print vpp
  
  quit
.endc
.end
