* VCO Tuning Block Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm7=5.0 L_xm7=0.5

XM1 VCONTROL S_MINUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 VCONTROL OUT_PLUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 VCONTROL S_PLUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 VCONTROL OUT_MINUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 VCONTROL P_PLUS GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 VCONTROL P_MINUS GND GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM8 OUT_PLUS N1 VCONTROL GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM7 OUT_MINUS N1 VCONTROL GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}

VVDD VDD 0 1.8
VVCONTROL VCONTROL 0 0.9
VN1 N1 0 0.9

* Ideal 3-stage Ring Oscillator to drive the DUT
B1 N1_P_int 0 V='1.8 * (0.5 - 0.5*tanh(10*(v(S_PLUS)-0.9)))'
R1 N1_P_int P_PLUS 500
C1 P_PLUS 0 10f
B2 N1_N_int 0 V='1.8 * (0.5 - 0.5*tanh(10*(v(S_MINUS)-0.9)))'
R2 N1_N_int P_MINUS 500
C2 P_MINUS 0 10f

B3 N2_P_int 0 V='1.8 * (0.5 - 0.5*tanh(10*(v(P_PLUS)-0.9)))'
R3 N2_P_int OUT_PLUS 500
C3 OUT_PLUS 0 10f
B4 N2_N_int 0 V='1.8 * (0.5 - 0.5*tanh(10*(v(P_MINUS)-0.9)))'
R4 N2_N_int OUT_MINUS 500
C4 OUT_MINUS 0 10f

B5 N3_P_int 0 V='1.8 * (0.5 - 0.5*tanh(10*(v(OUT_PLUS)-0.9)))'
R5 N3_P_int S_PLUS 500
C5 S_PLUS 0 10f
B6 N3_N_int 0 V='1.8 * (0.5 - 0.5*tanh(10*(v(OUT_MINUS)-0.9)))'
R6 N3_N_int S_MINUS 500
C6 S_MINUS 0 10f

.ic v(P_PLUS)=1.8 v(P_MINUS)=0 v(OUT_PLUS)=0 v(OUT_MINUS)=1.8 v(S_PLUS)=1.8 v(S_MINUS)=0

.control
  * Measure Center Frequency
  tran 1p 10n uic
  meas tran t1 trig v(OUT_PLUS) val=0.9 rise=20 targ v(OUT_PLUS) val=0.9 rise=21
  let freq_center = 1 / t1
  print freq_center
  
  meas tran v_max max v(OUT_PLUS) from=5n to=10n
  meas tran v_min min v(OUT_PLUS) from=5n to=10n
  let v_swing = v_max - v_min
  print v_swing
  
  meas tran i_vdd avg i(VVDD) from=5n to=10n
  let power_mw = -i_vdd * 1.8 * 1000
  print power_mw

  * Measure Min Frequency (VCONTROL = 0.0V)
  alter VVCONTROL 0.0
  tran 1p 10n uic
  meas tran t_min trig v(OUT_PLUS) val=0.9 rise=20 targ v(OUT_PLUS) val=0.9 rise=21
  let freq_min = 1 / t_min
  print freq_min

  * Measure Max Frequency (VCONTROL = 1.8V)
  alter VVCONTROL 1.8
  tran 1p 10n uic
  meas tran t_max trig v(OUT_PLUS) val=0.9 rise=20 targ v(OUT_PLUS) val=0.9 rise=21
  let freq_max = 1 / t_max
  print freq_max

  quit
.endc
.end
