* Charge Pump Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Input Supply (Ramped to ensure 0V startup for rise_time measurement)
V1 n4 GND PWL(0 0 1n 1.8)

* Clocks (Connected to floating nodes to fix singular matrix and provide pumping)
Vclk1 n0 GND PULSE(0 1.8 0 1n 1n 48n 100n)
Vclk2 n3 GND PULSE(0 1.8 50n 1n 1n 48n 100n)
Vclk3 n2 GND DC 0

* DUT (Modified 'S' to 'X' for ngspice compatibility, as 'S' requires 4 nodes)
C1 n0 n5 20p
C2 n3 n6 20p
C3 n1 n2 20p
C4 n7 n9 20p
R1 n1 n8 1k
X1 n4 n5 switch_ideal
X2 n6 n8 switch_ideal
X3 n3 n12 switch_ideal
X4 n3 n7 switch_ideal
X5 n0 n10 switch_ideal
X6 n0 n4 switch_ideal
X7 n9 n11 switch_ideal
X8 n4 n9 switch_ideal
X9 n5 n6 switch_ideal
X10 n4 n7 switch_ideal
C5 n11 GND 20p
C6 n10 GND 20p
C7 n2 n1 20p
C8 n12 GND 20p

* Load Resistor to draw current and measure efficiency
Rload n1 GND 100k

* Ideal Switch Subcircuit (Modeled as a Diode for self-starting pumping)
.subckt switch_ideal n1 n2
D1 n1 n2 D_ideal
.ends
.model D_ideal D(Is=1e-12 Rs=10)

.control
  * Run transient analysis for 100us to reach steady state
  tran 1n 100u
  
  * Output Voltage and Ripple Metrics
  meas tran vout_max max v(n1) from=80u to=100u
  meas tran vout_min min v(n1) from=80u to=100u
  meas tran vout_avg avg v(n1) from=80u to=100u
  let output_ripple = vout_max - vout_min
  print output_ripple
  
  * Voltage Gain
  let voltage_gain = vout_avg / 1.8
  print voltage_gain
  
  * Power and Efficiency
  let p_in_vec = -v(n4)*i(V1) - v(n0)*i(Vclk1) - v(n3)*i(Vclk2)
  meas tran p_in_avg avg p_in_vec from=80u to=100u
  let p_out = (vout_avg * vout_avg) / 100000
  let efficiency = (p_out / (p_in_avg + 1e-12)) * 100
  print efficiency
  
  * Rise Time (Time to reach 90% of steady-state)
  let vout_90 = vout_avg * 0.9
  meas tran rise_time when v(n1)=$&vout_90 rise=1
  print rise_time
  
  quit
.endc
.end