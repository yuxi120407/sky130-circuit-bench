* VCSEL Driver Bias Fragment Testbench

* Define dummy diode models to match the node names used as missing model parameters in the netlist
.model N1 D
.model N2 D
.model N3 D
.model N4 D
.model N6 D

* --- DUT (Extracted Netlist) ---
D3 +5V N1
D1 N1 N2
D4 N2 N3
D2 N3 N4
D5 +5V N6
R1 N7 GND 2.75k
R4 N8 GND 2.75k
R2 N9 GND 1k
R3 N10 GND 1k
* -------------------------------

* Power Supply
Vdd +5V GND 1.8V

* Test voltages for the disconnected resistors
Vn7 N7 GND 1.8V
Vn8 N8 GND 1.8V
Vn9 N9 GND 1.8V
Vn10 N10 GND 1.8V

* High-value resistors to prevent singular matrix / floating node errors
R_dummy_N4 N4 GND 1G
R_dummy_N6 N6 GND 1G

.control
  op
  
  * Calculate power from the main supply
  let power_vdd = -i(Vdd) * 1.8
  
  * Calculate power dissipated in the resistors
  let power_res = (-i(Vn7) + -i(Vn8) + -i(Vn9) + -i(Vn10)) * 1.8
  
  let total_power = power_vdd + power_res
  
  print power_vdd
  print power_res
  print total_power
  
  quit
.endc
.end