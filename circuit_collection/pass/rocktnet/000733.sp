* Testbench for Adaptive ENG Amplifier (Two-Stage OTA)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
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

* DUT
XM1 N_M1_D I_I N_TAIL VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N_M2_D N_M2_G N_TAIL VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N_M1_D N_M1_D VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N_M2_D N_M1_D VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N_BIAS N_BIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N_TAIL N_BIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 V_O N_BIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N_M2_D VDD N_M8_S VSS sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 V_O N_M2_D VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}

* Dummy resistor to prevent floating node matrix singularity
Rdummy N_M8_S 0 1T

* Supplies and Bias
VVDD VDD 0 1.8
VVSS VSS 0 0
Ibias N_BIAS 0 10u

* Input Signal (DC for OP/AC, Pulse for Tran)
Vcm N_M2_G 0 dc 0.9 ac 1 pulse(0.4 0.9 10u 1u 1u 100u 200u)

* Feedback network (Closed loop at DC, Open loop at AC)
L1 V_O I_I 1G
C1 I_I 0 1G

* Load capacitance (Large to stabilize uncompensated OTA)
CL V_O 0 1n

.control
  * 1. DC Operating Point & Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. AC Analysis
  ac dec 50 1 100Meg
  let gain_db = vdb(V_O)
  let phase_deg = 180/PI * cph(v(V_O))
  
  meas ac dc_gain find gain_db at=10
  meas ac ugf when gain_db=0 fall=1
  meas ac phase_at_ugf find phase_deg when gain_db=0 fall=1
  let pm = 180 + phase_at_ugf
  print pm

  * 3. Transient Analysis (Step Response)
  * Alter feedback to unity-gain buffer for transient
  alter L1 1p
  alter C1 1a
  tran 1u 200u
  
  meas tran trise trig v(V_O) val=0.5 rise=1 targ v(V_O) val=0.8 rise=1
  meas tran tfall trig v(V_O) val=0.8 fall=1 targ v(V_O) val=0.5 fall=1
  
  let sr_rise_vus = (0.3 / trise) * 1e-6
  let sr_fall_vus = (0.3 / tfall) * 1e-6
  print sr_rise_vus sr_fall_vus
  
  quit
.endc
.end