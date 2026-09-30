* Adaptive Analog Noise-Predictive Decision-Feedback Equalizer
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

XM2 N10 N02 N13 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VOUTP VGG N8 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM1 N14 N01 N13 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM4 VOUTN N12 N10 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 VOUTN N7 N11 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N8 VBB VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 VOUTP VGG N14 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N11 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

* Power supply
VVDD VDD 0 1.8

* Biasing
B_VBB VBB 0 V = 1.04 + 2 * (v(VOUTP) + v(VOUTN) - 1.8)
B_N6 N6 0 V = 1.04 + 2 * (v(VOUTP) + v(VOUTN) - 1.8)
VVGG VGG 0 0.65
VN7 N7 0 0.65
VN12 N12 0 0.65

* Tail current source
Itail N13 0 20u

* Inputs
VVINP N01 0 DC 0.5 AC 0.5 PULSE(0.45 0.55 1n 10p 10p 2n 4n)
VVINN N02 0 DC 0.5 AC -0.5 PULSE(0.55 0.45 1n 10p 10p 2n 4n)

* Load capacitance
CL1 VOUTP 0 10f
CL2 VOUTN 0 10f

* Ideal CMFB to stabilize DC operating point
VCM_REF VCM 0 0.9
RCM1 VOUTP VCM 1Meg
RCM2 VOUTN VCM 1Meg

* Differential output
E_diff VOUT_DIFF 0 VOUTN VOUTP 1

.control
  op
  let power = -i(VVDD) * 1.8
  print power

  ac dec 100 1Meg 10G
  let gain_db = db(v(VOUT_DIFF))
  
  meas ac dc_gain find gain_db at=1Meg
  print dc_gain
  
  let gain_minus_3db = dc_gain - 3
  meas ac bw_3db when gain_db=gain_minus_3db fall=1
  print bw_3db
  
  tran 10p 5n
  meas tran delay trig v(N01) val=0.5 rise=1 targ v(VOUT_DIFF) val=0 rise=1
  print delay
  
  quit
.endc
.end