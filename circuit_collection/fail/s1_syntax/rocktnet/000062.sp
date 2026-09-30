* Testbench for Delay Cell
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5 W_xm1=5.0
.param L_xm2=0.5 W_xm2=5.0
.param L_xm3=0.5 W_xm3=5.0
.param L_xm4=0.5 W_xm4=5.0
.param L_xm5=0.5 W_xm5=5.0
.param L_xm6=0.5 W_xm6=5.0
.param L_xm7=0.5 W_xm7=5.0
.param L_xm8=0.5 W_xm8=5.0
.param L_xm9=0.5 W_xm9=5.0
.param L_xm10=0.5 W_xm10=5.0
.param L_xm11=0.5 W_xm11=5.0
.param L_xm12=0.5 W_xm12=5.0

* DUT
XM1 N5 N4 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N3 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 N4 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 LABEL_NET_3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 LABEL_NET_4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N1 LABEL_NET_5 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N0 LABEL_NET_6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N6 LABEL_NET_7 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}

* External Loads (Required for open-drain outputs)
R1 N5 VDD 5k
R2 N1 VDD 5k
R3 N2 VDD 5k
R4 N6 VDD 5k

* DC Sources
VVDD VDD 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_3 LABEL_NET_3 0 0.9
VLABEL_NET_4 LABEL_NET_4 0 0.9
VLABEL_NET_6 LABEL_NET_6 0 0.9

* Input Signal (DC bias + AC + Transient Sine)
VN4 N4 0 dc 0.9 ac 1 sin(0.9 0.2 1.9G)
VLABEL_NET_5 LABEL_NET_5 0 dc 0.9 ac -1 sin(0.9 -0.2 1.9G)
VLABEL_NET_7 LABEL_NET_7 0 dc 0.9 ac -1 sin(0.9 -0.2 1.9G)

.control
  * 1. DC Operating Point & Power
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  * 2. AC Analysis
  ac dec 100 1M 10G
  let gain_db = db(v(N5) - v(N1))
  meas ac voltage_gain find gain_db at=1M
  meas ac operating_frequency find frequency at=1.9G
  print voltage_gain
  print operating_frequency
  
  * 3. Transient Analysis
  tran 10p 5n
  meas tran propagation_delay trig v(N4) val=0.9 rise=3 targ v(N5) val=1.2 fall=3
  print propagation_delay
  
  * 4. Noise Analysis
  noise v(N5, N1) VN4 dec 10 1k 10G
  setplot noise1
  let onoise_db = db(onoise_spectrum)
  meas noise phase_noise find onoise_db at=100k
  print phase_noise
.endc
.end