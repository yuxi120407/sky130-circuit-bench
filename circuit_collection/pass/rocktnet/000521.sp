* Highly Linear Transconductor Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5

* Power and Bias
VDD VDD 0 DC 1.8
VGM VGM 0 DC 0.7

* Input signals (DC=0.9V, AC=1V diff, Tran=200mVpp diff at 1MHz)
VVIN_P VIN_P 0 DC 0.9 AC 0.5 SIN(0.9 0.05 1MEG 0 0)
VVIN_N VIN_N 0 DC 0.9 AC -0.5 SIN(0.9 -0.05 1MEG 0 0)

* Load resistors to measure output current (1 ohm)
* V(IM6) - V(IM5) will be exactly equal to I(IM5) - I(IM6)
R_IM5 VDD IM5 1
R_IM6 VDD IM6 1

* VCVS to output differential current as a voltage (1V = 1A)
E_diff out_diff 0 IM6 IM5 1

* DUT
XM1 N1 VIN_P X X sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 VIN_N X X sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 VIN_P X X sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 VIN_N X X sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 IM5 VIN_P N1 N1 sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 IM6 VIN_N N2 N2 sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 X VGM GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}

.control
  * 1. DC Operating Point & Power
  op
  let power = -i(VDD) * 1.8
  print power

  * 2. AC Analysis for Gm and Bandwidth
  ac dec 20 1k 10G
  let gm_mag = mag(v(out_diff))
  meas ac gm_lf find gm_mag at=1k
  let gm_3db = gm_lf / 1.41421356
  meas ac bw_3db when gm_mag=gm_3db fall=1
  
  * 3. Transient Analysis for THD
  tran 10n 5u
  fourier 1MEG v(out_diff)
  
  quit
.endc
.end