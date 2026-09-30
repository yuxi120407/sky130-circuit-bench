* VCO Delay Cell Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm7=0.5

.param W_xm7=10.0 L_xm7=0.5
.param W_xm2=20.0 L_xm2=0.5
.param W_xm3=20.0 L_xm3=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm12=2.0 L_xm12=0.5
.param W_xm13=2.0 L_xm13=0.5

* DUT
XM7 N1 BP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM2 O1 VN N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 O2 VP N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM10 O1 BN GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 O2 BN GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 O1 O1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 O2 O2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}

* Sources
VVDD VDD 0 1.8
VBP BP 0 0.4
VBN BN 0 0.5

* Input signals (Common mode = 0.64V, Diff AC = 1V)
VCM VCM 0 0.64
VAC_P VP VCM dc 0 ac 0.5
VAC_N VN VCM dc 0 ac -0.5

* Load capacitors to simulate next stage
CL1 O1 0 20f
CL2 O2 0 20f

.control
  * Operating Point Analysis
  op
  let power_consumption = -i(VVDD) * 1.8
  let output_common_mode = (v(O1) + v(O2)) / 2
  print power_consumption
  print output_common_mode

  * AC Analysis
  ac dec 100 1 10G
  let vdiff = v(O1) - v(O2)
  let gain_db = db(vdiff)
  
  meas ac dc_gain find gain_db at=1k
  meas ac unity_gain_bandwidth when gain_db=0 fall=1
  
  print dc_gain
  print unity_gain_bandwidth
  quit
.endc
.end