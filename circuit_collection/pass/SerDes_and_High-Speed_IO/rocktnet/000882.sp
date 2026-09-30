* CML Buffer with Pre-emphasis Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

XM1 VT1 VB GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VT2 VB GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 OUTM DNB VT2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUTP DN VT2 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 OUTP UPB VT1 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 OUTM UP VT1 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 OUTP VCM VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 OUTM VCM VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

VVDD VDD 0 1.8
VVB VB 0 0.8
VVCM VCM 0 0.0

* Inputs: UP/UPB (Main Data) and DN/DNB (Delayed Data for Pre-emphasis)
VUP UP 0 PULSE(0.6 1.8 1n 50p 50p 2n 4n)
VUPB UPB 0 PULSE(1.8 0.6 1n 50p 50p 2n 4n)
VDN DN 0 PULSE(0.6 1.8 1.5n 50p 50p 2n 4n)
VDNB DNB 0 PULSE(1.8 0.6 1.5n 50p 50p 2n 4n)

* Parasitic Load Capacitance
C1 OUTP 0 10f
C2 OUTM 0 10f

.control
  * DC Operating Point for Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * Transient Analysis for Swing and Delay
  tran 10p 10n
  
  * Calculate Differential Output
  let vdiff = v(OUTP) - v(OUTM)
  
  * Measure Differential Swing
  meas tran vdiff_max max vdiff from=2n to=10n
  meas tran vdiff_min min vdiff from=2n to=10n
  let v_swing_diff = vdiff_max - vdiff_min
  print v_swing_diff
  
  * Measure Single-Ended Swings and Common Mode
  meas tran voutp_max max v(OUTP) from=2n to=10n
  meas tran voutp_min min v(OUTP) from=2n to=10n
  let v_out_cm = (voutp_max + voutp_min) / 2
  print v_out_cm

  quit
.endc
.end