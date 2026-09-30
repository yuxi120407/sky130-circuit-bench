* Testbench for CMOS Transconductor
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

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
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5

XM1 N10 N1 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N10 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 LABEL_NET_0 N10 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 N9 N12 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 N2 N11 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N14 N9 N12 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N7 N5 N12 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N0 N3 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N10 N10 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N1 N2 N14 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 LABEL_NET_3 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 N11 N5 N12 GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}

* Power supply and ground connections
VVDD VDD 0 1.8
VGND GND 0 0
VN12 N12 0 0
* N6 is assumed to be N0 to maintain symmetry for the right-side PMOS mirror
VN6 N6 N0 0

* Biasing
VN2 N2 0 0.8

* Inputs
VCM VCM 0 0.6
VIN_DIFF VIN_DIFF 0 dc 0 ac 1 sin(0 0.1 1Meg)
E_INP N9 VCM VIN_DIFF 0 0.5
E_INN N5 VCM VIN_DIFF 0 -0.5

* Outputs (held at mid-supply to measure short-circuit current)
VOUT_N LABEL_NET_0 0 0.9
VOUT_P LABEL_NET_3 0 0.9

.control
  * 1. DC Operating Point & Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. AC Analysis for Gm and Bandwidth
  ac dec 20 1k 1G
  let iout_diff = i(VOUT_P) - i(VOUT_N)
  let gm_mag = mag(iout_diff)
  meas ac gm_lowfreq find gm_mag at=1k
  let gm_3db = gm_lowfreq / 1.41421356
  meas ac bw_3db when gm_mag=gm_3db fall=1

  * 3. Transient Analysis for THD
  tran 10n 5u
  let iout_diff_tran = i(VOUT_P) - i(VOUT_N)
  fourier 1Meg iout_diff_tran

  * 4. DC Sweep for Linearity
  dc VIN_DIFF -0.2 0.2 0.01
  let iout_dc = i(VOUT_P) - i(VOUT_N)
  let gm_dc = deriv(iout_dc)
  meas dc gm_max max gm_dc
  
  quit
.endc
.end
