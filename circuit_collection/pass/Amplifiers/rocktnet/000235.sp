* Baseband VGA with CMFB Testbench

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

* DUT
XM1 N4 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 LABEL_NET_0 N9 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 N3 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N9 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 LABEL_NET_1 N11 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N8 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 N12 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N10 N12 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N8 N0 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N3 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N3 LABEL_NET_4 N10 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N11 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N2 LABEL_NET_5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 N0 LABEL_NET_6 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}

* DC Biases
VVDD VDD 0 1.8
VN5 N5 0 0.7
VN12 N12 0 1.8
VLABEL_NET_5 LABEL_NET_5 0 0.65
VLABEL_NET_0 LABEL_NET_0 0 1.1
VLABEL_NET_1 LABEL_NET_1 0 1.1

* Inputs (DC + AC + Transient Sine)
V_INP LABEL_NET_6 0 dc 0.65 ac 0.5 sin(0.65 0.01 10Meg)
V_INN LABEL_NET_4 0 dc 0.65 ac -0.5 sin(0.65 -0.01 10Meg)

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.control
  * 1. DC Operating Point
  op
  let vout_cm = (v(N0) + v(N3))/2
  let power = -i(VVDD) * 1.8
  print vout_cm power

  * 2. AC Analysis (Max Gain, N12=1.8V)
  ac dec 20 10k 10G
  let vout_diff = v(N3) - v(N0)
  let gain_db = db(vout_diff)
  meas ac gain_max MAX gain_db
  meas ac bw_3db when gain_db='gain_max - 3' fall=1
  print gain_max bw_3db

  * 3. AC Analysis (Min Gain, N12=0.6V)
  alter VN12 0.6
  ac dec 20 10k 10G
  let vout_diff_low = v(N3) - v(N0)
  let gain_db_low = db(vout_diff_low)
  meas ac gain_min MAX gain_db_low
  print gain_min

  * 4. Transient Analysis
  alter VN12 1.8
  tran 1n 200n
  meas tran vout_max max v(N3)
  meas tran vout_min min v(N3)
  print vout_max vout_min
  
  quit
.endc
.end