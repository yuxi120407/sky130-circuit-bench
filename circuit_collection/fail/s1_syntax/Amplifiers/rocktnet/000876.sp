* Folded Cascode OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5

XM2 N4 VIN2 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM1 N0 VIN1 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM3 VOUT1 VB2 N10 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 CMFB GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 CMFB GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N7 VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 VOUT2 VB2 N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 VOUT2 VB3 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 VOUT1 VB3 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N10 VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N2 VB1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}

* Power Supply
VVDD VDD 0 1.8

* Bias Voltages
VVB1 VB1 0 1.0
VVB2 VB2 0 0.6
VVB3 VB3 0 1.0

* Ideal CMFB to set output common-mode to 0.9V
Ecmfb CMFB 0 VALUE = {0.6 + 10*(v(VOUT1) + v(VOUT2) - 1.8)}

* Input Signals (DC, AC, and Transient Pulse)
VVIN1 VIN1 0 DC 0.9 AC 0.5 PULSE(0.9 1.0 10n 1n 1n 1u 2u)
VVIN2 VIN2 0 DC 0.9 AC -0.5 PULSE(0.9 0.8 10n 1n 1n 1u 2u)

* Load Capacitors
C1 VOUT1 0 1p
C2 VOUT2 0 1p

* Differential Output (VOUT2 - VOUT1 to ensure 0 deg DC phase)
Eout VOUT_DIFF 0 VALUE={v(VOUT2)-v(VOUT1)}

.control
  * DC Operating Point and Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * AC Analysis
  ac dec 100 1 1G
  let gain_db = vdb(VOUT_DIFF)
  let phase = 180/PI * cph(v(VOUT_DIFF))
  let pm = 180 + phase
  
  meas ac dc_gain find gain_db at=10
  meas ac ugbw when gain_db=0 fall=1
  meas ac phase_margin find pm when gain_db=0 fall=1

  * Transient Analysis for Slew Rate
  tran 0.1n 50n
  * Measure time to slew from 0.2V to 0.8V differential
  meas tran t_rise trig v(VOUT_DIFF) val=0.2 rise=1 targ v(VOUT_DIFF) val=0.8 rise=1
  let sr_v_us = 0.6 / t_rise / 1e6
  print sr_v_us

  quit
.endc
.end
