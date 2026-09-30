* 24GHz Differential Cascode LNA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param C_val=1p
.param L_base=0.5
.param L_deg=0.5

.param L_load=0.001 L_deg=100p L_base=500p C_val=100f R_bias=10k

* DUT
L1 n5 GND {L_deg}
L2 VDD n6 {L_load}
L3 VDD n1 {L_load}
L4 n3 GND {L_deg}
L5 n4 n9 {L_base}
L6 n2 n10 {L_base}
R1 n2 label_net_0 {R_bias}
R2 n4 label_net_1 {R_bias}
C1 n8 GND {C_val}
Q1 n7 n9 n5 npn
Q2 n1 VDD n0 npn
C2 n4 GND {C_val}
C3 VDD GND 1p
Q3 n6 VDD n7 npn
Q4 n0 n10 n3 npn
C4 n1 n4 {C_val}
C5 n6 n8 {C_val}

* Generic NPN model since SKY130 doesn't have a default 'npn'
.model npn npn (bf=100 is=1e-15 cjc=10f cje=10f)

* Biasing and Supply
VVDD VDD 0 1.8
VLABEL_NET_0 label_net_0 0 0.9
VLABEL_NET_1 label_net_1 0 0.9

* AC and Transient Inputs
Cin_p in_p n4 1p
Cin_n in_n n2 1p
Vin_p in_p 0 dc 0 ac 1 sin(0 10m 24G)
Vin_n in_n 0 dc 0 ac -1 sin(0 -10m 24G)

.control
  * DC Operating Point
  op
  let power = -i(VVDD) * 1.8
  print power

  * AC Analysis
  ac dec 100 1G 100G
  let vout_diff = v(n6) - v(n1)
  let gain_db = 20*log10(mag(vout_diff)/2)
  meas ac gain_24G find gain_db at=24G
  meas ac max_gain max gain_db

  * Transient Analysis
  tran 1p 200p
  meas tran vout_max max v(n6)
  meas tran vout_min min v(n6)
  let vpp = vout_max - vout_min
  print vpp
  
  quit
.endc
.end