* Wideband LNA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Generic models for missing PDK specific NPN/Diodes
.model npn npn (bf=100 is=1e-15 tf=5p cje=50f cjc=50f)
.model diode d (is=1e-15 rs=10)

* DUT (with appended component values for simulation)
Q1 n6 n9 n3 npn
Q2 n9 n1 n10 npn
Q3 n4 n3 n8 npn
R1 n0 n8 5
R2 n2 n3 1k
R3 n7 n9 200
R4 n4 n5 100
R5 n0 n10 5
R6 n1 n3 300
D1 n7 n6 diode
C1 n0 n10 10p
C2 n7 0 10p
D2 n7 n5 diode
D3 n2 0 diode

* Bias and Supply
Vdd n7 0 1.8
Vss n0 0 0
Rbias n7 n2 2k

* RF Input
Vac in_ac 0 DC 0 AC 1
Rs in_ac n1_ac 50
Cin n1_ac n1 10p

* RF Output
Cout n4 out_ac 10p
Rl out_ac 0 50

.control
  * DC Operating Point
  op
  let dc_power = -i(Vdd)*1.8
  print dc_power

  * AC Analysis
  ac dec 20 10Meg 100Gig
  let gain_db = vdb(out_ac)
  meas ac ac_gain max gain_db
  meas ac bandwidth when gain_db=0 fall=1
  print ac_gain bandwidth

  * Noise Analysis
  noise v(out_ac) Vac dec 20 10Meg 100Gig
  setplot noise1
  let thermal_noise = 4 * 1.3806226e-23 * 300.15 * 50
  let nf_vec = 10 * log10(inoise_spectrum / thermal_noise)
  meas noise noise_figure min nf_vec
  print noise_figure
.endc
.end