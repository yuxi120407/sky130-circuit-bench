* CML Divider Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm1=5.0 L_xm1=0.15
.param W_xm2=5.0 L_xm2=0.15
.param W_xm3=5.0 L_xm3=0.15
.param W_xm4=5.0 L_xm4=0.15
.param W_xm5=5.0 L_xm5=0.15
.param W_xm6=5.0 L_xm6=0.15
.param W_xm7=5.0 L_xm7=0.15
.param W_xm8=5.0 L_xm8=0.15
.param W_xm9=5.0 L_xm9=0.15
.param W_xm10=5.0 L_xm10=0.15
.param W_xm11=5.0 L_xm11=0.15
.param W_xm12=5.0 L_xm12=0.15
.param W_xm13=5.0 L_xm13=0.15
.param W_xm14=5.0 L_xm14=0.15
.param W_xm15=5.0 L_xm15=0.15
.param W_xm16=5.0 L_xm16=0.15

XM6 I_N Q_N N1 VSS sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}
XM14 I_N I_P N2 VSS sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM4 I_P I_N N2 VSS sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM3 I_P Q_P N1 VSS sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM9 Q_N I_P N3 VSS sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM2 Q_N Q_P N4 VSS sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM11 Q_P Q_N N4 VSS sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM1 Q_P I_N N3 VSS sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM8 N1 CLK_P N5 VSS sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM7 N2 CLK_N N5 VSS sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM12 N3 CLK_N N6 VSS sky130_fd_pr__nfet_01v8 l={L_xm12} w={W_xm12}
XM5 N4 CLK_P N6 VSS sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM15 N5 LOW_VT N7 VSS sky130_fd_pr__nfet_01v8 l={L_xm15} w={W_xm15}
XM13 N7 BIAS VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm13} w={W_xm13}
XM16 N6 LOW_VT N8 VSS sky130_fd_pr__nfet_01v8 l={L_xm16} w={W_xm16}
XM10 N8 BIAS VSS VSS sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}

* Load resistors (required for CML operation)
R1 I_P VDD 2k
R2 I_N VDD 2k
R3 Q_P VDD 2k
R4 Q_N VDD 2k

* Sources
VVDD VDD 0 1.8
VVSS VSS 0 0
VBIAS BIAS 0 0.9
VLOW_VT LOW_VT 0 1.5

* Clock inputs (2 GHz, 1.5V Common Mode, 0.6Vpp diff swing)
VCLK_P CLK_P 0 DC 1.5 SINE(1.5 0.3 2G)
VCLK_N CLK_N 0 DC 1.5 SINE(1.5 -0.3 2G)

* VCVS for differential output
E1 diff_out 0 Q_P Q_N 1.0

* Initial conditions to ensure startup
.ic v(Q_P)=1.8 v(Q_N)=1.2 v(I_P)=1.8 v(I_N)=1.2

.control
  * Transient analysis
  tran 2p 40n
  
  * Measure power (average current)
  meas tran avg_current avg i(VVDD) from=20n to=40n
  let power_consumption = -avg_current * 1.8
  print power_consumption
  
  * Measure output period and frequency
  meas tran out_period trig v(diff_out) val=0 rise=12 targ v(diff_out) val=0 rise=13
  let output_frequency = 1 / out_period
  print output_frequency
  
  * Measure output swing
  meas tran vmax max v(diff_out) from=20n to=40n
  meas tran vmin min v(diff_out) from=20n to=40n
  let output_voltage_swing = vmax - vmin
  print output_voltage_swing
  
  quit
.endc
.end