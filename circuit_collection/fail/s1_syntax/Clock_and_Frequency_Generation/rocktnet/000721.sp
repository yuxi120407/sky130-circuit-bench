* PMOS VCO Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=50.0 L_xm1=0.15
.param W_xm2=50.0 L_xm2=0.15

* DUT
XM1 N0 LABEL_NET_0 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N0 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}

* Supply
VVDD VDD 0 1.8

* Short LABEL_NET_0 to N1 to complete the cross-coupled pair
Vshort LABEL_NET_0 N1 0

* Tail current source (7.5mA for 13.5mW power)
Itail VDD N3 7.5m

* LC Tank (Resonant frequency ~ 5.03 GHz)
L1 N0 0 1n
L2 N1 0 1n
C1 N0 0 1p
C2 N1 0 1p
R1 N0 0 200
R2 N1 0 200

* Initial conditions to kickstart oscillation
.ic v(N0)=0.5 v(N1)=-0.5

.control
  * Run transient analysis
  tran 2p 5n uic
  
  * Measure Power Consumption
  meas tran i_vdd avg i(VVDD) from=3n to=5n
  let power = -i_vdd * 1.8
  print power
  
  * Measure Oscillation Frequency
  meas tran t1 trig v(N0) val=0 rise=10
  meas tran t2 trig v(N0) val=0 rise=20
  let osc_freq = 10 / (t2 - t1)
  print osc_freq
  
  * Measure Output Amplitude (Peak-to-Peak)
  meas tran v_max max v(N0) from=3n to=5n
  meas tran v_min min v(N0) from=3n to=5n
  let v_pp = v_max - v_min
  print v_pp
  
  quit
.endc
.end