* Pseudo-Differential OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
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

XM1 GND N5 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 VDD N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N3 LABEL_NET_2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 VDD N5 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N4 LABEL_NET_3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N1 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N4 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N1 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}

VVDD VDD 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_3 LABEL_NET_3 0 0.9

VVCM VCM 0 0.9
VVID vid 0 dc 0 ac 1
E1 LABEL_NET_0 VCM vid 0 0.5
E2 LABEL_NET_2 VCM vid 0 -0.5

C1 N1 0 1p
C2 N4 0 1p

.control
  op
  let Power_Consumption = -i(VVDD) * 1.8
  print Power_Consumption

  ac dec 50 1 1G
  let out_diff = v(N4) - v(N1)
  let gain_db = 20 * log10(mag(out_diff))
  
  meas ac DC_Gain find gain_db at=1
  meas ac Unity_Gain_Frequency when gain_db=0 fall=1

  dc VVID -0.5 0.5 0.0001
  meas dc Input_Offset_Voltage when v(N4)=v(N1)
  
  print DC_Gain
  print Unity_Gain_Frequency
  print Input_Offset_Voltage
  quit
.endc
.end