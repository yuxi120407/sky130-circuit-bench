* Testbench for Mixed-Signal Multiplier / FIR Tap
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
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5

XM1 N2 N3 0 0 sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N4 N0 0 0 sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 LABEL_NET_0 N3 0 sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N5 N0 N1 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 N4 0 0 sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 N1 LABEL_NET_2 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 N5 N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 LABEL_NET_4 N4 0 sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 0.9
VLABEL_NET_2 LABEL_NET_2 0 0.9
VLABEL_NET_4 LABEL_NET_4 0 0.9

* 200 MHz input signal
VIN N0 0 PULSE(0 1.8 0 100p 100p 2.4n 5n)

* High-value resistor to prevent floating node errors on the synapse floating gate
R_N5 N5 0 1G

.control
  tran 10p 20n
  
  * Measure average power
  let inst_power = -i(VVDD)*1.8 - i(VLABEL_NET_0)*0.9 - i(VLABEL_NET_2)*0.9 - i(VLABEL_NET_4)*0.9
  meas tran power_consumption avg inst_power from=5n to=20n
  
  * Measure operating frequency
  meas tran t_period trig v(N0) val=0.9 rise=1 targ v(N0) val=0.9 rise=2
  let operating_frequency = 1 / t_period
  
  * Measure voltage swing at N4
  meas tran v_n4_max max v(N4) from=5n to=20n
  meas tran v_n4_min min v(N4) from=5n to=20n
  let voltage_swing_n4 = v_n4_max - v_n4_min
  
  print power_consumption operating_frequency voltage_swing_n4
  quit
.endc
.end