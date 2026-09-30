* VCO Replica Bias Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Parameters
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5

* DUT
XM1 BP BP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N1 BP VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 BN GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 BN BN GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 BN N1 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N4 BP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 BP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 N1 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 V2I V2I GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N1 V2I GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 BN N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}

* Sources
VVDD VDD 0 dc 1.8 ac 1
VV2I V2I 0 dc 0.5 ac 0 pulse(0.45 0.55 1n 100p 100p 50n 100n)

.control
  * 1. DC Operating Point
  op
  let power = -i(VVDD) * 1.8
  let v_bp = v(BP)
  print power v_bp

  * 2. DC Sweep for Gain
  dc VV2I 0.45 0.55 0.01
  let gain = deriv(v(BP))
  meas dc gain_at_05 find gain at=0.5

  * 3. AC Analysis for PSRR
  ac dec 10 1k 1G
  let vsg_ac_mag = mag(v(VDD) - v(BP))
  let psrr_db = 20 * log10(vsg_ac_mag)
  meas ac psrr_1mhz find psrr_db at=1Meg

  * 4. Transient Analysis
  tran 100p 100n
  meas tran bp_min min v(BP)
  meas tran bp_max max v(BP)
.endc
.end