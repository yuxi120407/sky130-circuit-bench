* Testbench for Amplifier/Bias Circuit
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xmb=5.0 L_xmb=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

* DUT
XM1 N6 N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N15 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 VBG N5 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 N13 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N0 N14 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XMB N0 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xmb} w={W_xmb}
XM7 N10 N15 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N6 N6 N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

* Power Supply
VVDD VDD 0 1.8
VN3 N3 0 1.8

* Bias Voltages
V8 N8 0 0.9
V15 N15 0 0.9
V5 N5 0 0.9
V13 N13 0 0.9
V14 N14 0 0.9

* Dummy Loads for current outputs
V1 N1 0 0.9
V10 N10 0 0.9
VVBG VBG 0 0.9

* Self-Biasing Feedback for Amplifier (XMB & XM5)
Lbias N0 N4 1T
Cin in N4 1
Cload N0 0 1p

* Input Signal
Vin in 0 dc 0 ac 1 sin(0 0.001 11k)

* Models
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xmb=0.5

* Analysis
.control
  op
  let power_consumption = -(i(VVDD) + i(VN3)) * 1.8
  print power_consumption

  ac dec 100 1 100Meg
  let gain_db = db(v(n0))
  meas ac dc_gain find gain_db at=10
  meas ac bandwidth when gain_db='dc_gain-3' fall=1
  print dc_gain
  print bandwidth

  tran 0.1u 2m
  fourier 11k v(n0)
  
  quit
.endc
.end