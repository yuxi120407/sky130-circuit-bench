* PMOS Current Mirror Testbench
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5

XM1 N0 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N6 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 N4 N1 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}

VVDD VDD 0 1.8
Vshort N0 N1 0
Iref N0 0 10u

V2 N2 0 0.9 ac 1
V3 N6 0 0.9
V4 N4 0 0.9

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.control
  op
  let supply_voltage = 1.8
  let power_consumption = abs(i(VVDD) * 1.8)
  let i_ref = 10e-6
  let i_out2 = abs(i(V2))
  let current_matching_error = (i_out2 - i_ref) / i_ref * 100
  let efficiency = 100 * (abs(i(V2)) + abs(i(V3)) + abs(i(V4))) / abs(i(VVDD))
  
  print supply_voltage power_consumption current_matching_error efficiency
  
  dc V2 0 1.8 0.01
  meas dc i_800 find i(V2) at=0.8
  meas dc i_1000 find i(V2) at=1.0
  let output_resistance = 0.2 / abs($&i_1000 - $&i_800)
  print output_resistance
  
  ac dec 10 1 1G
  let vout_db = vdb(N2)
  meas ac gain max vout_db
  print gain
  
  quit
.endc
.end