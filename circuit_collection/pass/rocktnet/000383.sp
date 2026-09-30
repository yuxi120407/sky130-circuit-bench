* ILFD Cross-Coupled Oscillator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

* Override parameters for oscillation
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=50.0 L_xm2=0.15
.param W_xm3=50.0 L_xm3=0.15

* DUT
XM1 GND V_I GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

* Power supply and inputs
VVDD VDD 0 1.8
V_IN V_I 0 0

* LC Tank (Resonator)
L1 N0 VDD 1n
L2 N2 VDD 1n
C1 N0 N2 1p

* Load
R_load N0 N2 10k

* Initial conditions to kickstart oscillation
.ic v(N0)=1.8 v(N2)=1.5

.control
  * Run transient analysis
  tran 10p 40n uic
  
  * Measure oscillation frequency
  meas tran t_period trig v(N0) val=1.8 td=10n rise=5 targ v(N0) val=1.8 td=10n rise=15
  let f_osc = 10 / t_period
  print f_osc
  
  * Measure oscillation amplitude
  meas tran v_max max v(N0) from=20n to=40n
  meas tran v_min min v(N0) from=20n to=40n
  let v_amp = v_max - v_min
  print v_amp
  
  * Measure DC Power
  meas tran i_vdd avg i(VVDD) from=20n to=40n
  let p_dc = -i_vdd * 1.8
  print p_dc
  
  * Measure Output Power (in dBm, across 10k load)
  let p_out_w = (v_amp * v_amp) / 20000
  let output_power = 10 * log10(p_out_w * 1000 + 1e-20)
  print output_power
  
  * Locking range (0 since injection transistor is shorted)
  let locking_range = 0
  print locking_range
  
  quit
.endc
.end