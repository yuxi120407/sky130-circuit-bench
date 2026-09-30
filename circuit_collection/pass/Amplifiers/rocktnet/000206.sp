* VGA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* DUT
I1 VDD RFi 1m
R3 RFo N4 500
R2 VDD N0 500
R1 N5 GND 600
X5 RFo Vbias N1 GND sky130_fd_pr__nfet_01v8 w=50.0 l=0.15
X2 N0 RFi N5 GND sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
X1 RFi RFi N5 GND sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
X3 N1 N5 GND GND sky130_fd_pr__nfet_01v8 w=50.0 l=0.15
C1 N4 GND 10p
C2 N0 GND 10p

* Fix floating N4 (AC ground in original, needs DC path)
V_N4 N4 0 1.8

* Sources
VVDD VDD 0 1.8
VVBIAS Vbias 0 1.2

* AC Input
Cin RFin RFi 10p
Vac RFin 0 dc 0 ac 1 sin(0 10m 900Meg)

.control
  op
  let power_consumption = -i(VVDD) * 1.8 - i(V_N4) * 1.8
  print power_consumption

  let operating_frequency = 900Meg
  print operating_frequency

  ac dec 50 10Meg 10Gig
  let vout_db = db(v(RFo))
  meas ac voltage_gain FIND vout_db AT=900Meg
  print voltage_gain

  alter I1 10u
  ac dec 50 10Meg 10Gig
  let vout_db = db(v(RFo))
  meas ac min_gain FIND vout_db AT=900Meg

  let gain_control_range = ac1.voltage_gain - min_gain
  print gain_control_range
.endc
.end