* Single NMOS Characterization Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

* DUT
.param W_xm1=5.0 L_xm1=0.5
XM1 N1 LABEL_NET_0 N0 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* Sources
Vgs LABEL_NET_0 0 0.9
Vds N1 0 1.8
Vss N0 0 0

.control
  * 1. Operating Point Analysis
  op
  let id_op = -i(Vds)
  let power_op = id_op * 1.8
  print id_op power_op

  * 2. DC Sweep for Vth and gm
  dc Vgs 0 1.8 0.01
  * Find Vth at constant current Id = 1uA (for W/L=10)
  meas dc vth_meas find v(LABEL_NET_0) when i(Vds)=-1u cross=1
  
  * Calculate gm
  let gm_vec = deriv(-i(Vds))
  meas dc gm_at_bias find gm_vec at=0.9
  meas dc gm_max max gm_vec

  * 3. DC Sweep for Output Resistance (ro)
  dc Vds 0 1.8 0.01
  let gds_vec = deriv(-i(Vds))
  let ro_vec = 1 / gds_vec
  meas dc ro_at_bias find ro_vec at=1.8

  quit
.endc
.end