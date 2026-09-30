* Fully Differential OTA Testbench
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

* DUT
XM1 N2 LABEL_NET_0 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 LABEL_NET_1 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 VP N4 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LABEL_NET_3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 LABEL_NET_4 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 LABEL_NET_5 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 VDD VAMP N4 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 N6 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N2 LABEL_NET_7 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N0 VN N4 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N0 LABEL_NET_9 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N1 N7 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}

* Ground connection for N5
VN5 N5 0 0

* CMFB Connections (VP and VN sense the outputs)
E_VP VP 0 N3 0 1
E_VN VN 0 N1 0 1
VVAMP VAMP 0 0.9

* Power Supply
VVDD VDD 0 1.8

* Biases
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_3 LABEL_NET_3 0 0.9
VLABEL_NET_4 LABEL_NET_4 0 0.9
VLABEL_NET_5 LABEL_NET_5 0 0.9
VLABEL_NET_7 LABEL_NET_7 0 0.9
VLABEL_NET_9 LABEL_NET_9 0 0.9

* Inputs
VCM VCM 0 0.9
VINP N6 VCM dc 0 ac 0.5 pulse(-0.2 0.2 1n 100p 100p 50n 100n)
VINN N7 VCM dc 0 ac -0.5 pulse(0.2 -0.2 1n 100p 100p 50n 100n)

* Load Capacitors
CL1 N3 0 1p
CL2 N1 0 1p

* Difference amplifier for AC and Tran measurements
E_DIFF OUT_DIFF 0 N1 N3 1

.control
  * 1. DC Operating Point & Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. AC Analysis
  ac dec 100 1k 10G
  let gain_db = vdb(OUT_DIFF)
  let phase = 180/PI * cph(v(OUT_DIFF))
  
  meas ac dc_gain find gain_db at=1k
  meas ac ugbw when gain_db=0 fall=1
  meas ac phase_at_ugbw find phase when gain_db=0 fall=1
  let pm = 180 + phase_at_ugbw
  print pm

  * 3. Transient Analysis for Slew Rate
  tran 100p 100n
  meas tran vout_max max v(OUT_DIFF)
  meas tran vout_min min v(OUT_DIFF)
  
  meas tran t1 when v(OUT_DIFF)=-0.2 rise=1
  meas tran t2 when v(OUT_DIFF)=0.2 rise=1
  let sr_rise = 0.4 / (t2 - t1)
  let sr_rise_vus = sr_rise / 1e6
  print sr_rise_vus

  quit
.endc
.end
