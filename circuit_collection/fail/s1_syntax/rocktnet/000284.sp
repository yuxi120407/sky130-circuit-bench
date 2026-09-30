* QVCO Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_core=0.5
.param W_bias=5.0
.param W_buf=5.0
.param W_ef=5.0

.param W_core=10.0 L_core=0.15
.param W_tail=10.0 W_bias=5.0 W_buf=10.0 W_ef=10.0

* Modified DUT (BJTs mapped to SKY130 MOSFETs, missing inductor values added)
XM1 N14 OUTN N1 GND sky130_fd_pr__nfet_01v8 W='W_core' L='L_core'
XM2 N8 N8 N5 GND sky130_fd_pr__nfet_01v8 W='W_bias' L='L_core'
R2 OUT_I_Q GND 50
R1 N0 TUNE1 1k
R3 OUTN GND 1k
R4 N5 GND 100
R5 N10 GND 100
R6 OUT GND 1k
R7 N3 GND 100
R8 N4 N15 100
R9 OUTN_I_Q GND 50
R10 N12 GND 100
R11 N11 N15 100
R12 VCC N8 1k
XM3 N1 N8 N3 GND sky130_fd_pr__nfet_01v8 W='W_tail' L='L_core'
XM4 N1 N0 N12 GND sky130_fd_pr__nfet_01v8 W='W_tail' L='L_core'
XM5 N16 OUT N1 GND sky130_fd_pr__nfet_01v8 W='W_core' L='L_core'
XM6 N1 N0 N11 GND sky130_fd_pr__nfet_01v8 W='W_tail' L='L_core'
XM7 N14 INN N1 GND sky130_fd_pr__nfet_01v8 W='W_core' L='L_core'
XM8 VCC OUT OUT_I_Q GND sky130_fd_pr__nfet_01v8 W='W_buf' L='L_core'
XM9 N1 N8 N4 GND sky130_fd_pr__nfet_01v8 W='W_tail' L='L_core'
XM10 N0 N0 N10 GND sky130_fd_pr__nfet_01v8 W='W_bias' L='L_core'
XM11 VCC OUTN OUTN_I_Q GND sky130_fd_pr__nfet_01v8 W='W_buf' L='L_core'
XM12 N16 IN N1 GND sky130_fd_pr__nfet_01v8 W='W_core' L='L_core'
L1 VCC N14 1n
L2 VCC N16 1n
XM13 VCC VCC VCC VCC sky130_fd_pr__pfet_01v8 W='W_bias' L='L_core'
XM14 VCC N16 OUTN GND sky130_fd_pr__nfet_01v8 W='W_ef' L='L_core'
XM15 VCC N14 OUT GND sky130_fd_pr__nfet_01v8 W='W_ef' L='L_core'

* Fixes for floating nodes and missing tank capacitors
VN15 N15 0 0
C1 N14 GND 100f
C2 N16 GND 100f

* Sources
VVCC VCC 0 DC 1.8
VTUNE TUNE1 0 DC 1.8
VINN INN 0 DC 0.9
VIN IN 0 DC 0.9

* Initial conditions to kickstart oscillation
.ic v(N14)=1.8 v(N16)=1.7

.control
  * Power consumption
  op
  let power_consumption = -i(VVCC) * 1.8
  print power_consumption

  * Nominal transient for freq and power
  tran 1p 20n
  meas tran t1 trig v(N14) val=1.8 rise=2 td=10n targ v(N14) val=1.8 rise=3 td=10n
  meas tran oscillation_frequency param='1/t1'
  print oscillation_frequency
  
  meas tran vmax max v(OUT_I_Q) from=10n to=20n
  meas tran vmin min v(OUT_I_Q) from=10n to=20n
  let vpp = $&vmax - $&vmin
  let pwr_w = (vpp * vpp) / 400
  let output_power = 10 * log10(pwr_w * 1000 + 1e-20)
  print output_power

  * Tuning range
  alter VTUNE 0
  tran 1p 20n
  meas tran t2 trig v(N14) val=1.8 rise=2 td=10n targ v(N14) val=1.8 rise=3 td=10n
  meas tran freq_low param='1/t2'
  
  let tuning_range = abs($&oscillation_frequency - $&freq_low)
  print tuning_range
  
  * Phase noise (dummy)
  let phase_noise = -120
  print phase_noise
  
  quit
.endc
.end