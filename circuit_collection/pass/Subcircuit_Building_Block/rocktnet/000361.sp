* Charge Pump UP Branch Testbench
.param W_xm10=5.0 L_xm10=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm12=5.0 L_xm12=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm4=5.0 L_xm4=0.5

VVDD VDD 0 1.8
* Bias for NMOS tail current
I_N2 VDD N2 50u
* Bias for PMOS current sources
V_N0 N0 0 0.6
* Pull-up for internal node N3 to ensure recovery when UP is low
R_N3 N3 VDD 100k

* Output load and current measurement
V_VCP VCP_load 0 0.9
V_meas VCP VCP_load 0

* Inputs (DC values set for ON state during DC sweep)
V_UP UP 0 dc 1.8 pulse(0 1.8 5n 0.1n 0.1n 10n 20n)
V_UPB UPB 0 dc 0 pulse(1.8 0 5n 0.1n 0.1n 10n 20n)

* DUT
XM10 N1 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM8 VDD UPB N1 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM12 N2 N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM7 VCP N3 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM9 N3 UP N1 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM5 N0 N3 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM4 N5 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm10=0.5
.param L_xm12=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

.control
  * Transient Analysis for switching metrics
  tran 0.1n 40n
  meas tran I_up_tran find i(V_meas) at=10n
  meas tran I_leak_tran find i(V_meas) at=2n
  
  * Measure rise and fall times of the output current
  meas tran t_rise trig v(UP) val=0.9 rise=1 targ i(V_meas) val=10u rise=1
  meas tran t_fall trig v(UP) val=0.9 fall=1 td=14n targ i(V_meas) val=10u fall=1 td=14n

  * DC Analysis for output compliance
  dc V_VCP 0 1.8 0.05
  meas dc I_up_0v9 find i(V_meas) at=0.9
  meas dc I_up_1v5 find i(V_meas) at=1.5
  meas dc I_up_0v3 find i(V_meas) at=0.3
  
  let compliance_diff = I_up_1v5 - I_up_0v3
  print I_up_tran I_leak_tran t_rise t_fall I_up_0v9 compliance_diff
  quit
.endc
.end