* Testbench for NMOS Delay Chain
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.15
.param L_xm2=0.15
.param L_xm3=0.15
.param L_xm4=0.15
.param L_xm5=0.15
.param L_xm6=0.15
.param L_xm7=0.15
.param L_xm8=0.15

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0

VVDD VDD 0 1.8
VVIN VIN_AC 0 DC 0 AC 1 SIN(0 0.2 100MEG 0 0)
VN7 N7 0 0

C_in VIN_AC VIN 1u
R_fb VIN N0 100k

C_out N3 N3_AC 1u
R_out N3_AC 0 100k

* Added pull-up resistors to bias the drains
R0 N0 VDD 1k
R1 N1 VDD 1k
R3 N3 VDD 1k
R6 N6 VDD 1k
R11 N11 VDD 1k

* DUT
XM1 N1 N0 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 VIN N7 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N3 N6 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N6 N1 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N7 N7 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N6 N7 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N7 N7 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM8 N11 N7 N7 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

.control
  * DC Operating Point & Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * AC Analysis for Gain and Bandwidth
  ac dec 20 1MEG 100G
  let gain_db = db(v(N3_AC))
  meas ac max_gain max gain_db
  let gain_3db = max_gain - 3
  meas ac bw when gain_db=gain_3db fall=1
  print max_gain bw

  * Transient Analysis for Delay and Swing
  tran 10p 100n
  meas tran delay trig v(VIN_AC) val=0 rise=1 td=45n targ v(N3_AC) val=0 rise=1 td=45n
  meas tran v_max max v(N3) from=40n to=100n
  meas tran v_min min v(N3) from=40n to=100n
  let swing = v_max - v_min
  print delay swing
  
  quit
.endc
.end