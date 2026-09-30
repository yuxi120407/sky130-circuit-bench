* VSWR-Protected Silicon Bipolar RF Power Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Generic NPN model (used since standard SKY130 NPNs require specific subcircuit calls)
.model npn npn (bf=100 is=1e-16)

* DUT (Resistor values appended to make valid SPICE)
R1 N1 LABEL_NET_0 1k
R2 N3 LABEL_NET_1 1k
R3 RFout N3 1k
R4 N1 N3 1k
Q1 RFout RFin GND npn
Q2 RFout LABEL_NET_1 N1 npn
Q3 N1 LABEL_NET_0 RFin npn

* Biasing and Supply
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9

* RF Choke and Load
Lchoke VDD RFout 100n
Cblock RFout OUT 10p
Rload OUT 0 50

* Input Signal
Vbias RFin_bias 0 0.85
Lbias RFin_bias RFin 100n
Cblock_in IN RFin 10p
Vin IN 0 dc 0 ac 1 sin(0 0.5 1.8G)

.control
  * DC Operating Point
  op
  let dc_pwr = -i(VVDD) * 1.8
  print dc_pwr

  * AC Analysis for Gain
  ac dec 20 100M 10G
  let gain = vdb(out) - vdb(in)
  meas ac gain_18g find gain at=1.8G

  * Transient Analysis for Power and Efficiency
  tran 10p 10n
  meas tran vout_pk max v(out) from=5n to=10n
  meas tran vout_min min v(out) from=5n to=10n
  let vout_amp = (vout_pk - vout_min) / 2
  let pout_w = (vout_amp * vout_amp) / (2 * 50)
  let pout_dbm = 10 * log10(pout_w * 1000)
  print pout_dbm

  meas tran idc_avg avg i(VVDD) from=5n to=10n
  let pdc = -idc_avg * 1.8
  let eff = (pout_w / pdc) * 100
  print eff
  
  quit
.endc
.end