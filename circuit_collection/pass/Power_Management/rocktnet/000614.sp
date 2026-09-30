* Charge Pump Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm10=0.5
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
.param W_xm10=5.0 L_xm10=0.5

XM1 N3 UP_BAR VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N7 GND VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 OUT N2 N5 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 N0 N6 VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N5 DOWN GND GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 OUT N3 UP_BAR VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM7 N1 N3 N7 VDD sky130_fd_pr__pfet_01v8 l={L_xm7} w={W_xm7}
XM8 N8 VDD GND GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM9 N1 N2 N8 GND sky130_fd_pr__nfet_01v8 l={L_xm9} w={W_xm9}
XM10 N6 GND VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm10} w={W_xm10}

* Fix floating node (connect N1 to N3 to close the current mirror diode connection)
Vfix N1 N3 0

VVDD VDD 0 1.8
VBIAS N2 0 0.75
VOUT OUT 0 0.9

VUP UP_BAR 0 dc 0 pulse(0 1.8 10n 1n 1n 30n 100n)
VDOWN DOWN 0 dc 0 pulse(0 1.8 60n 1n 1n 30n 100n)

.control
  * 1. Transient Analysis for Currents and Power
  tran 1n 100n
  meas tran i_up_raw avg i(VOUT) from=20n to=30n
  meas tran i_down_raw avg i(VOUT) from=70n to=80n
  meas tran i_leak avg i(VOUT) from=2n to=8n
  meas tran pwr_avg avg i(VVDD) from=0 to=100n
  
  let i_up = i_up_raw
  let i_down = -i_down_raw
  let i_avg = (i_up + i_down) / 2
  let mismatch = abs(i_up - i_down) / i_avg * 100
  let power = -pwr_avg * 1.8
  print i_up i_down mismatch i_leak power

  * 2. DC Sweep for UP compliance
  alter VUP 1.8
  alter VDOWN 0
  dc VOUT 0 1.8 0.01
  meas dc i_up_0v4 find i(VOUT) at=0.4
  meas dc i_up_0v9 find i(VOUT) at=0.9
  meas dc i_up_1v4 find i(VOUT) at=1.4
  
  * 3. DC Sweep for DOWN compliance
  alter VUP 0
  alter VDOWN 1.8
  dc VOUT 0 1.8 0.01
  meas dc i_down_0v4 find i(VOUT) at=0.4
  meas dc i_down_0v9 find i(VOUT) at=0.9
  meas dc i_down_1v4 find i(VOUT) at=1.4
.endc
.end