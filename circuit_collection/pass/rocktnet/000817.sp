* RSSI Detector Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

* Unbalanced pair parameters (K=4) for square-law detection
.param W_xm1=1.0 L_xm1=0.5
.param W_xm2=4.0 L_xm2=0.5
.param W_xm3=4.0 L_xm3=0.5
.param W_xm4=1.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

VVDD VDD 0 1.8
V_N4 N4 0 DC 0.9
V_VIN VIN 0 DC 0.9 AC 1 SIN(0.9 0.2 110MEG 0 0)

* Tail currents for the differential pairs
I_N5 N5 0 50u
I_N3 N3 0 50u

* Output load to measure DELTA_I
V_MEAS DELTA_I 0 DC 0.9

* DUT
XM5 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM1 N0 VIN N5 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM3 N1 VIN N3 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N4 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM2 N1 N4 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM6 N1 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 DELTA_I N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

.control
  * 1. DC Sweep for Bell Curve Characteristic
  dc V_VIN 0.4 1.4 0.01
  let out_i = abs(i(V_MEAS))
  meas dc i_max max out_i
  meas dc i_min min out_i
  
  * 2. Transient Analysis for RSSI Average Current
  tran 0.1n 50n
  let out_i_tran = abs(i(V_MEAS))
  meas tran i_avg avg out_i_tran from=20n to=50n
  
  print i_max i_min i_avg
.endc
.end