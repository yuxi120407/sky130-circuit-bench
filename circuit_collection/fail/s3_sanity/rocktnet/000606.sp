* Testbench for Rail-to-Rail Column Driver
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
.param L_xm23=0.5
.param L_xm24=0.5
.param L_xm26=0.5
.param L_xm27=0.5
.param L_xm28=0.5
.param L_xm3=0.5
.param L_xm31=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xmdummy=0.5
.param L_xmi1=0.5
.param L_xmi2=0.5
.param L_xmtg1_1=0.5

* Parameters
.param W_xmi2=5.0 L_xmi2=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm18=5.0 L_xm18=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm19=5.0 L_xm19=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm20=5.0 L_xm20=0.5
.param W_xmtg1_1=5.0 L_xmtg1_1=0.5
.param W_xmdummy=5.0 L_xmdummy=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xmi1=5.0 L_xmi1=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm21=5.0 L_xm21=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm23=5.0 L_xm23=0.5
.param W_xm24=5.0 L_xm24=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm26=5.0 L_xm26=0.5
.param W_xm27=5.0 L_xm27=0.5
.param W_xm28=5.0 L_xm28=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm31=5.0 L_xm31=0.5

* DUT Netlist
XMI2 N5 R_P GND GND sky130_fd_pr__nfet_01v8 l={L_xmi2} w={W_xmi2}
XM13 N13 N13 GND GND sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM3 N11 N11 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM18 N7 N16 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm18} w={W_xm18}
XM10 OUT_P N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM5 N3 OUT_P IN1 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM8 N0 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM6 N0 IN1 IN1 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM15 N16 OUT_N N1 GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM17 N16 N16 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm17} w={W_xm17}
XM1 N6 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM19 OUT_N N7 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm19} w={W_xm19}
XM7 N3 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM16 N7 IN2 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}
XM20 OUT_N N14 GND GND sky130_fd_pr__nfet_01v8 l={L_xm20} w={W_xm20}
XMTG1_1 OUT_P R_P OUT1 GND sky130_fd_pr__nfet_01v8 l={L_xmtg1_1} w={W_xmtg1_1}
XMDUMMY VDD VDD VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmdummy} w={W_xmdummy}
XM4 IN1 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XMI1 N5 R_P VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmi1} w={W_xmi1}
XM9 OUT_P N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM21 OUT_P N5 OUT1 GND sky130_fd_pr__nfet_01v8 l={L_xm21} w={W_xm21}
XM12 N13 N13 N15 VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM23 OUT_P N5 OUT1 GND sky130_fd_pr__nfet_01v8 l={L_xm23} w={W_xm23}
XM24 OUT_N R_P OUT1 GND sky130_fd_pr__nfet_01v8 l={L_xm24} w={W_xm24}
XM2 N6 N6 N11 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM26 OUT_N N5 OUT1 GND sky130_fd_pr__nfet_01v8 l={L_xm26} w={W_xm26}
XM27 OUT_P R_P OUT1 GND sky130_fd_pr__nfet_01v8 l={L_xm27} w={W_xm27}
XM28 N5 N5 OUT1 GND sky130_fd_pr__nfet_01v8 l={L_xm28} w={W_xm28}
XM14 N1 N13 N14 GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM11 N15 LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}
XM31 OUT_N R_P OUT1 GND sky130_fd_pr__nfet_01v8 l={L_xm31} w={W_xm31}

* DC Sources
VVDD VDD 0 1.8
VLABEL LABEL_NET_1 0 0.9
* Set R_P high to enable output switches
VRP R_P 0 1.8

* Input Signal (Configured in closed-loop)
VIN IN 0 DC 0.9 AC 1 PULSE(0.1 1.7 10n 10n 10n 1u 2u)
R1 IN IN1 1m
R2 IN IN2 1m

* Load Capacitance (from paper)
CLOAD OUT1 0 30p

.control
  * 1. DC Operating Point for Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. AC Analysis for Bandwidth
  ac dec 10 1k 1G
  let gain_db = db(v(OUT1))
  meas ac max_gain MAX gain_db
  let target_gain = $&max_gain - 3
  let bandwidth = 0
  meas ac bandwidth WHEN gain_db=$&target_gain FALL=1
  print bandwidth

  * 3. Transient Analysis for Slew Rate and Swing
  tran 1n 3u
  meas tran v_max MAX v(OUT1)
  meas tran v_min MIN v(OUT1)
  let v10 = $&v_min + 0.1 * ($&v_max - $&v_min)
  let v90 = $&v_min + 0.9 * ($&v_max - $&v_min)
  
  let rise_time = 0
  let fall_time = 0
  meas tran rise_time TRIG v(OUT1) VAL=$&v10 RISE=1 TARG v(OUT1) VAL=$&v90 RISE=1
  meas tran fall_time TRIG v(OUT1) VAL=$&v90 FALL=1 TARG v(OUT1) VAL=$&v10 FALL=1

  print v_max rise_time fall_time
  quit
.endc
.end