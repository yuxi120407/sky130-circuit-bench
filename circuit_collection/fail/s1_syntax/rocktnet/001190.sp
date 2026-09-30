* Testbench for CMOS Multiparameter Biochemical Microsensor Op-Amp
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm17=0.5
.param L_xm18=0.5
.param L_xm19=0.5
.param L_xm2=0.5
.param L_xm20=0.5
.param L_xm21=0.5
.param L_xm22=0.5
.param L_xm23=0.5
.param L_xm24=0.5
.param L_xm25=0.5
.param L_xm26=0.5
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
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm18=5.0 L_xm18=0.5
.param W_xm19=5.0 L_xm19=0.5
.param W_xm20=5.0 L_xm20=0.5
.param W_xm21=5.0 L_xm21=0.5
.param W_xm22=5.0 L_xm22=0.5
.param W_xm23=5.0 L_xm23=0.5
.param W_xm24=5.0 L_xm24=0.5
.param W_xm25=5.0 L_xm25=0.5
.param W_xm26=5.0 L_xm26=0.5

XM1 N4 INP N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N18 BIAS4 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N19 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUT N1 N19 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N1 N13 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N0 N18 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N12 N0 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 BIAS3 N4 VSS sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N2 INN N8 VSS sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N7 BIAS2 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N13 BIAS3 N7 VSS sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N3 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 N5 BIAS1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 N14 N14 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 N14 BIAS4 N15 VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}
XM16 N4 BIAS2 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}
XM17 OUT N1 N12 VSS sky130_fd_pr__nfet_01v8 l={L_xm17} w={W_xm17}
XM18 N15 INP N8 VSS sky130_fd_pr__nfet_01v8 l={L_xm18} w={W_xm18}
XM19 N0 N18 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm19} w={W_xm19}
XM20 N13 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm20} w={W_xm20}
XM21 N18 N14 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm21} w={W_xm21}
XM22 N2 BIAS1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm22} w={W_xm22}
XM23 N7 INN N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm23} w={W_xm23}
XM24 N8 BIAS2 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm24} w={W_xm24}
XM25 N1 N13 VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm25} w={W_xm25}
XM26 N15 BIAS1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm26} w={W_xm26}

* Power Supplies
VVDD VDD 0 1.8
VVSS VSS 0 0

* Bias Voltages (Calculated for ~10uA branch currents in SKY130)
VBIAS1 BIAS1 0 1.13
VBIAS2 BIAS2 0 0.57
VBIAS3 BIAS3 0 0.87
VBIAS4 BIAS4 0 0.73

* Input Signal (DC for OP/AC, Pulse for Tran)
VCM INP 0 DC 0.9 AC 1 PULSE(0.4 1.4 1u 10n 10n 5u 10u)

* Feedback Network (Closed loop at DC, Open loop at AC)
L1 OUT INN 1000H
C1 INN 0 1000F

* Load Capacitor (Required for stability of 3-stage OTA)
CLOAD OUT 0 15p

.control
  * 1. DC Operating Point & Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. AC Analysis (Gain, UGBW, Phase Margin)
  ac dec 100 1 1G
  let gain_db = vdb(out)
  let phase = 180/PI * cph(v(out))
  meas ac dc_gain find gain_db at=10
  meas ac ugbw when gain_db=0 fall=1
  meas ac pm find phase when gain_db=0 fall=1

  * 3. Transient Analysis (Slew Rate)
  * Reconfigure feedback for unity-gain buffer
  alter L1 1p
  alter C1 1a
  tran 10n 10u
  meas tran t_rise trig v(out) val=0.6 rise=1 targ v(out) val=1.2 rise=1
  meas tran t_fall trig v(out) val=1.2 fall=1 targ v(out) val=0.6 fall=1
  let sr_rise_vus = 0.6 / (t_rise * 1e6)
  let sr_fall_vus = 0.6 / (t_fall * 1e6)
  print sr_rise_vus sr_fall_vus
  
  quit
.endc
.end
