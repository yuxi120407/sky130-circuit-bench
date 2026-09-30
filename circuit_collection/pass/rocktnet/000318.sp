* Regulated Cascode Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0
.param W_xm7=5.0
.param W_xm8=5.0

* DUT
XM1 N4 VIN GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VOUT N2 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 VBP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 VOUT N3 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 N4 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 VBP VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N3 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N3 VBN GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

* Load Capacitor
CL VOUT 0 1p

* DC Sources
VVDD VDD 0 1.8
VVBP VBP 0 0.9
VVBN VBN 0 0.6

* DC Feedback for Auto-Biasing in High-Gain Region
VREF VREF 0 0.9
E1 VFB 0 VOUT VREF 100
R1 VFB VIN_DC 1e9
C1 VIN_DC 0 1

* AC Input Source
VAC VIN VIN_DC DC 0 AC 1

.control
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption
  
  ac dec 100 1 10G
  let gain_db = db(v(VOUT))
  let phase = 180/3.141592653589793 * ph(v(VOUT))
  
  meas ac dc_gain max gain_db
  meas ac ugbw when gain_db=0 fall=1
  meas ac phase_margin find phase when gain_db=0 fall=1
  
  print dc_gain
  print ugbw
  print phase_margin
.endc
.end