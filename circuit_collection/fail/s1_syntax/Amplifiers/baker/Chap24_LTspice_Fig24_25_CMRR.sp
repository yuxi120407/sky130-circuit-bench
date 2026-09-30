* Op-Amp Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.subckt opamp vinp vinn vout vdd vss
Iref vdd nbias_n 10u
M1 nbias_n nbias_n vss vss sky130_fd_pr__nfet_01v8 w=10.0 l=1.0
M2 nbias_p nbias_n vss vss sky130_fd_pr__nfet_01v8 w=10.0 l=1.0
M3 nbias_p nbias_p vdd vdd sky130_fd_pr__pfet_01v8 w=20.0 l=1.0
M4 ntail nbias_p vdd vdd sky130_fd_pr__pfet_01v8 w=40.0 l=1.0
M5 nd1 vinn ntail vdd sky130_fd_pr__pfet_01v8 w=40.0 l=1.0
M6 nd2 vinp ntail vdd sky130_fd_pr__pfet_01v8 w=40.0 l=1.0
M7 nd1 nd1 vss vss sky130_fd_pr__nfet_01v8 w=10.0 l=1.0
M8 nd2 nd1 vss vss sky130_fd_pr__nfet_01v8 w=10.0 l=1.0
M9 vout nd2 vss vss sky130_fd_pr__nfet_01v8 w=50.0 l=1.0
M10 vout nbias_p vdd vdd sky130_fd_pr__pfet_01v8 w=100.0 l=1.0
Cc nd2 nrc 2.4p
Rz nrc vout 6.5k
.ends

* Global supplies
Vdd vdd 0 1.8
Vss vss 0 0

* 1. Open-loop gain, Phase Margin, Unity Gain Frequency
X1 vinp1 vinn1 vout1 vdd vss opamp
Vcm1 vcm1 0 0.9
Vac1 vinp1 vcm1 dc 0 ac 1
E1 vinn1 0 vout1 0 1
* Use a large inductor and capacitor to close the loop at DC but open at AC
L1 vout1 vinn1 1G
C1 vinn1 0 1G

* 2. PSRR+
X2 vinp2 vinn2 vout2 vdd2 vss opamp
Vdd2 vdd2 0 dc 1.8 ac 1
Vcm2 vcm2 0 0.9
Vinp2 vinp2 vcm2 dc 0 ac 0
L2 vout2 vinn2 1G
C2 vinn2 0 1G

* 3. CMRR
X3 vinp3 vinn3 vout3 vdd vss opamp
Vcm3 vcm3 0 dc 0.9 ac 1
Vinp3 vinp3 vcm3 dc 0 ac 0
L3 vout3 vinn3 1G
C3 vinn3 vcm3 1G

* 4. Slew Rate
X4 vinp4 vout4 vout4 vdd vss opamp
Vpulse vinp4 0 pulse(0.6 1.2 10n 100p 100p 1u 2u)
Cload vout4 0 1p

.control
  * AC Analysis for AC metrics
  ac dec 100 1 1G
  
  * Unity Gain Frequency and Phase Margin
  meas ac unity_gain_frequency when vdb(vout1)=0
  meas ac phase_rad find vp(vout1) when vdb(vout1)=0
  let phase_margin = phase_rad * 180 / 3.14159265359 + 180
  print phase_margin
  
  * Gain Margin
  meas ac freq_at_180 when vp(vout1)=-3.14159265359
  meas ac gain_at_180 find vdb(vout1) when vp(vout1)=-3.14159265359
  let gain_margin = -gain_at_180
  print gain_margin
  
  * PSRR+
  let psrr_plus_vec = db(v(vout1)) - db(v(vout2))
  meas ac psrr_plus find psrr_plus_vec at=1
  print psrr_plus
  
  * CMRR
  let cmrr_vec = db(v(vout1)) - db(v(vout3))
  meas ac cmrr find cmrr_vec at=1
  print cmrr
  
  * Transient Analysis for Slew Rate
  tran 1n 2u
  meas tran t1 when v(vout4)=0.8 rise=1
  meas tran t2 when v(vout4)=1.0 rise=1
  let slew_rate = (1.0 - 0.8) / (t2 - t1) / 1e6
  print slew_rate
.endc
.end