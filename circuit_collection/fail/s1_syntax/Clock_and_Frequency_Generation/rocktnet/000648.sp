* VCO Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param AREA_Q=1

* Generic NPN model for simulation
.model npn npn (is=1e-16 bf=100 vaf=50 cjc=0.1p cje=0.2p tf=10p)

* DUT (Values appended to raw netlist to allow simulation)
Q1 n2 n0 n1 npn AREA_Q
R1 n2 n4 50
C1 n1 n3 1p
C2 n0 n1 1p
C3 n3 n7 1p
R2 n1 n3 1k
R3 n0 n4 10k
R4 n0 n3 10k
C4 n5 n6 1p
R5 n7 n7 1
R6 n3 n6 10k
R7 n2 label_net_0 50
Q2 n7 n6 n6 npn AREA_Q
R8 n0 n5 1k

* Power and Bias Sources
V_n4 n4 0 1.8
V_n3 n3 0 0
VLABEL_NET_0 label_net_0 0 0.9

.control
  * DC Operating Point
  op
  let dc_power = -i(V_n4) * 1.8
  print dc_power
  print v(n2) v(n0) v(n1)

  * Transient Analysis
  tran 10p 10n
  meas tran v_max max v(n2)
  meas tran v_min min v(n2)
  meas tran period trig v(n2) val=0.9 rise=1 targ v(n2) val=0.9 rise=2
  
  quit
.endc
.end