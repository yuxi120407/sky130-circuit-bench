* DFE Tap Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

XM3 VB VB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 VB VB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM1 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM5 N1 VSS N0 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VB VDD N0 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

* DC Sources
VVDD VDD 0 1.8
VVSS VSS 0 0

* Tail current source at N0 (simulating tap enable/disable)
* DC 100uA, AC 1uA for small signal, PULSE for transient switching
I_tail N0 GND DC 100u AC 1u PULSE(0 100u 1n 10p 10p 1n 2n)

.control
  * DC Operating Point
  op
  let power_dc = -i(VVDD) * 1.8
  print power_dc
  print v(VB) v(N1) v(N0)

  * AC Analysis
  ac dec 10 1Meg 100Gig
  let gain_db = db(v(VB))
  meas ac transimpedance_gain_raw find gain_db at=1Meg
  let transimpedance_gain = transimpedance_gain_raw + 120
  print transimpedance_gain

  let v_mag = mag(v(VB))
  meas ac v_out_high find v_mag at=100Gig
  let z_high = v_out_high / 1u
  let capacitance_load = 1 / (2 * 3.1415926535 * 100e9 * z_high)
  print capacitance_load

  * Transient Analysis
  tran 1p 3n
  meas tran v_max max v(VB)
  meas tran v_min min v(VB)
  let v_swing = v_max - v_min
  print v_swing
  
  * Measure fall time
  meas tran t_fall trig v(VB) val=1.2 fall=1 targ v(VB) val=0.8 fall=1
  print t_fall

  quit
.endc
.end