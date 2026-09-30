* Dual-Loop VCO Delay Cell Testbench
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
.param W_xm8=5.0 L_xm8=0.5
.param W_xm7=5.0 L_xm7=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm3=5.0 L_xm3=0.5

* DUT
XM1 N0 VIN1_PLUS GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 VIN1_MINUS GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM8 N2 VCONT N1 GND sky130_fd_pr__nfet_01v8 l={L_xm8} w={W_xm8}
XM7 N0 VCONT N4 GND sky130_fd_pr__nfet_01v8 l={L_xm7} w={W_xm7}
XM5 N0 LABEL_NET_2 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 N2 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}
XM4 N2 VIN2_PLUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM3 N0 VIN2_MINUS VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}

* Fix for cross-coupled PMOS gate connection and floating varactor nodes
Vshort LABEL_NET_2 N2 0
RN1 N1 0 1G
RN4 N4 0 1G

* Biasing and Supplies
VVDD VDD 0 1.8
VVCONT VCONT 0 0.9

* Inputs
VVIN1_PLUS VIN1_PLUS 0 DC 0.9 AC 1 PULSE(0 1.8 1n 50p 50p 1n 2n)
VVIN1_MINUS VIN1_MINUS 0 DC 0.9 AC -1 PULSE(1.8 0 1n 50p 50p 1n 2n)
VVIN2_PLUS VIN2_PLUS 0 DC 0.9
VVIN2_MINUS VIN2_MINUS 0 DC 0.9

* Load Capacitance
Cload1 N0 0 10f
Cload2 N2 0 10f

.control
  * 1. DC Operating Point & Power
  op
  let power = -i(VVDD) * 1.8
  print power

  * 2. AC Analysis for Voltage Gain
  ac dec 50 1Meg 10G
  let gain_db = vdb(N0)
  meas ac dc_gain find gain_db at=1Meg
  meas ac bw_3db when gain_db=(dc_gain-3) fall=1

  * 3. Transient Analysis for Propagation Delay (VCONT = 0.9V)
  tran 10p 5n
  meas tran td_fall trig v(VIN1_PLUS) val=0.9 rise=1 targ v(N0) val=0.9 fall=1
  meas tran td_rise trig v(VIN1_PLUS) val=0.9 fall=1 targ v(N0) val=0.9 rise=1

  * 4. Transient Analysis for Tuning Range (VCONT = 1.8V)
  alter VVCONT = 1.8
  tran 10p 5n
  meas tran td_fall_tune trig v(VIN1_PLUS) val=0.9 rise=1 targ v(N0) val=0.9 fall=1
  
  quit
.endc
.end