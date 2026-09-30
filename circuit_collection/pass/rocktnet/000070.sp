* CMOS Imager Pixel Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm17=0.5
.param L_xm18=0.5
.param L_xm19=0.5
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
.param W_xm17=5.0 L_xm17=0.5
.param W_xm18=5.0 L_xm18=0.5
.param W_xm19=5.0 L_xm19=0.5

XM1 N6 LABEL_NET_0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N6 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N8 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N7 N9 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 N9 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N7 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N5 N6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N2 LABEL_NET_2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N2 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N5 VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N1 N5 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N0 LABEL_NET_3 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N5 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM15 N4 LABEL_NET_4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16 N5 VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}
XM17 N4 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm17} w={W_xm17}
XM18 N1 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm18} w={W_xm18}
XM19 N0 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm19} w={W_xm19}

VVDD VDD 0 1.8
* DC Biases
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_2 LABEL_NET_2 0 0.9
VLABEL_NET_4 LABEL_NET_4 0 0.9
* Input signal with DC, AC, and Transient pulse
VLABEL_NET_3 LABEL_NET_3 0 dc 0.9 ac 1 pulse(0.8 1.0 10n 1n 1n 40n 100n)

* Biases for floating nodes to ensure convergence and open-loop measurement
VN5 N5 0 0.9
VN9 N9 0 0.9
RN2 N2 0 1G

.control
  * 1. DC Operating Point
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  * 2. AC Analysis
  ac dec 10 1 1G
  let gain_db = db(v(N0))
  meas ac gain_stage1 find gain_db at=10
  print gain_stage1

  * 3. Transient Analysis
  tran 0.1n 100n
  meas tran delay trig v(LABEL_NET_3) val=0.9 rise=1 targ v(N0) val=0.9 cross=1
  print delay
  
  quit
.endc
.end