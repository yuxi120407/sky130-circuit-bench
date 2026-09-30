* CML XNOR Phase Detector Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.param W_xm1=5.0
.param W_xm2=5.0
.param W_xm3=5.0
.param W_xm4=5.0
.param W_xm5=5.0
.param W_xm6=5.0

VVDD VDD 0 1.8
* Using a tail resistor instead of ideal current source to prevent negative infinity voltages when the asymmetric path is blocked
R_tail N3 0 600

* Output load resistors
R_out1 VDD N0 1k
R_out2 VDD N2 1k
* Short outputs together for XNOR function
R_short N0 N2 1m

* Inputs (1 GHz, 1ns period)
* Clock inputs
VCLK LABEL_NET_3 0 PULSE(0.6 1.2 0 50p 50p 400p 1n)
VCLK_B LABEL_NET_5 0 PULSE(1.2 0.6 0 50p 50p 400p 1n)

* Data inputs (90 degree phase shift = 250ps delay)
VDATA LABEL_NET_0 0 PULSE(0.6 1.2 250p 50p 50p 400p 1n)
VDATA_B LABEL_NET_4 0 PULSE(1.2 0.6 250p 50p 50p 400p 1n)
VLABEL_NET_1 LABEL_NET_1 0 PULSE(0.6 1.2 250p 50p 50p 400p 1n)

* DUT
XM1 N0 LABEL_NET_0 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 VDD LABEL_NET_1 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 VDD N1 N1 GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 N1 LABEL_NET_3 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm4} w={W_xm4}
XM5 N2 LABEL_NET_4 N4 GND sky130_fd_pr__nfet_01v8 l={L_xm5} w={W_xm5}
XM6 N4 LABEL_NET_5 N3 GND sky130_fd_pr__nfet_01v8 l={L_xm6} w={W_xm6}

.control
  tran 5p 5n
  
  meas tran v_max max v(N0) from=2n to=5n
  meas tran v_min min v(N0) from=2n to=5n
  let v_swing = v_max - v_min
  print v_swing
  
  meas tran v_avg avg v(N0) from=2n to=5n
  print v_avg
  
  * Measure rise time (using 1.73V and 1.79V which are within the 1.71V-1.81V swing)
  meas tran t_rise trig v(N0) val=1.73 rise=2 targ v(N0) val=1.79 rise=2
  print t_rise
  
  * Measure power by averaging transient current
  meas tran i_avg avg i(VVDD) from=2n to=5n
  let power = -i_avg * 1.8
  print power
  
  quit
.endc
.end