* Track-and-Latch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm0=2.0 L_xm0=0.15
.param W_xm1=4.0 L_xm1=0.5
.param W_xm2=4.0 L_xm2=0.5
.param W_xm3=10.0 L_xm3=0.15
.param W_xm4=10.0 L_xm4=0.15
.param W_xm5=2.0 L_xm5=0.15

XM1 VOUT_PLUS VOUT_MINUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 VOUT_MINUS VOUT_PLUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 VOUT_PLUS VIN_PLUS N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VOUT_MINUS VIN_MINUS N0 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VOUT_MINUS VCLK2 VOUT_PLUS VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM0 VOUT_MINUS VBIASN VOUT_PLUS VDD sky130_fd_pr__pfet_01v8 l={L_xm0} w={W_xm0}

* Tail current source to bias the differential pair
XM_tail N0 VBIAS_TAIL GND GND sky130_fd_pr__nfet_01v8 l=0.5 w=2.0
VBIAS_TAIL VBIAS_TAIL 0 0.8

VVDD VDD 0 1.8
VVBIASN VBIASN 0 1.8

* Sources with DC, AC, and PWL for combined OP/AC/TRAN
* Ideal voltage sources directly drive inputs to prevent asymmetric kickback noise
VVIN_PLUS VIN_PLUS 0 DC 0.9 AC 0.5 PWL(0 0.9 0.9n 0.9 1n 0.95 5n 0.95)
VVIN_MINUS VIN_MINUS 0 DC 0.9 AC -0.5 PWL(0 0.9 0.9n 0.9 1n 0.85 5n 0.85)
VVCLK2 VCLK2 0 DC 0 PWL(0 0 1.5n 0 1.52n 1.8 5n 1.8)

C1 VOUT_PLUS 0 10f
C2 VOUT_MINUS 0 10f

.control
  * 1. DC Operating Point
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  * 2. AC Analysis (Track mode)
  ac dec 100 1Meg 1000G
  let vout_diff = v(VOUT_PLUS) - v(VOUT_MINUS)
  let gain_db = db(vout_diff)
  meas ac track_gain find gain_db at=1Meg
  meas ac track_bandwidth when gain_db='track_gain - 3' fall=1
  print track_gain
  print track_bandwidth
  
  * Measure input capacitance via AC current into the gate
  let i_in_mag = mag(i(VVIN_PLUS))
  meas ac i_in_1M find i_in_mag at=1Meg
  let input_capacitance = i_in_1M / (2 * 3.1415926535 * 1e6 * 0.5)
  print input_capacitance

  * 3. Transient Analysis (Latch mode)
  tran 10p 5n
  * Measure delay from clock rising to output latching high
  meas tran latch_delay trig v(VCLK2) val=0.9 rise=1 targ v(VOUT_MINUS) val=1.5 rise=1
  print latch_delay
  
  quit
.endc
.end