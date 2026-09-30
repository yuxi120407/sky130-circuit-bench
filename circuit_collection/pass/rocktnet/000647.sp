* PMOS Current Mirror Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

XM1 N3 N3 N8 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N5 N3 N8 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}

VVDD VDD 0 1.8
VN8 N8 VDD 0
IREF N3 0 10u
VOUT N5 0 0.9

.control
  op
  let iref = 10u
  let iout = i(VOUT)
  let current_ratio = iout / iref
  print current_ratio

  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  dc VOUT 0 1.8 0.01
  meas dc iout_900m find i(VOUT) at=0.9
  meas dc iout_1000m find i(VOUT) at=1.0
  let output_resistance = -0.1 / (iout_1000m - iout_900m)
  print output_resistance
  
  let target_iout = iout_900m * 0.95
  meas dc vmax_compliance when i(VOUT)=target_iout
  print vmax_compliance
  quit
.endc
.end