* Testbench for Comparator / Folded Cascode OTA

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

* DUT
XM1 N6 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 LABEL_NET_0 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 LABEL_NET_2 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N5 LABEL_NET_3 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N2 LABEL_NET_4 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N3 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N4 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N7 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM12 N5 LABEL_NET_5 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}

* Power Supply
VVDD VDD 0 1.8

* Biases
VBIAS_TAIL LABEL_NET_1 0 1.0
VBIAS_PCAS LABEL_NET_3 0 0.6
VBIAS_NCAS1 LABEL_NET_4 0 1.0
VBIAS_NCAS2 LABEL_NET_5 0 1.0

* Inputs
* INP is LABEL_NET_2
VINP LABEL_NET_2 0 dc 0.7 ac 1 pulse(0.6 0.8 50n 1n 1n 1u 2u)

* INN is LABEL_NET_0. Biased at 0.7V through massive RC for open-loop AC/Tran, closed-loop DC.
R1 N5 LABEL_NET_0 1G
C1 LABEL_NET_0 0 1G

* Load
CL N5 0 100f

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

.control
  * 1. DC Operating Point
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. AC Analysis
  ac dec 100 1 10G
  let gain_db = db(v(N5))
  let phase = 180/PI * cph(v(N5))
  meas ac dc_gain find gain_db at=10
  meas ac ugbw when gain_db=0 fall=1
  meas ac phase_at_ugbw find phase when gain_db=0 fall=1
  meas ac pm param='180 + phase_at_ugbw'

  * 3. Transient Analysis
  tran 100p 2.5u
  * Rising edge measurements
  meas tran t_pd_rise trig v(LABEL_NET_2) val=0.7 rise=1 td=10n targ v(N5) val=0.7 rise=1 td=10n
  meas tran t_rise trig v(N5) val=0.6 rise=1 td=10n targ v(N5) val=1.0 rise=1 td=10n
  meas tran sr_r_V_us param='0.4 / t_rise * 1e-6'

  * Falling edge measurements
  meas tran t_pd_fall trig v(LABEL_NET_2) val=0.7 fall=1 td=1u targ v(N5) val=0.7 fall=1 td=1u
  meas tran t_fall trig v(N5) val=1.0 fall=1 td=1u targ v(N5) val=0.6 fall=1 td=1u
  meas tran sr_f_V_us param='0.4 / t_fall * 1e-6'

  print dc_gain ugbw pm power t_pd_rise t_pd_fall sr_r_V_us sr_f_V_us
  quit
.endc
.end