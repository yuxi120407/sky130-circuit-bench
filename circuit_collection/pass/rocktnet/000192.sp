* VCO Core Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5

* DUT
XM1 N0 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 LABEL_NET_0 N1 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}

* Supplies and Biasing
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
* Tie N2 to LABEL_NET_0 to configure XM5 as a MOS varactor
VN2 N2 LABEL_NET_0 0

* LC Tank (Resonates at ~5 GHz)
L1 N0 N1 1nH
C1 N0 N1 1pF
R1 N0 N1 10k

* Differential Output Voltage
B1 Ndiff 0 V=V(N0)-V(N1)

* Kickstart Pulse to initiate oscillation
I_kick N0 N1 PULSE(0 1m 0.1n 10p 10p 10p 20p)

.control
  * DC Operating Point for Power
  op
  let p_dc = -i(VVDD) * 1.8
  print p_dc

  * Transient Analysis for Oscillation Metrics
  tran 1p 10n
  
  * Measure Oscillation Frequency (Time for 1 cycle between 20th and 21st zero-crossing)
  meas tran t1 trig v(Ndiff) val=0 rise=20 targ v(Ndiff) val=0 rise=21
  let f_osc = 1 / t1
  print f_osc

  * Measure Peak-to-Peak Amplitude
  meas tran vmax max v(Ndiff) from=5n to=10n
  meas tran vmin min v(Ndiff) from=5n to=10n
  let v_pp = vmax - vmin
  print v_pp
  
  quit
.endc
.end
