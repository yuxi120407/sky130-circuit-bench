* Charge Pump Testbench
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3p=5.0 L_xm3p=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm5cas=5.0 L_xm5cas=0.5
.param W_xmr1=5.0 L_xmr1=0.5
.param W_xm8=5.0 L_xm8=0.5
.param W_xm1=5.0 L_xm1=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm6p=5.0 L_xm6p=0.5
.param W_xm4cas=5.0 L_xm4cas=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm8p=5.0 L_xm8p=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm7p=5.0 L_xm7p=0.5

* DUT
XM2 OUT N2 LABEL_NET_0 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3P N1 N1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3p} w={W_xm3p}
XM5 N9 R1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM5CAS N8 R2 N9 GND sky130_fd_pr__nfet_01v8 l={L_xm5cas} w={W_xm5cas}
XMR1 N4 OUT GND GND sky130_fd_pr__nfet_01v8 l={L_xmr1} w={W_xmr1}
XM8 N8 UP_B N2 VDD sky130_fd_pr__pfet_01v8 l={L_xm8} w={W_xm8}
XM1 OUT N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM7 N6 DOWN N3 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM6P N0 N0 LABEL_NET_6 VDD sky130_fd_pr__pfet_01v8 l={L_xm6p} w={W_xm6p}
XM4CAS N6 R3 N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm4cas} w={W_xm4cas}
XM4 N7 R4 GND VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM8P N8 UP N0 VDD sky130_fd_pr__pfet_01v8 l={L_xm8p} w={W_xm8p}
XM6 N2 N2 LABEL_NET_10 VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM3 N3 N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM7P N6 DOWN_B N1 GND sky130_fd_pr__nfet_01v8 l={L_xm7p} w={W_xm7p}

* Power Supplies
VVDD VDD 0 1.8
VLABEL_NET_0 LABEL_NET_0 0 1.8
VLABEL_NET_6 LABEL_NET_6 0 1.8
VLABEL_NET_10 LABEL_NET_10 0 1.8

* Bias Voltages
VR1 R1 0 0.65
VR2 R2 0 1.2
VR3 R3 0 0.4
VR4 R4 0 0.94
VN4 N4 0 0

* Input Signals (PULSE for Tran, overridden by alter for DC)
VUP UP 0 PULSE(0 1.8 10n 100p 100p 20n 100n)
VUP_B UP_B 0 PULSE(1.8 0 10n 100p 100p 20n 100n)
VDOWN DOWN 0 PULSE(0 1.8 50n 100p 100p 20n 100n)
VDOWN_B DOWN_B 0 PULSE(1.8 0 50n 100p 100p 20n 100n)

* Output Voltage Source (Holds OUT at VDD/2 for current measurement)
VOUT OUT 0 0.9

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm3p=0.5
.param L_xm4=0.5
.param L_xm4cas=0.5
.param L_xm5=0.5
.param L_xm5cas=0.5
.param L_xm6=0.5
.param L_xm6p=0.5
.param L_xm7=0.5
.param L_xm7p=0.5
.param L_xm8=0.5
.param L_xm8p=0.5
.param L_xmr1=0.5

.control
  * 1. Transient Analysis for Dynamic Switching
  tran 100p 100n
  let i_out_tran = i(VOUT)
  meas tran i_up_dyn max i_out_tran from=15n to=25n
  meas tran i_down_dyn min i_out_tran from=55n to=65n
  
  * 2. DC Sweep for UP Current and Compliance
  alter VUP = 1.8
  alter VUP_B = 0
  alter VDOWN = 0
  alter VDOWN_B = 1.8
  dc VOUT 0 1.8 0.01
  let i_up_curve = i(VOUT)
  meas dc i_up_900m find i_up_curve at=0.9
  let i_up_90pct = i_up_900m * 0.9
  meas dc vcomp_up_max when i_up_curve=i_up_90pct
  
  * 3. DC Sweep for DOWN Current and Compliance
  alter VUP = 0
  alter VUP_B = 1.8
  alter VDOWN = 1.8
  alter VDOWN_B = 0
  dc VOUT 0 1.8 0.01
  let i_down_curve = -i(VOUT)
  meas dc i_down_900m find i_down_curve at=0.9
  let i_down_90pct = i_down_900m * 0.9
  meas dc vcomp_down_min when i_down_curve=i_down_90pct
  
  * 4. DC Sweep for Leakage Current
  alter VUP = 0
  alter VUP_B = 1.8
  alter VDOWN = 0
  alter VDOWN_B = 1.8
  dc VOUT 0 1.8 0.01
  let i_leak_curve = abs(i(VOUT))
  meas dc i_leak_900m find i_leak_curve at=0.9
  
  * 5. Calculate Mismatch
  let mismatch_pct = abs(i_up_900m - i_down_900m) / ((i_up_900m + i_down_900m) / 2) * 100
  
  * Print Results
  print i_up_900m i_down_900m mismatch_pct i_leak_900m vcomp_up_max vcomp_down_min
.endc
.end
