* Testbench for 4-Path Switched-Capacitor Filter

* Subcircuit Definitions for Behavioral Models
.subckt amplifier in out
E1 out 0 in 0 -10
Rfb in out 100k
.ends

.subckt switch_ideal n1 n2
R1 n1 n2 1G
.ends

* DUT (Modified syntax for ngspice compatibility: removed parentheses and changed S to X for subcircuits)
V1 VRF GND dc 0 ac 1
R2 VRF VI 50
R1 VO GND 1k
C4 VI N4 1p
C1 VI N1 1p
C2 VI N2 1p
C3 VI N3 1p
X4 N4 VO amplifier
X1 N1 VO amplifier
X2 N2 VO amplifier
X3 N3 VO amplifier
XS3 N4 VO switch_ideal
XS2 N1 VO switch_ideal
XS1 N2 VO switch_ideal
XS4 N3 VO switch_ideal

* Analyses
.control
  * AC Analysis for Gain and Bandwidth
  ac dec 100 1k 10G
  let gain_db = vdb(VO)
  
  * Measure Maximum Gain
  meas ac max_gain max gain_db
  
  * Measure -3dB Bandwidth
  let target_gain = max_gain - 3
  meas ac bw_freq when gain_db=target_gain fall=1
  
  * DC Operating Point
  op
  print v(VO)
  
  quit
.endc

.end
