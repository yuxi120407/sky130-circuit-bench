* Testbench for Shunt Regulator Error Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xmshunt=0.5

.param W_xm4=5.0 L_xm4=0.5
.param W_xmshunt=5.0 L_xmshunt=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm1=5.0 L_xm1=0.5

XM4 N1 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XMSHUNT N4 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xmshunt} w={W_xmshunt}
XM2 N1 N3 N2 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 VREF N2 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM5 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM1 N2 BIAS N4 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* Connect isolated ground N4 to main GND for testing
V_N4 N4 0 0

* DC Sources
VVDD VDD 0 1.8
VVREF VREF 0 0.9
VBIAS BIAS 0 0.6

* Input Signal at Feedback Node (N3)
VN3 N3 0 dc 0.9 ac 1 pulse(0.8 1.0 1n 1n 1n 5u 10u)

.control
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  ac dec 100 1 10G
  let gain_db = vdb(N1)
  meas ac open_loop_gain find gain_db at=10
  meas ac unity_gain_frequency when gain_db=0 fall=1

  let shunt_imp = mag(v(N1)) / mag(i(V_N4))
  meas ac shunt_impedance find shunt_imp at=10

  print open_loop_gain
  print unity_gain_frequency
  print shunt_impedance

  quit
.endc
.end