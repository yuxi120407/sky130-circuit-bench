* MGTR LNA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.options reltol=1e-5 method=gear

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 LOAD N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 LOAD N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N3 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

VVDD VDD 0 1.8
Ibias1 VDD N1 100u
Ibias2 VDD N3 20u
Rbias1 N1 N4 10k
Rbias2 N3 N0 10k
Cin1 IN N4 10p
Cin2 IN N0 10p
L1 VDD LOAD 10n
C1 LOAD 0 3.1p
R1 VDD LOAD 2k

Vin1 IN IN2 dc 0 ac 1 sin(0 30m 900MEG)
Vin2 IN2 0 dc 0 sin(0 30m 910MEG)

.control
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  ac dec 100 100MEG 5G
  let gain_db = db(v(LOAD))
  meas ac voltage_gain max gain_db
  print voltage_gain
  
  let gain_3db = $&voltage_gain - 3
  meas ac f1 when gain_db=$&gain_3db rise=1
  meas ac f2 when gain_db=$&gain_3db fall=1
  let center_frequency = ($&f1 + $&f2) / 2
  print center_frequency
  
  tran 10p 500n 100n
  linearize v(LOAD)
  fft v(LOAD)
  let mag_v = mag(v(LOAD))
  meas sp fund_mag MAX mag_v from=899MEG to=901MEG
  meas sp im3_mag MAX mag_v from=889MEG to=891MEG
  
  let iip3_v2 = (30e-3 * 30e-3) * ($&fund_mag / $&im3_mag)
  let iip3 = 10 * log10(iip3_v2 * 10)
  print iip3
  
  quit
.endc
.end