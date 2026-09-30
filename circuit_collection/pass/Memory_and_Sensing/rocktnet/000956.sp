* Testbench for Impedance Sensor Front-End
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
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
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5

XM1 N3 N5 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N5 N9 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 N10 N11 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N6 N6 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N5 N3 N11 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N4 N6 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 N1 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 N1 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N11 N8 N11 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N0 N7 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N2 N4 N11 VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 N2 N9 GND GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N3 N8 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM15 N11 N10 N8 VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}
XM16 N6 LABEL_NET_2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}

* Supplies and Biases
VVDD VDD 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 0
VLABEL_NET_2 LABEL_NET_2 0 1.8
VN8 N8 0 1.8
VN10 N10 0 0.9
VN9 N9 0 1.8
VN7 N7 0 1.8

* External Sensor Impedance (50 ohms as per paper)
R_sensor N3 VDD 50

.nodeset v(N4)=1.8 v(N11)=1.8

.control
  * DC Operating Point
  op
  let power_consumption = -i(VVDD) * 1.8
  let sensor_current = (1.8 - v(N3))/50
  print power_consumption
  print sensor_current

  * DC Sweep for Comparator Threshold
  dc VLABEL_NET_2 1.8 0 -0.01
  meas dc comparator_threshold when v(N4)=0.9
  print comparator_threshold

  * Transient Analysis
  tran 1u 1m
  meas tran v_n4_avg avg v(N4)
  
  quit
.endc
.end