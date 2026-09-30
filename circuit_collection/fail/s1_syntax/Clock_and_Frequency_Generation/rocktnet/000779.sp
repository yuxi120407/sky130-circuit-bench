* VCO Performance Testbench
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm9=5.0 L_xm9=0.5
.param W_xm_t=5.0 L_xm_t=0.5
.param W_xm11=5.0 L_xm11=0.5
.param W_xm_1=5.0 L_xm_1=0.5
.param W_xm13=5.0 L_xm13=0.5
.param W_xm14=5.0 L_xm14=0.5
.param W_xm15=5.0 L_xm15=0.5
.param W_xm16=5.0 L_xm16=0.5
.param W_xm17=5.0 L_xm17=0.5
.param W_xm18=5.0 L_xm18=0.5
.param W_xm19=5.0 L_xm19=0.5
.param W_xm20=5.0 L_xm20=0.5
.param W_xm21=5.0 L_xm21=0.5

XM1 N0 N3 N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 N8 N12 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N2 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N11 N4 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 VBIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N6 N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N1 VEA N5 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM9 N0 N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM_T N6 N2 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm_t} w={W_xm_t}
XM11 N4 N10 V_C GND sky130_fd_pr__nfet_01v8 l={L_xm11} w={W_xm11}
XM_1 V_C V_C GND GND sky130_fd_pr__nfet_01v8 l={L_xm_1} w={W_xm_1}
XM13 V_C N6 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm13} w={W_xm13}
XM14 N11 N4 V_C GND sky130_fd_pr__nfet_01v8 l={L_xm14} w={W_xm14}
XM15 N10 N8 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm15} w={W_xm15}
XM16 N4 N10 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm16} w={W_xm16}
XM17 N5 VBIAS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm17} w={W_xm17}
XM18 N10 N8 V_C GND sky130_fd_pr__nfet_01v8 l={L_xm18} w={W_xm18}
XM19 N8 N12 V_C GND sky130_fd_pr__nfet_01v8 l={L_xm19} w={W_xm19}
XM20 N12 N11 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm20} w={W_xm20}
XM21 N12 N11 V_C GND sky130_fd_pr__nfet_01v8 l={L_xm21} w={W_xm21}

* DC Sources
VVDD VDD 0 1.8
VVBIAS VBIAS 0 0.99
VVEA VEA 0 0.9

* Missing load resistor for the source follower (XM_T) to establish V-to-I conversion
R_N3 N3 0 10k

* Behavioral source to create a robust zero-crossing signal for frequency measurement
B1 n_zero 0 V=V(n10)-0.5*V(V_C)-0.9

* Initial conditions to kickstart the ring oscillator
.ic v(n10)=0 v(n8)=1.8 v(n12)=0 v(n11)=1.8 v(n4)=0

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm11=0.5
.param L_xm13=0.5
.param L_xm14=0.5
.param L_xm15=0.5
.param L_xm16=0.5
.param L_xm17=0.5
.param L_xm18=0.5
.param L_xm19=0.5
.param L_xm2=0.5
.param L_xm20=0.5
.param L_xm21=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5
.param L_xm7=0.5
.param L_xm8=0.5
.param L_xm9=0.5
.param L_xm_1=0.5
.param L_xm_t=0.5

.control
  * 1. Center Frequency and Power (VEA = 0.9V)
  tran 100p 500n
  meas tran t_period trig v(n_zero) val=0 rise=3 targ v(n_zero) val=0 rise=4
  let freq_mid = 1 / t_period
  print freq_mid
  
  let pwr = -i(VVDD)*1.8
  meas tran power_avg avg pwr from=100n to=500n
  print power_avg

  * 2. Low VEA (VEA = 0.6V) -> Higher Frequency
  alter VVEA 0.6
  tran 100p 500n
  meas tran t_period_low trig v(n_zero) val=0 rise=3 targ v(n_zero) val=0 rise=4
  let freq_high = 1 / t_period_low
  print freq_high

  * 3. High VEA (VEA = 1.2V) -> Lower Frequency
  alter VVEA 1.2
  tran 100p 500n
  meas tran t_period_high trig v(n_zero) val=0 rise=3 targ v(n_zero) val=0 rise=4
  let freq_low = 1 / t_period_high
  print freq_low

  * Calculate Kvco and Tuning Range
  let kvco = (freq_low - freq_high) / (1.2 - 0.6)
  print kvco
  
  let tuning_range = freq_high - freq_low
  print tuning_range
  
  quit
.endc
.end
