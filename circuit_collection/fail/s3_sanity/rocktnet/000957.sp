* OTA Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_fb=0.5
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

XM1 GND N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N2 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N8 LABEL_NET_0 N12 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 VDD N9 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N1 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N8 LABEL_NET_1 N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 GND N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N8 N8 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N6 N0 LABEL_NET_2 VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N4 N0 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM12 LABEL_NET_2 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 GND N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM14 N3 N8 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 N1 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}
XM16 N10 N9 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}
XM17 N5 N5 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm17} w={W_xm17}
XM18 N11 N10 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm18} w={W_xm18}
XM19 GND N5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm19} w={W_xm19}
XM20 N12 N10 N9 VDD sky130_fd_pr__pfet_01v8 l={L_xm20} w={W_xm20}
XM21 N5 LABEL_NET_4 N11 N7 sky130_fd_pr__pfet_01v8 l={L_xm21} w={W_xm21}
XM22 N5 LABEL_NET_5 N12 VDD sky130_fd_pr__pfet_01v8 l={L_xm22} w={W_xm22}
XM23 N6 N5 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm23} w={W_xm23}
XM24 N2 N2 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm24} w={W_xm24}
XM25 N2 N1 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm25} w={W_xm25}

VVDD VDD 0 1.8
VLABEL_NET_1 LABEL_NET_1 0 0.9
VLABEL_NET_2 LABEL_NET_2 0 0.9
VLABEL_NET_4 LABEL_NET_4 0 0.9

* Fix floating bias nodes
V_N9 N9 0 1.8
V_N10 N10 0 1.0

* Input sources
V_INP LABEL_NET_0 0 dc 0.9 ac 1 pulse(0.4 1.4 10u 1u 1u 1m 2m)

* Feedback network for AC open-loop / DC closed-loop
L_fb N1 LABEL_NET_5 1T
C_ac LABEL_NET_5 0 1T

* Load capacitor
C_load N1 0 1p

.control
  op
  let power = -i(VVDD) * 1.8
  print power

  ac dec 20 1 1G
  let gain_db = db(v(N1))
  let phase_deg = 57.2957795131 * ph(v(N1))
  
  let dc_gain = 0
  let ugbw = 0
  let phase_margin_raw = -180
  let capacitance = 0
  let operating_frequency = 0
  
  meas ac dc_gain find gain_db at=10
  meas ac ugbw when gain_db=0 fall=1
  meas ac phase_margin_raw find phase_deg when gain_db=0 fall=1

  let phase_margin = phase_margin_raw + 180

  print dc_gain ugbw phase_margin capacitance operating_frequency
  
  quit
.endc
.end