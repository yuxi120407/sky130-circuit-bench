* Rectifier and Q-Modulation Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm9=5.0
.param W_xm10=5.0

* DUT - Fixed Cross-Coupled Rectifier with QMOD
XM1 N3 N1 N0 N3 sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N0 N1 N3 sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 GND N1 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 GND N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 GND N4 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 GND N4 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N3 N1 N0 N3 sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 N0 N1 N3 sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 GND N1 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 GND N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Sources
VVDD VDD 0 1.8
* QMOD Control Signal (0V for 1ms, 1.8V for 1ms)
V_N4 N4 0 pulse(0 1.8 1m 10n 10n 1m 2m)

* AC Source representing the secondary coil (2MHz, 1.8V peak)
V_AC N0_src N1_src dc 0 sin(0 1.8 2Meg)
R1 N0_src N0 10
R2 N1_src N1 10
* DC path to ground for floating nodes
R3 N0 0 1Meg
R4 N1 0 1Meg

* Load (100nF as reported in paper)
Cload N3 0 100n
Rload N3 0 10k

.control
  * Run transient analysis for 2ms to capture both normal and QMOD states
  tran 10n 2m
  
  * Define instantaneous power and currents
  let i_coil_tran = (v(N0_src)-v(N0))/10
  let v_diff = v(N0)-v(N1)
  let p_in_inst = v_diff * i_coil_tran
  let p_out_inst = v(N3)*v(N3)/10000
  
  * Measure metrics during normal operation (0.5ms to 1ms)
  meas tran VREC_DC avg v(N3) from=0.5m to=1m
  meas tran VREC_Ripple pp v(N3) from=0.5m to=1m
  meas tran P_IN avg p_in_inst from=0.5m to=1m
  meas tran P_OUT avg p_out_inst from=0.5m to=1m
  
  * Measure RMS values for large-signal impedance
  meas tran V_IN_RMS rms v_diff from=0.5m to=1m
  meas tran I_IN_RMS rms i_coil_tran from=0.5m to=1m
  
  * Measure metrics during QMOD active state (1.5ms to 2ms)
  meas tran VREC_DC_QMOD avg v(N3) from=1.5m to=2m
  
  * Calculate derived metrics
  let PCE = (P_OUT / P_IN) * 100
  let Z_in_large_signal = V_IN_RMS / I_IN_RMS
  
  print VREC_DC VREC_Ripple PCE Z_in_large_signal VREC_DC_QMOD
  quit
.endc
.end