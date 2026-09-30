* Adaptive Equalizer Testbench

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Parameterized W/L
.param L_xm1=0.15 W_xm1=5.0
.param L_xm2=0.15 W_xm2=5.0
.param L_xm3=0.15 W_xm3=5.0
.param L_xm4=0.15 W_xm4=5.0
.param L_xm5=0.15 W_xm5=5.0
.param L_xm6=0.15 W_xm6=5.0
.param L_xm7=0.15 W_xm7=5.0
.param L_xm8=0.15 W_xm8=5.0
.param L_xm9=0.15 W_xm9=5.0
.param L_xm10=0.15 W_xm10=5.0
.param L_xm11=0.15 W_xm11=5.0
.param L_xm12=0.15 W_xm12=5.0
.param L_xm13=0.15 W_xm13=5.0
.param L_xm14=0.15 W_xm14=5.0
.param L_xm15=0.15 W_xm15=5.0
.param L_xm16=0.15 W_xm16=5.0

* DUT
XM1 N6 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N6 N9 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N11 N1 N12 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N4 N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N12 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N11 N11 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N9 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 N1 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N5 N5 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 N2 N10 N12 GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N3 N3 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 N8 N8 GND GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 N9 N9 GND GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16 N5 N7 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}

* Power Supply
VVDD VDD 0 1.8

* Bias Voltages (Controls equalization weight)
VBIAS1 N0 0 0.7
VBIAS2 N8 0 0.6

* Input Signals
VINP N1 0 dc 1.2 ac 0.5 pwl(0 1.2 1n 1.2 1.01n 1.1 5n 1.1 5.01n 1.3 9n 1.3 9.01n 1.1 15n 1.1)
VINM1 N10 0 dc 1.2 ac -0.5 pwl(0 1.2 1n 1.2 1.01n 1.3 5n 1.3 5.01n 1.1 9n 1.1 9.01n 1.3 15n 1.3)
VINM2 N7 0 dc 1.2 ac -0.5 pwl(0 1.2 1n 1.2 1.01n 1.3 5n 1.3 5.01n 1.1 9n 1.1 9.01n 1.3 15n 1.3)

* Load Capacitance
CL N6 0 10f

* Dummy DUT for DC balancing
XM1_d N6_d N2_d VDD_d VDD_d sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2_d N0_d N0_d GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3_d N6_d N9_d GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4_d N11_d N1_d N12_d GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5_d N4_d N8_d GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6_d N12_d N0_d GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7_d N11_d N11_d VDD_d VDD_d sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8_d N9_d N5_d VDD_d VDD_d sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9_d N3_d N1_d N4_d GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10_d N5_d N5_d VDD_d VDD_d sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11_d N2_d N10_d N12_d GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12_d N3_d N3_d VDD_d VDD_d sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM13_d N2_d N2_d VDD_d VDD_d sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14_d N8_d N8_d GND GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15_d N9_d N9_d GND GND sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM16_d N5_d N7_d N4_d GND sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}

* Dummy Biases
VVDD_d VDD_d 0 1.8
VBIAS1_d N0_d 0 0.7
VBIAS2_d N8_d 0 0.6
VDC_d1 N1_d 0 1.2
VDC_d2 N10_d 0 1.2
VDC_d3 N7_d 0 1.2

* DC Servo
Vref Nref 0 0.9
Gservo_d N6_d 0 N6_d Nref 100m
Gservo_main N6 0 N6_d Nref 100m

.control
  * 1. DC Operating Point & Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. AC Analysis
  ac dec 50 1Meg 100G
  let gain_db = db(v(N6))
  meas ac dc_gain find gain_db at=1Meg
  meas ac peak_gain max gain_db
  meas ac bw_3db when gain_db='peak_gain-3' fall=1
  print dc_gain peak_gain bw_3db

  * 3. Transient Analysis
  tran 10p 15n
  meas tran delay trig v(N1) val=1.2 rise=1 td=4n targ v(N6) val=0.9 fall=1 td=4n
  print delay

  quit
.endc
.end