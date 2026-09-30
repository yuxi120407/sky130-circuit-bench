* PMOS Current Mirror Testbench
.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5
.param W_xm6=5.0 L_xm6=0.5

XM1 OUT IN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 OUT IN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 IN IN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}
XM4 OUT IN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 OUT IN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}
XM6 IN IN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm6} w={W_xm6}

VVDD VDD 0 1.8
VIN IN 0 DC 0.9
VOUT OUT 0 DC 0.9

.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5
.param L_xm5=0.5
.param L_xm6=0.5

.control
  op
  let i_in = i(VIN)
  let i_out = i(VOUT)
  let current_ratio = i_out / i_in
  let power_consumption = -i(VVDD) * 1.8
  print current_ratio power_consumption

  dc VOUT 0 1.8 0.01
  let i_out_dc = i(VOUT)
  let rout = -1 / deriv(i_out_dc)
  meas dc output_resistance find rout at=0.9
  
  meas dc iout_nom find i_out_dc at=0.9
  let iout_95 = iout_nom * 0.95
  meas dc compliance_voltage when i_out_dc="$&iout_95"
  
  quit
.endc
.end