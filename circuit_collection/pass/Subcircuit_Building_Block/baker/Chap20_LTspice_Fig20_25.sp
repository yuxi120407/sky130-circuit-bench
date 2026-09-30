* Testbench for Baker Fig. 20.11a & Fig. 20.25 PMOS Current Mirror
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm1=10.0 L_xm1=0.5
.param W_xm2=10.0 L_xm2=0.5

VDD vdd 0 DC 1.8
IREF vref 0 DC 10u
VOUT vout 0 DC 0

XM1 vref vref vdd vdd sky130_fd_pr__pfet_01v8 w={W_xm1} l={L_xm1}
XM2 vout vref vdd vdd sky130_fd_pr__pfet_01v8 w={W_xm2} l={L_xm2}

.control
  op
  let vsg_nominal = v(vdd) - v(vref)
  let output_current = abs(i(VOUT))
  let current_ratio = output_current / 10u
  print vsg_nominal output_current current_ratio

  dc VDD 1.7 1.9 0.01
  meas dc iout_17 find i(VOUT) at=1.7
  meas dc iout_19 find i(VOUT) at=1.9
  let supply_sensitivity = (abs(iout_19) - abs(iout_17)) / 0.2
  print supply_sensitivity

  dc temp 0 100 1
  meas dc vref_0 find v(vref) at=0
  meas dc vref_100 find v(vref) at=100
  let temp_coeff_vsg = (vref_0 - vref_100) / 100
  
  meas dc iout_0 find i(VOUT) at=0
  meas dc iout_100 find i(VOUT) at=100
  let temp_coeff_io = (abs(iout_100) - abs(iout_0)) / 100
  
  print temp_coeff_vsg temp_coeff_io
.endc
.end