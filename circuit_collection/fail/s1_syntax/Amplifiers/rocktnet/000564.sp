* Intelligent Power Amplifier MMIC Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Modified DUT (HBT -> X for subcircuit mapping, added Vshort for N6-N7)
X3 N5 N10 N9 npn_bias
X4 Vreg N5 N1 npn_bias
X1 N7 N1 GND npn_pa
RFC N7 VCC 1m
X2 N3 N4 GND npn_bias
Rb N1 N4 1k
R3 N3 N10 1k
R2 Vreg N3 10k
R1 Vreg N5 10k
R4 N9 GND 100
C1 N2 RFout 10p
C2 N1 RFin 10p
Cb N5 GND 10p
C4 N2 GND 100f
Cbypass N3 GND 10p
L1 RFin GND 10n
R7 N2 N6 0
Vshort N6 N7 0

* Subcircuits mapping NPN to SKY130 NMOS
.subckt npn_bias c b e
XM1 c b e e sky130_fd_pr__nfet_01v8 w=50.0 l=0.15
.ends

.subckt npn_pa c b e
XM1 c b e e sky130_fd_pr__nfet_01v8 w=2000.0 l=0.15
.ends

* Supplies
VCC VCC 0 dc 1.8
Vreg Vreg 0 dc 1.8

* Input Source (1.9 GHz for W-CDMA)
Vac RFin 0 dc 0 ac 1 sin(0 0.5 1.9G)

* Load
Rload RFout 0 50

.control
  * 1. DC Analysis (Low Power Quiescent State)
  op
  let Iq_static = -i(VCC)
  print Iq_static
  let V_bias_static = v(N1)
  print V_bias_static

  * 2. AC Analysis (Small-Signal Gain)
  ac dec 10 100Meg 10G
  let gain_db = vdb(RFout)
  meas ac gain_19g find gain_db at=1.9G

  * 3. Transient Analysis (High Power Dynamic State)
  * Run for 300ns to allow the 100ns bias time constant to settle
  tran 10p 300n
  
  * Measure Output Power
  meas tran vout_max max v(RFout) from=250n to=300n
  meas tran vout_min min v(RFout) from=250n to=300n
  let vout_amp = (vout_max - vout_min) / 2
  let Pout_W = (vout_amp * vout_amp) / (2 * 50)
  let Pout_dBm = 10 * log10(Pout_W * 1000)
  print Pout_dBm

  * Measure Dynamic Bias Current
  meas tran Iq_dynamic avg i(VCC) from=250n to=300n
  let Iq_dyn_mA = -Iq_dynamic * 1000
  print Iq_dyn_mA

  * Measure Efficiency (Drain Efficiency ~ PAE for high gain)
  let Pdc = -Iq_dynamic * 1.8
  let PAE = (Pout_W) / Pdc * 100
  print PAE
  
  quit
.endc
.end