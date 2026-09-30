* Testbench for Differential Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5

XM4 OUT_PLUS OUT_MINUS VSS GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 VBIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM3 OUT_MINUS OUT_PLUS VSS GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM2 N1 IN_MINUS OUT_PLUS GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM1 N1 IN_PLUS OUT_MINUS GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

VVDD VDD 0 1.8
VVSS VSS 0 0
VGND GND 0 0
VVBIAS VBIAS 0 0.99

* Differential AC and Transient inputs
VIN_PLUS IN_PLUS 0 DC 0.9 AC 1 SIN(0.9 0.1 1MEG 0 0 0)
VIN_MINUS IN_MINUS 0 DC 0.9 AC -1 SIN(0.9 0.1 1MEG 0 0 180)

.control
  op
  let power = -i(VVDD) * 1.8
  print power

  ac dec 100 1 10G
  let vout_diff = v(OUT_PLUS) - v(OUT_MINUS)
  let vin_diff = v(IN_PLUS) - v(IN_MINUS)
  let gain_mag = mag(vout_diff / vin_diff)
  let gain_db = 20 * log10(gain_mag)
  
  meas ac dc_gain_db find gain_db at=10
  meas ac bw_3db when gain_db=(dc_gain_db - 3) fall=1
  
  tran 1n 5u
  let vout_diff_tran = v(OUT_PLUS) - v(OUT_MINUS)
  meas tran vout_max max vout_diff_tran
  meas tran vout_min min vout_diff_tran
  
  quit
.endc
.end