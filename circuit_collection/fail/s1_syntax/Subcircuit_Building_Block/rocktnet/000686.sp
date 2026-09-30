* Adaptive Bias Circuit Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

XM1 N_M1_D N_M1_D VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N_X2_C N_M2_G VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N_M3_D N_M3_D VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 DELTA_ICQ N_M3_D VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 VDD N_X1_C N_BIAS GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VDD N_X2_C N_BIAS2 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

VGND GND 0 0
VVDD VDD 0 1.8
I_M1 N_M1_D 0 10u
V_M2_G N_M2_G 0 1.2
I_M3 N_M3_D 0 10u
V_X1_C N_X1_C 0 1.2

R_X2_C N_X2_C 0 100k
R_BIAS N_BIAS 0 100k
R_BIAS2 N_BIAS2 0 100k
V_DELTA DELTA_ICQ 0 0.9

.control
  op
  let mirror_ratio = i(V_DELTA) / 10u
  let level_shift = v(N_X1_C) - v(N_BIAS)
  let pwr = -i(VVDD) * 1.8
  print mirror_ratio level_shift pwr

  dc V_M2_G 0 1.8 0.01
  meas dc v_bias2_at_1v2 find v(N_BIAS2) when v(N_M2_G)=1.2
  quit
.endc
.end