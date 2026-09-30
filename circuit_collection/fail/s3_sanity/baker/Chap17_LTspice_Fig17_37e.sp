* Delta-Sigma Modulator Sensing Circuit for CMOS Imager (Fig. 17.36)
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

VDD vdd 0 1.8
VIN vin 0 PULSE(0 1.8 0 1n 1n 49n 100n) AC 1
VREF vref 0 1.8
VCLK clk 0 PULSE(0 1.8 0 1n 1n 49n 100n)

I1 shifted_ref 0 1u
V2 out 0 0

* Hold cap
Chold hold_node 0 1p
Rhold vin hold_node 1k

* Shifted reference
XM1 shifted_ref vdd vref 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.15

* Switched cap
Csw sw_node 0 1p
Rsw vref sw_node 1k

* Comparator dummy
XM2 out clk sw_node 0 sky130_fd_pr__nfet_01v8 w=5.0 l=0.15

.control
  noise v(hold_node) VIN dec 10 1 10G
  setplot noise2
  let thermal_noise_hold_cap = onoise_total
  print thermal_noise_hold_cap

  tran 1n 1000n
  
  meas tran shifted_reference_voltage avg v(shifted_ref) from=100n to=900n
  
  meas tran vref_avg avg v(vref) from=100n to=900n
  
  let voltage_resolution = vref_avg / 256
  print voltage_resolution
  
  let switched_capacitor_resistance = 100e-9 / 1e-12
  print switched_capacitor_resistance
  
  meas tran sensed_signal_voltage avg v(hold_node) from=100n to=900n
  
  let p_inst = -(i(VDD)*1.8 + i(VREF)*1.8 + i(VIN)*v(vin) + i(VCLK)*v(clk))
  meas tran average_power avg p_inst from=100n to=900n
  print average_power
.endc
.end