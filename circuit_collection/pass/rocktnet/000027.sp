* Differential Envelope Detector Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

XM1 N0 N1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N0 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

* Load capacitor to smooth the envelope
Cload N2 GND 10p

* Bias and RF sources (0.9V DC bias, 0.5V amplitude, 100MHz)
V0 N0 GND dc 0.9 ac 1 sin(0.9 0.5 100Meg 500n 0 0)
V1 N1 GND dc 0.9 ac -1 sin(0.9 0.5 100Meg 500n 0 180)

.control
  * AC Analysis for Input Capacitance
  ac dec 10 1Meg 1G
  let omega = 2 * pi * frequency
  let c_in = -imag(i(V0)) / omega
  meas ac c_in_100m find c_in at=100Meg
  print c_in_100m

  * Transient Analysis for Envelope Detection
  tran 1n 1.5u
  
  * Measure DC baseline (before RF starts at 500ns)
  meas tran v_n2_dc avg v(n2) from=100n to=400n
  meas tran i_v0_dc avg i(V0) from=100n to=400n
  meas tran i_v1_dc avg i(V1) from=100n to=400n
  let p_dc = - (i_v0_dc + i_v1_dc) * 0.9
  
  * Measure RF rectified output (after settling)
  meas tran v_n2_rf avg v(n2) from=1.1u to=1.4u
  
  * Calculate Detector Gain
  let detector_gain = (v_n2_rf - v_n2_dc) / 0.5
  
  print v_n2_dc
  print p_dc
  print v_n2_rf
  print detector_gain
  
  quit
.endc
.end