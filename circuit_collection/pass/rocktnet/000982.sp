* Testbench for Summing Amplifier
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

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5

* DUT
XM1 N0 N8 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N5 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 LABEL_NET_0 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LABEL_NET_1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N4 LABEL_NET_2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 N8 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N4 LABEL_NET_3 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N2 N0 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N2 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N5 N4 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Power and Bias
VVDD VDD 0 1.8
Vbias8 N8 0 0
Vbias7 N7 0 0

* Tail Current Sources
I1 N6 0 50u
I2 N1 0 50u
I3 N3 0 100u

* Inputs
VIN1P LABEL_NET_0 0 DC 1.2 AC 0.5 PULSE(1.1 1.3 0 20p 20p 460p 1n)
VIN1N LABEL_NET_3 0 DC 1.2 AC -0.5 PULSE(1.3 1.1 0 20p 20p 460p 1n)
VIN2P LABEL_NET_1 0 DC 1.2 AC 0
VIN2N LABEL_NET_2 0 DC 1.2 AC 0

* Load Capacitors
C1 N5 0 10f
C2 N2 0 10f

* VCVS for Differential Signals
E1 out_diff 0 N2 N5 1
E2 in_diff 0 LABEL_NET_0 LABEL_NET_3 1

.control
  * DC Operating Point
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  * AC Analysis
  ac dec 50 1Meg 100G
  let gain_db = vdb(out_diff)
  meas ac voltage_gain find gain_db at=1Meg
  let gain_db_3db = voltage_gain - 3
  meas ac bandwidth_3db when gain_db=gain_db_3db fall=1
  print voltage_gain bandwidth_3db

  * Transient Analysis
  tran 2p 3n
  meas tran vout_max max v(out_diff) from=1n to=3n
  meas tran vout_min min v(out_diff) from=1n to=3n
  let transient_swing = vout_max - vout_min
  print transient_swing
  meas tran propagation_delay trig v(in_diff) val=0 rise=2 targ v(out_diff) val=0 rise=2
  print propagation_delay
  
  quit
.endc
.end