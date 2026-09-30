* Testbench for Variation-Tolerant Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 OUT IN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N0 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 OUT N0 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 IN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

VVDD VDD 0 1.8
VVSS VSS 0 0
VIN IN 0 DC 0.9 AC 1 SIN(0.9 0.1 10 0 0)

.control
  * 1. DC Operating Point & Power
  op
  let power = -i(VVDD) * 1.8
  print power
  print v(OUT)

  * 2. DC Sweep for Transfer Curve and Trip Point
  dc VIN 0 1.8 0.01
  let vdiff = v(OUT) - v(IN)
  meas dc trip_point when vdiff=0
  meas dc dc_gain_v deriv v(OUT) at=0.9

  * 3. AC Analysis for Gain
  ac dec 10 1 1G
  let gain_db = vdb(OUT)
  meas ac low_freq_gain_db find gain_db at=10

  * 4. Transient Analysis
  tran 1m 0.5
  meas tran vout_max max v(OUT)
  meas tran vout_min min v(OUT)
  meas tran vout_pk2pk param='vout_max - vout_min'
  
  quit
.endc
.end