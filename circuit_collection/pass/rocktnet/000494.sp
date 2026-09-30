* Class-G Line Driver Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param VDD=1.8
.param VSS=-1.8
.param VDD_IN=0.9
.param VSS_IN=-0.9

V1 +15V 0 DC {VDD}
V2 -15V 0 DC {VSS}
V3 +5V 0 DC {VDD_IN}
V4 -5V 0 DC {VSS_IN}

VVIN VIN 0 DC 0 AC 1 SIN(0 1.5 1k)

RL VOUT 0 50

* Generic models tuned for low Vbe/Vd to allow 1.8V operation
.model npn npn(is=1e-6 bf=100)
.model pnp pnp(is=1e-6 bf=100)
.model D D(is=1e-6)

* DUT (Values added to current sources and models to diodes for SPICE syntax)
I1 +15V N1 1m
D3 N1 N2 D
D4 N2 N3 D
Q6 -15V VIN N3 pnp
Q3 +15V VIN N4 npn
D1 N4 N5 D
D2 N5 N6 D
I2 N6 -15V 1m
Q1 +15V N1 N7 npn
Q2 N7 N3 VOUT npn
Q5 N8 N4 VOUT pnp
Q4 -15V N6 N8 pnp
D5 +5V N7 D
D6 N8 -5V D

.control
  * AC Analysis
  ac dec 10 10 10Meg
  let gain_db = vdb(VOUT)
  meas ac midband_gain find gain_db at=1k
  
  * Transient Analysis
  tran 10u 5m
  
  * Power and Efficiency Calculation
  let p_vcc = -i(V1) * 1.8
  let p_vee = i(V2) * 1.8
  let p_vcc_in = -i(V3) * 0.9
  let p_vee_in = i(V4) * 0.9
  let p_total = p_vcc + p_vee + p_vcc_in + p_vee_in
  meas tran p_avg avg p_total from=1m to=5m
  
  let p_load = (v(VOUT)^2) / 50
  meas tran p_load_avg avg p_load from=1m to=5m
  
  let efficiency = (p_load_avg / p_avg) * 100
  print p_avg
  print efficiency
  
  * Output Swing
  meas tran vout_max max v(VOUT) from=1m to=5m
  meas tran vout_min min v(VOUT) from=1m to=5m
  
  quit
.endc
.end