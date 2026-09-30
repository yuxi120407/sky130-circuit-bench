* DC-Coupled IF Stage Testbench

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

XM1 N6 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N9 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N2 LABEL_NET_0 N9 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 LABEL_NET_1 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 N0 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 LABEL_NET_2 N11 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 N7 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N2 N10 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N2 N10 N9 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N1 N7 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N2 LABEL_NET_3 N11 VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}

VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_2 LABEL_NET_2 0 0.9
VLABEL_NET_3 LABEL_NET_3 0 0.9
VN10 N10 0 0.9
VN7 N7 0 0.9

* Tie floating nodes to appropriate supplies
VN4 N4 0 0
VN5 N5 0 0
VN8 N8 0 0
VN11 N11 0 1.8

* Inputs (AC applied to N1 only to avoid cancellation at single-ended N2)
V_N1 N1 0 DC 0.9 AC 1 SIN(0.9 0.1 10Meg)
V_N3 N3 0 DC 0.9 AC 0

* Load
CL N2 0 100f

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

.control
  * DC Operating Point
  op
  let dc_power = -i(VVDD) * 1.8
  print dc_power

  * AC Analysis
  ac dec 20 1Meg 10G
  let gain_db = vdb(N2)
  meas ac midband_gain find gain_db at=10Meg
  let gain_3db = midband_gain - 3
  meas ac bw_3db when gain_db=gain_3db fall=1

  * Transient Analysis
  tran 1n 200n
  meas tran v_max max v(N2)
  meas tran v_min min v(N2)
  let vpp = v_max - v_min
  print vpp

  quit
.endc
.end
