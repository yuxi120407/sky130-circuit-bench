* Testbench for Fully Differential OTA
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

* Adjusted Parameters to balance DC currents (1:2 mirror ratio)
.param W_xm1=10.0 L_xm1=0.5
.param W_xm2=10.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=10.0 L_xm9=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm11=5.0 L_xm11=0.5

* DUT
XM1 V_OM N8 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 V_OP N6 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N8 V_IM N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N8 N8 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N6 N6 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N6 V_IP N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 V_OP V_CM VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 V_OM V_CM VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N7 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm9} w={W_xm9}
XM10 V_OM N2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}
XM11 V_OP N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm11} w={W_xm11}

* Biasing and Supplies
VVDD VDD 0 1.8
VGND N4 0 0
VN1 N1 0 1.0
VN2 N2 0 1.0

* Ideal Common-Mode Feedback (CMFB)
B_CMFB V_CM 0 V='1.0 + 10*(0.5*(v(V_OP)+v(V_OM)) - 0.9)'

* Inputs (DC common-mode = 0.6V to keep tail PMOS in saturation)
V_INP V_IP 0 dc 0.6 ac 0.5 sin(0.6 0.01 10Meg)
V_INM V_IM 0 dc 0.6 ac -0.5 sin(0.6 -0.01 10Meg)

* Load Capacitance
CL1 V_OP 0 1p
CL2 V_OM 0 1p

* Differential Output Voltage Source for AC Measurement
E_diff V_DIFF 0 V_OP V_OM 1.0

* Analyses
.control
  op
  let power = -i(VVDD) * 1.8
  print power

  ac dec 100 1k 1G
  let gain_db = vdb(V_DIFF)
  let phase = 180/PI * cph(v(V_DIFF))
  
  meas ac dc_gain find gain_db at=1k
  meas ac ugbw when gain_db=0 fall=1
  meas ac phase_at_ugbw find phase when gain_db=0 fall=1
  let phase_margin = 180 + phase_at_ugbw
  print phase_margin

  tran 1n 1u
  meas tran v_max max v(V_OP)
  meas tran v_min min v(V_OP)
  
  quit
.endc
.end
