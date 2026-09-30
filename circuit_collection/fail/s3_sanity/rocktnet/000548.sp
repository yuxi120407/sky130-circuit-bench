* Testbench for DAC Cell
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
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5

XM1 GND LABEL_NET_0 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 GND N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 GND N2 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 GND LABEL_NET_2 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 GND N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N7 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N3 LABEL_NET_3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 LABEL_NET_4 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 GND N1 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N4 GND N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N5 GND N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N6 LABEL_NET_6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}

VVDD VDD 0 1.8
VLABEL_NET_3 LABEL_NET_3 0 1.2
VLABEL_NET_4 LABEL_NET_4 0 1.2
VLABEL_NET_6 LABEL_NET_6 0 0.6

* Inputs: DC 0V for AC analysis, 200MHz Pulse for Transient
VLABEL_NET_0 LABEL_NET_0 0 DC 0 AC 1 PULSE(0 1.8 0 100p 100p 2.4n 5n)
VLABEL_NET_2 LABEL_NET_2 0 DC 0 AC -1 PULSE(1.8 0 0 100p 100p 2.4n 5n)

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.control
  * DC Operating Point
  op
  let power = -i(VVDD) * 1.8
  print power

  * Transient Analysis
  tran 10p 15n
  meas tran v_max max v(N1)
  meas tran t_rise trig v(N1) val=1.4 rise=1 targ v(N1) val=1.7 rise=1
  print v_max
  print t_rise

  * AC Analysis
  ac dec 100 1Meg 10G
  let vdiff = v(N1) - v(N2)
  let gain_db = db(vdiff) - 6.0206
  meas ac gain max gain_db
  meas ac frequency when gain_db=0 fall=1
  print gain
  print frequency
.endc
.end