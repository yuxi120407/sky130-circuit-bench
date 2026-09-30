* PMOS Current Mirror Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

* Supply and Bias
VVDD VDD 0 1.8
V_N4 N4 VDD 0
V_diode N0 N1 0
Iref N0 0 10u

* Output Voltage Sources (used as ammeters and to set Vd)
V_N2 N2 0 0.9
V_N3 N3 0 0.9

* DUT
XM1 N3 N1 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}
XM2 N2 N1 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}
XM3 N0 N1 N4 VDD sky130_fd_pr__pfet_01v8 l={L_xm3} w={W_xm3}

.control
  * 1. Operating Point Analysis for Current Ratio and Power
  op
  let i_in = 10u
  let i_out1 = i(V_N2)
  let i_out2 = i(V_N3)
  let ratio1 = i_out1 / i_in
  let ratio2 = i_out2 / i_in
  let power = -i(VVDD) * 1.8
  print ratio1 ratio2 power

  * 2. DC Sweep for Output Resistance and Vdsat
  dc V_N2 0 1.8 0.01
  let i_out_dc = i(V_N2)
  
  * Calculate Rout using two points in the saturation region
  meas dc i_out_800m find i_out_dc at=0.8
  meas dc i_out_1000m find i_out_dc at=1.0
  let rout_approx = 0.2 / (i_out_800m - i_out_1000m)
  print rout_approx
  
  * Find Vdsat (defined here as the Vsd where current drops to 90% of nominal 10uA)
  meas dc v_n2_sat when i_out_dc=9u fall=1
  let vdsat = 1.8 - v_n2_sat
  print vdsat
  
  quit
.endc
.end
