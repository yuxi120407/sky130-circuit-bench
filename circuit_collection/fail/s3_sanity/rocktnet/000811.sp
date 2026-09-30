* Burst-Mode Receiver Limiting Amplifier Stage Testbench
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
.param L_xm27=0.5
.param L_xm28=0.5
.param L_xm29=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Supplies (VSS is set to 1.8V as PMOS sources are tied to it)
VVDD VDD 0 1.8
VVSS VSS 0 1.8

* Inputs
VIN_PLUS IN_PLUS 0 DC 0.7 AC 0.5 PULSE(0.7 0.8 100p 10p 10p 5n 10n)
VIN_MINUS IN_MINUS 0 DC 0.7 AC -0.5 PULSE(0.7 0.6 100p 10p 10p 5n 10n)

* Bias
VLABEL_NET_3 LABEL_NET_3 0 0.1
BLABEL_NET_4 LABEL_NET_4 0 V='v(OUT) - 0.9'
BSTARTUP VDD N0 I='10u * 0.5 * (1 - tanh((v(N0)-0.4)/0.05))'

* Fix floating nodes from extraction errors (shorted tail sources)
RN20 N20 0 500
RN5 N5 0 500
RN11 N11 0 500

* DUT Parameters
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
.param W_xm27=5.0 L_xm27=0.5
.param W_xm28=5.0 L_xm28=0.5
.param W_xm29=5.0 L_xm29=0.5

* DUT Netlist
XM1 N16 N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N18 VSS VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N4 N14 VSS VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 VSS N9 VSS VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N20 N0 N20 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N6 N23 VSS VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N22 N19 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N10 N14 VSS VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 OUT N17 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 N19 N1 N22 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N21 N9 VSS VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 N0 N7 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 N14 N17 N10 VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 N17 N0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 N9 N16 N21 VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}
XM16 N16 N16 VSS VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}
XM17 N18 N18 VSS VDD sky130_fd_pr__pfet_01v8 l={L_xm17} w={W_xm17}
XM18 N14 IN_PLUS N20 GND sky130_fd_pr__nfet_01v8 l={L_xm18} w={W_xm18}
XM19 N0 N0 LABEL_NET_3 GND sky130_fd_pr__nfet_01v8 l={L_xm19} w={W_xm19}
XM20 N1 N1 LABEL_NET_4 GND sky130_fd_pr__nfet_01v8 l={L_xm20} w={W_xm20}
XM21 N19 N16 VSS VDD sky130_fd_pr__pfet_01v8 l={L_xm21} w={W_xm21}
XM22 N7 N0 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm22} w={W_xm22}
XM23 N18 N0 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm23} w={W_xm23}
XM24 N23 N23 VSS VDD sky130_fd_pr__pfet_01v8 l={L_xm24} w={W_xm24}
XM25 N9 IN_MINUS N20 GND sky130_fd_pr__nfet_01v8 l={L_xm25} w={W_xm25}
XM26 OUT N1 N11 GND sky130_fd_pr__nfet_01v8 l={L_xm26} w={W_xm26}
XM27 N11 N19 N11 GND sky130_fd_pr__nfet_01v8 l={L_xm27} w={W_xm27}
XM28 N17 N17 VSS VDD sky130_fd_pr__pfet_01v8 l={L_xm28} w={W_xm28}
XM29 N7 N7 N23 VDD sky130_fd_pr__pfet_01v8 l={L_xm29} w={W_xm29}

* Bias startup nodeset
.nodeset v(N0)=0.8 v(N7)=0.5 v(N23)=1.0 v(N6)=1.2 v(N1)=0.8 v(N17)=1.0 v(N16)=1.0 v(N18)=1.0

.control
  * DC Operating Point
  op
  let total_current = -i(VVDD) - i(VVSS)
  let power_consumption = total_current * 1.8
  print power_consumption

  * AC Analysis
  ac dec 20 1Meg 10Gig
  meas ac voltage_gain find vdb(OUT) at=1Meg
  let gain_3db = voltage_gain - 3
  meas ac bandwidth when vdb(OUT)=$&gain_3db fall=last
  print voltage_gain
  print bandwidth

  * Transient Analysis
  tran 10p 5n
  meas tran v_start find v(OUT) at=90p
  meas tran v_end find v(OUT) at=4.9n
  let v_90 = v_start + 0.9 * (v_end - v_start)
  meas tran t_cross when v(OUT)=$&v_90 cross=1
  let settling_time = t_cross - 100p
  print settling_time
.endc
.end