* Fully Differential OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm12=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm19=0.5
.param L_xm1_unlabelled=0.5
.param L_xm2=0.5
.param L_xm2_unlabelled=0.5
.param L_xm3=0.5
.param L_xm3_unlabelled=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm5_unlabelled=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm7_unlabelled=0.5
.param L_xm8=0.5
.param L_xm8_unlabelled=0.5
.param L_xm9=0.5
.param L_xm9_unlabelled=0.5

* Parameters
.param W_xm1_unlabelled=5.0 L_xm1_unlabelled=0.5
.param W_xm2_unlabelled=5.0 L_xm2_unlabelled=0.5
.param W_xm3_unlabelled=5.0 L_xm3_unlabelled=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm5_unlabelled=5.0 L_xm5_unlabelled=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7_unlabelled=5.0 L_xm7_unlabelled=0.5
.param W_xm8_unlabelled=5.0 L_xm8_unlabelled=0.5
.param W_xm9_unlabelled=5.0 L_xm9_unlabelled=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm19=5.0 L_xm19=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm3=5.0 L_xm3=0.5

* DUT
XM1_UNLABELLED N4 VBN1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1_unlabelled} w={W_xm1_unlabelled}
XM2_UNLABELLED VCP VBCP N3 VDD sky130_fd_pr__pfet_01v8 l={L_xm2_unlabelled} w={W_xm2_unlabelled}
XM3_UNLABELLED VCN VBCP N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm3_unlabelled} w={W_xm3_unlabelled}
XM7 N4 VCP N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM5_UNLABELLED N1 VBP1 N12 VDD sky130_fd_pr__pfet_01v8 l={L_xm5_unlabelled} w={W_xm5_unlabelled}
XM6 VCN VBCN N9 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7_UNLABELLED N0 N17 N12 VDD sky130_fd_pr__pfet_01v8 l={L_xm7_unlabelled} w={W_xm7_unlabelled}
XM8_UNLABELLED N3 N17 N12 VDD sky130_fd_pr__pfet_01v8 l={L_xm8_unlabelled} w={W_xm8_unlabelled}
XM9_UNLABELLED N9 VCM1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9_unlabelled} w={W_xm9_unlabelled}
XM10 N4 VCM2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM5 VCP VBCN N5 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM12 N5 VCM1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM8 N4 VCN N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N4 VCM2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM15 N4 N6 GND GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16 N8 VBP1 N12 VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}
XM2 N9 VIP N4 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM1 N5 VIN N4 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM19 N4 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm19} w={W_xm19}
XM4 N9 VIP N8 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM3 N5 VIN N8 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}

* Power supplies
VVDD VDD 0 1.8
VN12 N12 0 1.8

* Bias voltages
VVBN1 VBN1 0 0.54
VVBCP VBCP 0 0.99
VVBP1 VBP1 0 0.99
VVBCN VBCN 0 0.54
VVCM1 VCM1 0 0.9
VVCM2 VCM2 0 0.9
VN17 N17 0 0.99

* Ideal CMFB to stabilize output common-mode at 0.9V
B_CMFB N6 0 V=0.54 + 10*( (v(VCP)+v(VCN))/2 - 0.9 )
B_CMFB2 N2 0 V=0.54 + 10*( (v(VCP)+v(VCN))/2 - 0.9 )

* Inputs (Differential AC=2V, Transient Step=0.4V)
VCM VCM 0 0.9
VD VIN VCM DC 0 AC 1 PULSE(0 0.2 1n 10p 10p 5n 10n)
VD2 VCM VIP DC 0 AC 1 PULSE(0 0.2 1n 10p 10p 5n 10n)

* Load capacitors
CL1 VCP 0 100f
CL2 VCN 0 100f

* Differential Output Node
B_VOUT_DIFF VOUT_DIFF 0 V=V(VCN)-V(VCP)

.control
  * DC Operating Point
  op
  print v(VCP) v(VCN) v(N4) v(N8) v(N5) v(N9)
  let power = -i(VVDD)*1.8 - i(VN12)*1.8
  print power

  * AC Analysis
  ac dec 50 1k 10G
  * Differential input is 2V AC, so subtract 6.02 dB for correct gain
  let gain_db = vdb(VOUT_DIFF) - 6.02
  let phase = 180/PI * cph(v(VOUT_DIFF))
  
  meas ac dc_gain find gain_db at=1k
  meas ac ugf when gain_db=0 fall=1
  meas ac phase_at_ugf find phase when gain_db=0 fall=1
  let pm = 180 + phase_at_ugf
  print pm

  * Transient Analysis
  tran 10p 10n
  * Measure slew rate when differential output crosses 0.2V during the step
  meas tran sr_rise deriv v(VOUT_DIFF) when v(VOUT_DIFF)=0.2 rise=1
  
  quit
.endc
.end
