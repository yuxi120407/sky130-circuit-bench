* PMOS Current Mirror Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm4=0.5
.param L_xm5=0.5

.param W_xm4=5.0 L_xm4=0.5
.param W_xm5=5.0 L_xm5=0.5

XM4 N0 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM5 N3 N0 VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm5} w={W_xm5}

VVDD VDD 0 1.8
Iref N0 0 1u
* Voltage source to set Vout and measure Iout
Vout N3 0 0.9

.control
  * Sweep output voltage to measure output resistance
  dc Vout 0 1.8 0.01
  
  * Measure currents at different output voltages
  meas dc iout_08 find i(Vout) at=0.8
  meas dc iout_10 find i(Vout) at=1.0
  meas dc iout_nom find i(Vout) at=0.9
  meas dc ivdd_nom find i(VVDD) at=0.9
  
  * Calculate metrics
  * Note: i(Vout) decreases as Vout increases (Vds becomes less negative), so iout_08 > iout_10
  let rout = 0.2 / (iout_08 - iout_10)
  let current_ratio = iout_nom / 1u
  let power = -ivdd_nom * 1.8
  
  print rout current_ratio power
  quit
.endc
.end
