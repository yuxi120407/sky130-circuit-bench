* Testbench for Phase Detector / Mixer
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

* DUT
XM1 N1 N14 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N16 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 N14 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N8 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N12 N0 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N11 N14 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

* Supplies and Loads
VDD VDD 0 1.8
R11 N11 VDD 1k
R12 N12 VDD 1k
R16 N16 VDD 1k
R8 N8 VDD 1k

* IF Filter Capacitors (Pole at ~160 MHz to filter out 2.7 GHz RF ripple)
C11 N11 0 1p
C12 N12 0 1p
C16 N16 0 1p
C8 N8 0 1p

* Inputs (LO at 2.7 GHz, RF at 2.6 GHz to generate 100 MHz IF)
VLO N14 0 DC 0.9 SIN(0.9 0.4 2.7G)
VRF N0 0 DC 0.9 SIN(0.9 0.4 2.6G)

.control
  * Transient analysis for mixing
  tran 10p 50n
  
  * Measure power
  meas tran i_vdd avg i(VDD) from=20n to=50n
  let power = -i_vdd * 1.8
  print power
  
  * Measure IF amplitude at N12 (100 MHz IF)
  meas tran v_max max v(N12) from=20n to=50n
  meas tran v_min min v(N12) from=20n to=50n
  let v_p2p = v_max - v_min
  let if_amp = v_p2p / 2
  let rf_amp = 0.4
  
  * Conversion Gain
  let conversion_gain = if_amp / rf_amp
  let cg_db = 20 * log10(conversion_gain)
  print cg_db
  
  * Phase Detector Gain (Kpd = V_p2p / 2*pi)
  let kpd = v_p2p / 6.2831853
  print kpd
  
  quit
.endc
.end