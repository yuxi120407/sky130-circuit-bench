* Bootstrapped Switch Driver Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
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
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm13=5.0 L_xm13=0.5

XM1 N2 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N5 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N10 LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N5 LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N4 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N10 N7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N8 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N4 VDD N8 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N8 LABEL_NET_2 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N3 N3 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N7 VDD N3 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N7 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 N3 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}

VVDD VDD 0 DC 1.8
VN0 N0 0 DC 0.9 PULSE(0 1.8 1n 1n 1n 20u 40u) AC 1
* Drive floating labels with inverted clock to avoid short circuits and exercise the logic
VLABEL_NET_0 LABEL_NET_0 0 DC 0.9 PULSE(1.8 0 1n 1n 1n 20u 40u) AC -1
VLABEL_NET_1 LABEL_NET_1 0 DC 0.9 PULSE(1.8 0 1n 1n 1n 20u 40u) AC -1
VLABEL_NET_2 LABEL_NET_2 0 DC 0.9 PULSE(1.8 0 1n 1n 1n 20u 40u) AC -1

.control
  op
  let power = -i(VVDD) * 1.8
  print power
  let supply_voltage = v(VDD)
  print supply_voltage

  ac dec 100 1 1G
  let gain_db = vdb(N5)
  meas ac max_gain max gain_db
  meas ac bw_freq when gain_db=0 fall=1
  meas ac gain_25khz find gain_db at=25k

  tran 100n 100u
  meas tran v_max_N5 max v(N5)
  meas tran v_min_N5 min v(N5)
  meas tran t_rise trig v(N5) val=0.36 rise=1 targ v(N5) val=1.44 rise=1
  meas tran t_fall trig v(N5) val=1.44 fall=1 targ v(N5) val=0.36 fall=1
  meas tran delay trig v(N0) val=0.9 rise=1 targ v(N5) val=0.9 fall=1
  
  quit
.endc
.end
