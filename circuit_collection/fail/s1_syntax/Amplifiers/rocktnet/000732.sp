* Active Pseudo-Resistor Amplifier Core Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5
.param L_xm4=0.5

* Parameters from netlist
.param W_xm3=5.0 L_xm3=0.5
.param W_xm4=5.0 L_xm4=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm1=5.0 L_xm1=0.5

* DUT
XM3 VE II VSS GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}
XM4 VE II VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm4} w={W_xm4}
XM2 VDD VE II GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM1 VSS VE II VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}

* Sources
VVDD VDD 0 1.8
VVSS VSS 0 0
VGND GND 0 0

* Input Current Source for AC and DC sweep
* AC 1A allows direct reading of transimpedance (Ohms) as voltage magnitude
Iin II 0 DC 0 AC 1

.control
  * 1. Operating Point
  op
  let v_trip = v(II)
  let pwr = -i(VVDD) * 1.8
  print v_trip pwr
  
  * 2. AC Analysis
  ac dec 10 1m 1G
  * Inverter Gain = v(VE) / v(II)
  let inv_gain = mag(v(VE)) / mag(v(II))
  let inv_gain_db = 20 * log10(inv_gain)
  * Effective Resistance = v(VE) / Iin = v(VE) (since Iin=1)
  let r_eq = mag(v(VE))
  
  meas ac dc_inv_gain_db find inv_gain_db at=1m
  meas ac dc_r_eq find r_eq at=1m
  meas ac r_eq_1k find r_eq at=1k
  
  * 3. DC Sweep (Large Signal Non-linear Resistance)
  dc Iin -1u 1u 10n
  meas dc v_ve_plus find v(VE) at=1u
  meas dc v_ve_minus find v(VE) at=-1u
  
  quit
.endc
.end