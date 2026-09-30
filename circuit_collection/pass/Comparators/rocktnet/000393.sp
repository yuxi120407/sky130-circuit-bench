* Error Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xmn1=0.5
.param L_xmn2=0.5
.param L_xmn3=0.5
.param L_xmp1=0.5
.param L_xmp2=0.5
.param L_xmp3=0.5
.param L_xmp4=0.5
.param L_xmp5=0.5
.param L_xmp6=0.5
.param L_xmp7=0.5

.param W_xmp5=5.0 L_xmp5=0.5
.param W_xmp6=5.0 L_xmp6=0.5
.param W_xmp7=5.0 L_xmp7=0.5
.param W_xmp1=5.0 L_xmp1=0.5
.param W_xmp2=5.0 L_xmp2=0.5
.param W_xmp3=5.0 L_xmp3=0.5
.param W_xmp4=5.0 L_xmp4=0.5
.param W_xmn1=5.0 L_xmn1=0.5
.param W_xmn2=5.0 L_xmn2=0.5
.param W_xmn3=5.0 L_xmn3=0.5

VVDD VDD 0 1.8
VVSS VSS 0 0
VVBIAS VBIAS 0 0.8

* Reference peak-to-peak input (VIMAX - VIMIN = 0V to prevent saturation)
VVIMAX VIMAX 0 0.4
VVIMIN VIMIN 0 0.4

* Output peak-to-peak (VOMAX - VOMIN = Vdiff)
V_diff Vdiff 0 dc 0 pulse(-0.05 0.05 100n 1n 1n 900n 2000n)
B_VOMAX VOMAX 0 V=0.4 + v(Vdiff)/2
B_VOMIN VOMIN 0 V=0.4 - v(Vdiff)/2

XMP5 N1 VBIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp5} w={W_xmp5}
XMP6 N2 VBIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp6} w={W_xmp6}
XMP7 VCNTRL VBIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmp7} w={W_xmp7}
XMP1 N3 VOMIN N1 VDD sky130_fd_pr__pfet_01v8 l={L_xmp1} w={W_xmp1}
XMP2 N4 VOMAX N1 VDD sky130_fd_pr__pfet_01v8 l={L_xmp2} w={W_xmp2}
XMP3 N4 VIMIN N2 VDD sky130_fd_pr__pfet_01v8 l={L_xmp3} w={W_xmp3}
XMP4 N3 VIMAX N2 VDD sky130_fd_pr__pfet_01v8 l={L_xmp4} w={W_xmp4}
XMN1 N3 N3 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xmn1} w={W_xmn1}
XMN2 N4 N3 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xmn2} w={W_xmn2}
XMN3 VCNTRL N4 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xmn3} w={W_xmn3}

* Load capacitor
CL VCNTRL 0 100f

.control
  * 1. DC Operating Point
  op
  let power = -i(VVDD)*1.8
  print power

  * 2. DC Sweep for Transfer Curve
  dc V_diff -0.02 0.02 10u
  let vcntrl_deriv = deriv(v(VCNTRL))
  meas dc dc_gain max vcntrl_deriv
  meas dc v_offset when v(VCNTRL)=0.9

  * 3. Transient Analysis
  tran 0.1n 2u
  meas tran t_delay_rise trig v(Vdiff) val=0 rise=1 targ v(VCNTRL) val=0.9 rise=1
  meas tran t_delay_fall trig v(Vdiff) val=0 fall=1 targ v(VCNTRL) val=0.9 fall=1
  let t_delay = (t_delay_rise + t_delay_fall) / 2
  print t_delay
  
  quit
.endc
.end