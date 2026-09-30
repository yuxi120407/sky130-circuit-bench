* Line Driver Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Parameters
.param R_val=1k

* DUT
X1 N2 Vref1 VSLD VSLD sky130_fd_pr__pfet_01v8 w=10.0 l=0.5
X2 N3 Vref2 GND GND sky130_fd_pr__nfet_01v8 w=5.0 l=0.5
X3 GND IN N2 VSLD sky130_fd_pr__pfet_01v8 w=20.0 l=0.15
X4 VSLD IN N3 GND sky130_fd_pr__nfet_01v8 w=10.0 l=0.15
X5 N5 N2 OUT GND sky130_fd_pr__nfet_01v8 w=20.0 l=0.15
X6 N6 N3 OUT VSLD sky130_fd_pr__pfet_01v8 w=40.0 l=0.15
X7 N5 N5 VSLD VSLD sky130_fd_pr__pfet_01v8 w=40.0 l=0.15
X8 OUT N5 VSLD VSLD sky130_fd_pr__pfet_01v8 w=40.0 l=0.15
X9 N6 N6 GND GND sky130_fd_pr__nfet_01v8 w=20.0 l=0.15
X10 OUT N6 GND GND sky130_fd_pr__nfet_01v8 w=20.0 l=0.15

* Sources
VSLD VSLD 0 1.8
VVREF1 Vref1 0 0.9
VVREF2 Vref2 0 0.9
VIN IN 0 DC 0.9 AC 1 SIN(0.9 0.1 1MEG 0 0)

* Load
RL OUT 0 1k

* Control Block
.control
  * DC Operating Point and Power
  op
  let supply_voltage = 1.8
  let power_consumption = -i(VSLD) * 1.8
  print supply_voltage
  print power_consumption

  * AC Analysis for Gain and Bandwidth
  ac dec 100 1 10G
  let gain_db = vdb(OUT)
  meas ac voltage_gain find gain_db at=10k
  let target_gain = voltage_gain - 3
  meas ac bandwidth when gain_db=$&target_gain fall=1
  print voltage_gain
  print bandwidth

  * Transient Analysis for Output Swing
  tran 10n 5u
  meas tran v_max max v(OUT)
  meas tran v_min min v(OUT)
  let v_peak = (v_max - v_min) / 2
  let v_rms = v_peak / 1.41421356
  let p_out_w = (v_rms * v_rms) / 1000
  let output_power = 10 * log10(p_out_w * 1000)
  print output_power
  
  quit
.endc
.end