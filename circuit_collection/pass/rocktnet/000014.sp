* CMFB Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0

XM1 N0 N0 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 LABEL_NET_0 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N0 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 N0 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N0 N0 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 LABEL_NET_1 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}

VVDD N2 0 1.8
VVDD_BULK VDD 0 1.8
VBIAS N1 0 0.9

VCM VCM_node 0 dc 0.9 ac 1
VDM VDM_node 0 dc 0 ac 0

E1 LABEL_NET_0 VCM_node VDM_node 0 0.5
E2 LABEL_NET_1 VCM_node VDM_node 0 -0.5

CL N0 0 50f

.control
  op
  let dc_power = -i(VVDD) * 1.8 - i(VVDD_BULK) * 1.8
  let v_out_dc = v(N0)
  print dc_power
  print v_out_dc

  * Common-Mode AC Analysis
  ac dec 10 1Meg 1000G
  let cm_gain_db = 20*log10(mag(v(N0)) + 1e-20)
  meas ac cm_gain find cm_gain_db at=1Meg
  meas ac cm_bw when cm_gain_db='cm_gain - 3' fall=1

  * Differential-Mode AC Analysis
  alter VCM ac=0
  alter VDM ac=1
  ac dec 10 1Meg 1000G
  let dm_gain_db = 20*log10(mag(v(N0)) + 1e-20)
  meas ac dm_gain find dm_gain_db at=1Meg
  
  let system_output_power = 0
  let system_frequency = 0
  let system_gain = 0
  let system_noise_figure = 0
  let system_efficiency = 0
  let system_phase_noise = 0

  print cm_gain
  print cm_bw
  print dm_gain
  print system_output_power
  print system_frequency
  print system_gain
  print system_noise_figure
  print system_efficiency
  print system_phase_noise

  quit
.endc
.end