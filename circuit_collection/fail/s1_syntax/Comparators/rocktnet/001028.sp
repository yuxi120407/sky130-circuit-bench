* Continuous-Time Comparator Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_BAR=0.5
.param L_xm1=0.5
.param L_xm10=0.5
.param L_xm11=0.5
.param L_xm12=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm17=0.5
.param L_xm18=0.5
.param L_xm19=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5

* Adjusted W for CS NMOS to balance the 10uA current mirrors
.param W_xm12=5.0 L_xm12=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm10=5.0 L_xm10=0.5
.param W_xm4=10.0 L_xm4=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm5=10.0 L_xm5=0.5
.param W_xm18=5.0 L_xm18=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm19=5.0 L_xm19=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm3=10.0 L_xm3=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm8=10.0 L_xm8=0.5

XM12 N_BIAS N_BIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm12} w={W_xm12}
XM16 N_OUT1_L N_BIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}
XM15 N_TAIL1 N_BIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}
XM7 N_OUT1_R N_BIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM2 N_D1_L IN N_TAIL1 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM1 N_D1_R VLOW N_TAIL1 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM10 N_D1_L N_D1_L GND GND sky130_fd_pr__nfet_01v8 l={L_xm10} w={W_xm10}
XM4 N_OUT1_L N_D1_L GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM17 N_D1_R N_D1_R GND GND sky130_fd_pr__nfet_01v8 l={L_xm17} w={W_xm17}
XM5 N_OUT1_R N_D1_R GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM18 L N_BIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm18} w={W_xm18}
XM13 N_TAIL2 N_BIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM6 L_BAR N_BIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM14 N_D2_L N_OUT1_L N_TAIL2 VDD sky130_fd_pr__pfet_01v8 l={L_xm14} w={W_xm14}
XM19 N_D2_R N_OUT1_R N_TAIL2 VDD sky130_fd_pr__pfet_01v8 l={L_xm19} w={W_xm19}
XM11 N_D2_L N_D2_L GND GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM3 L N_D2_L GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM9 N_D2_R N_D2_R GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM8 L_BAR N_D2_R GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}

* Sources
VVDD VDD 0 1.8
VREF VLOW 0 0.9
IBIAS N_BIAS 0 10u
VIN IN 0 DC 0.9 PULSE(0.8 1.0 2n 0.1n 0.1n 5n 10n)

.control
  * 1. Operating Point & Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. DC Sweep for Transfer Curve, Offset, and Gain
  dc VIN 0.85 0.95 10u
  meas dc vth_L when v(L)=0.9
  let offset = vth_L - 0.9
  print offset
  let gain_dc = deriv(v(L))
  meas dc max_gain max gain_dc

  * 3. Transient Analysis for Delay and Swing
  tran 10p 15n
  meas tran tpd_rise trig v(IN) val=0.9 rise=1 targ v(L) val=0.9 rise=1
  meas tran tpd_fall trig v(IN) val=0.9 fall=1 targ v(L) val=0.9 fall=1
  let tpd_avg = (tpd_rise + tpd_fall) / 2
  print tpd_avg
  meas tran vout_max max v(L)
  meas tran vout_min min v(L)
  
  quit
.endc
.end
