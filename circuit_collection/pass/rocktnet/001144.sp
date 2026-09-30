* CMFB Amplifier Testbench

.param W_xmm5=5.0 L_xmm5=0.5
.param W_xmm2=5.0 L_xmm2=0.5
.param W_xmm7=5.0 L_xmm7=0.5
.param W_xmm6=5.0 L_xmm6=0.5
.param W_xmm8=5.0 L_xmm8=0.5
.param W_xmm3=5.0 L_xmm3=0.5
.param W_xmm4=5.0 L_xmm4=0.5
.param W_xmm1=5.0 L_xmm1=0.5

* DUT
XMM5 CMFB CMFB GND GND sky130_fd_pr__nfet_01v8 l={L_xmm5} w={W_xmm5}
XMM2 CMFB VCM N3 VDD sky130_fd_pr__pfet_01v8 l={L_xmm2} w={W_xmm2}
XMM7 N3 B1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmm7} w={W_xmm7}
XMM6 N5 N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xmm6} w={W_xmm6}
XMM8 N1 B1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmm8} w={W_xmm8}
XMM3 CMFB VCM N1 VDD sky130_fd_pr__pfet_01v8 l={L_xmm3} w={W_xmm3}
XMM4 N5 VOUT_MINUS N1 VDD sky130_fd_pr__pfet_01v8 l={L_xmm4} w={W_xmm4}
XMM1 N5 VOUT_PLUS N3 VDD sky130_fd_pr__pfet_01v8 l={L_xmm1} w={W_xmm1}

* DC Sources
VVDD VDD 0 1.8
VB1 B1 0 0.8
VVCM VCM 0 0.5

* Input Signal Sources
VCM_IN VCM_IN 0 dc 0.5 ac 1
VDM_IN VDM_IN 0 dc 0 ac 0

* VCVS to generate VOUT_PLUS and VOUT_MINUS
E1 VOUT_PLUS VCM_IN VDM_IN 0 0.5
E2 VOUT_MINUS VCM_IN VDM_IN 0 -0.5

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xmm1=0.5
.param L_xmm2=0.5
.param L_xmm3=0.5
.param L_xmm4=0.5
.param L_xmm5=0.5
.param L_xmm6=0.5
.param L_xmm7=0.5
.param L_xmm8=0.5

.control
  * 1. DC Operating Point & Power
  op
  let power_consumption = -i(VVDD)*1.8
  print power_consumption

  * 2. Common-Mode AC Analysis
  ac dec 100 1 100G
  meas ac cm_gain find vdb(CMFB) at=10
  let cm_gain_3db = cm_gain - 3
  meas ac cm_bw when vdb(CMFB)="$&cm_gain_3db" fall=1
  print cm_gain
  print cm_bw

  * 3. Differential-Mode AC Analysis
  alter VCM_IN ac=0
  alter VDM_IN ac=1
  ac dec 100 1 100G
  meas ac dm_gain find vdb(CMFB) at=10
  print dm_gain

  quit
.endc
.end