* Testbench for 3-stage differential amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.15
.param L_xm2=0.15
.param L_xm3=0.15
.param L_xm4=0.15
.param L_xm5=0.15
.param L_xm6=0.15
.param L_xm7=0.15
.param L_xm8=0.15
.param L_xm9=0.15

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm9=5.0

XM1 N8 VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N12 VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N1 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 VBIAS GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 INP N2 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 OUTP N4 N12 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 OUTN N0 N12 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N4 N10 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N10 INN N2 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}

* Load resistors
R1 VDD N1 20k
R2 VDD N10 20k
R3 VDD N0 20k
R4 VDD N4 20k
R5 VDD OUTP 20k
R6 VDD OUTN 20k

VVDD VDD 0 1.8
VVBIAS VBIAS 0 0.75
VINP INP 0 DC 1.38 AC 0.5 SIN(1.38 0.05 100MEG 0 0)
VINN INN 0 DC 1.38 AC -0.5 SIN(1.38 -0.05 100MEG 0 0)

.control
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  ac dec 20 1MEG 100G
  let vdiff = v(OUTP) - v(OUTN)
  let gain_mag = mag(vdiff)
  let gain_db = 20 * log10(gain_mag)
  
  meas ac differential_gain find gain_db at=1MEG
  let gain_3db = differential_gain - 3
  meas ac bandwidth_3db when gain_db=gain_3db fall=1

  tran 0.1n 50n
  meas tran vout_p_max max v(OUTP) from=20n to=50n
  meas tran vout_p_min min v(OUTP) from=20n to=50n
  let output_swing = vout_p_max - vout_p_min
  print output_swing
  
  quit
.endc
.end