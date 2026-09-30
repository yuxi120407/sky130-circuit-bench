* Dynamic Logic Buffer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.15
.param L_xm2=0.15
.param L_xm3=0.15
.param L_xm4=0.15

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0

* DUT
XM1 N0 LABEL_NET_0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N1 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N1 LABEL_NET_1 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N0 LABEL_NET_2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}

* Sources
VVDD VDD 0 1.8

* CLK (LABEL_NET_0) - Precharge when low (400 MHz)
VCLK LABEL_NET_0 0 PULSE(0 1.8 1.25n 20p 20p 1.21n 2.5n)

* CLK_B (LABEL_NET_1) - Pre-discharge N1 when high
VCLKB LABEL_NET_1 0 PULSE(1.8 0 1.25n 20p 20p 1.21n 2.5n)

* IN (LABEL_NET_2) - High during first evaluate phase, Low during second
VIN LABEL_NET_2 0 PULSE(0 1.8 1.3n 20p 20p 1.0n 5.0n)

* Load Capacitance
Cload1 N0 0 10f
Cload2 N1 0 10f

.control
  tran 10p 6n

  * Measure Voltage Swing
  meas tran v_max max v(N1)
  meas tran v_min min v(N1)
  let voltage_swing = v_max - v_min
  print voltage_swing

  * Measure Delay (IN to N1 during evaluate)
  meas tran propagation_delay trig v(LABEL_NET_2) val=0.9 rise=1 targ v(N1) val=0.9 rise=1
  print propagation_delay

  * Measure Rise Time of N1
  meas tran rise_time trig v(N1) val=0.36 rise=1 targ v(N1) val=1.44 rise=1
  print rise_time

  * Measure Power
  meas tran pwr_avg avg i(VVDD) from=0 to=5n
  let power_consumption = -pwr_avg * 1.8
  print power_consumption

  quit
.endc
.end