* Testbench for Active Complex Filter Gm Cell
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
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

XM1 N3 N3 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 LABEL_NET_0 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 N4 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 LABEL_NET_1 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N6 LABEL_NET_2 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 LABEL_NET_3 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N5 LABEL_NET_4 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 N6 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N4 LABEL_NET_5 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N7 LABEL_NET_6 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N2 LABEL_NET_7 GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N3 N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM13 N0 N4 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N0 LABEL_NET_8 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}

* Pull-up resistors for open-drain outputs
R1 N3 N0 10k
R2 N4 N0 10k

* Power supply (N0 is VDD)
VVDD N0 0 1.8

* Bias and Tuning Voltages
V_bias_tail LABEL_NET_7 0 0.9
V_tune0 LABEL_NET_0 0 0.9
V_tune3 LABEL_NET_3 0 0.9
V_tune5 LABEL_NET_5 0 0.9
V_tune8 LABEL_NET_8 0 0.9

* Differential Inputs (I channel)
V_IN_I_P LABEL_NET_1 0 DC 0.9 AC 0.5 SIN(0.9 0.1 2Meg)
V_IN_I_N LABEL_NET_4 0 DC 0.9 AC -0.5 SIN(0.9 -0.1 2Meg)

* Differential Inputs (Q channel)
V_IN_Q_P LABEL_NET_2 0 DC 0.9 AC 0
V_IN_Q_N LABEL_NET_6 0 DC 0.9 AC 0

* VCVS to convert differential output to single-ended for easy measurement
E_diff out_diff 0 N3 N4 1.0

.control
  op
  let power = -i(VVDD) * 1.8
  print power

  ac dec 100 1k 10G
  let gain_db = vdb(out_diff)
  let phase = 180/PI * cph(v(out_diff))
  
  meas ac midband_gain find gain_db at=1Meg
  meas ac bw_3db when gain_db=(midband_gain-3) fall=1
  meas ac phase_at_IF find phase at=2Meg
  
  tran 10n 2u
  meas tran vout_max max v(out_diff)
  meas tran vout_min min v(out_diff)
  
  quit
.endc
.end
