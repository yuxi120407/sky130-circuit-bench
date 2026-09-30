* Testbench for Fully Differential Amplifier
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0
.param W_xm9=5.0
.param W_xm10=5.0
.param W_xm11=5.0

XM1 N2 N1 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N0 LABEL_NET_1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N5 N1 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 LABEL_NET_2 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N4 N1 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N3 N1 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM7 N3 LABEL_NET_3 N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N4 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 N1 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N1 N1 N6 GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM11 N5 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}

* Power and Ground
VVDD VDD 0 1.8
VN6 N6 0 0

* Bias Current for NMOS current sinks
Ibias VDD N1 20u

* Ideal CMFB to set output common-mode to 0.9V
Bcmfb LABEL_NET_1 0 V='0.9 + 100*( (v(N2)+v(N3))/2 - 0.9 )'

* Differential Inputs
Vd input_diff 0 dc 0 ac 1 pulse(-0.1 0.1 1n 100p 100p 50n 100n)
B1 LABEL_NET_2 0 V='0.5 + 0.5*v(input_diff)'
B2 LABEL_NET_3 0 V='0.5 - 0.5*v(input_diff)'

* Load Capacitance
C1 N2 0 100f
C2 N3 0 100f

* Differential output node for easy measurement
Bdiff out_diff 0 V='v(N3) - v(N2)'

.control
  * DC Operating Point and Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * AC Analysis
  ac dec 100 1k 10G
  let gain_db = db(v(out_diff))
  let phase = 180/3.1415926535 * ph(v(out_diff))
  
  meas ac dc_gain find gain_db at=1k
  meas ac ugf when gain_db=0 fall=1
  meas ac phase_at_ugf find phase when gain_db=0 fall=1
  meas ac phase_margin param='phase_at_ugf + 180'
  print dc_gain
  print ugf
  print phase_margin
  
  * Transient Analysis for Slew Rate
  tran 10p 100n
  let out_deriv = deriv(v(out_diff))
  meas tran sr_max max out_deriv from=1.2n to=50n
  meas tran slew_rate param='sr_max / 1e6'
  print slew_rate
  
  quit
.endc
.end