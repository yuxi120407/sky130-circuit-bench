* Bias Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 VBN VBN GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VBN VBP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 VBN GND GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VBN VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

VVDD VDD 0 1.8
VVBP VBP 0 dc 0.99 ac 1

.control
  op
  let vbn_dc = v(VBN)
  let i_bias = -i(VVDD)
  let power = i_bias * 1.8
  print vbn_dc i_bias power

  ac dec 10 1 1G
  let gain_db = vdb(VBN)
  meas ac low_freq_gain find gain_db at=100
  
  quit
.endc
.end