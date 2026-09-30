* 9.8GHz UWB Transceiver Block Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param C1_val=1p
.param C5_val=1p
.param L_n=0.5

* Parameterized values for ~9.8GHz resonance and device sizing
.param L1_val=1n C1_val=100f L2_val=1n L3_val=1n C5_val=100f
.param W_n=10.0 L_n=0.15

* Wrapper to map NPN from BiCMOS netlist to SKY130 NMOS
.subckt npn c b e
M1 c b e GND sky130_fd_pr__nfet_01v8 w={W_n} l={L_n}
.ends

* --- DUT ---
L1 B1 LABEL_NET_0 L1_val
Q1 N4 B2 B2 npn
Q2 N3 VDD N4 npn
Q3 N0 B1 GND npn
C1 N0 B2 {C1_val}
L2 N0 B2 L2_val
L3 VDD N3 L3_val
C2 B2 B2 1p
C_BIG N0 N0 1p
C4 B1 B1 1p
C5 N3 GND {C5_val}
* -----------

* Sources
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9 AC 1 SIN(0.9 0.01 9.8G)

* Load
Rload N3 0 50

.control
  * 1. DC Operating Point & Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. AC Analysis for Gain at 9.8GHz
  ac dec 50 1G 20G
  let gain_db = vdb(N3)
  meas ac gain_at_9p8G find gain_db at=9.8G
  meas ac max_gain max gain_db

  * 3. Transient Analysis for Output Swing
  tran 2p 1n
  meas tran v_max max v(N3)
  meas tran v_min min v(N3)
  let v_pp = v_max - v_min
  print v_pp

  quit
.endc
.end