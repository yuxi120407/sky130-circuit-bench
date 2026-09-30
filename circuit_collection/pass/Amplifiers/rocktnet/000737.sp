* Subthreshold Current Amplifier Testbench
.param W_xm5=5.0 L_xm5=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm4=5.0 L_xm4=0.5

VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VN1 N1 0 0

* Input current source pulling to GND (simulating rectified signal)
* DC value for OP/DC, SIN for Tran
Iin FULL_WAVE_RECTIFIED_SIGNAL 0 DC 10n SIN(50n 40n 1k)

XM5 LABEL_NET_0 VX N1 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM1 FULL_WAVE_RECTIFIED_SIGNAL FULL_WAVE_RECTIFIED_SIGNAL VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM3 VY VY N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM2 VX FULL_WAVE_RECTIFIED_SIGNAL VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM4 VX VX VY GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

.control
  * 1. DC Operating Point
  op
  let pwr = -i(VVDD)*1.8
  print pwr

  * 2. DC Sweep for Transfer Characteristic
  dc Iin 1n 100n 1n
  let Iout_dc = -i(VLABEL_NET_0)
  meas dc Iout_10n find Iout_dc at=10n
  meas dc Iout_50n find Iout_dc at=50n

  * 3. Transient Analysis (Rectified-like sine wave)
  tran 10u 2m
  let Iout_tran = -i(VLABEL_NET_0)
  meas tran Iout_max max Iout_tran
  meas tran Iout_min min Iout_tran

  quit
.endc
.end