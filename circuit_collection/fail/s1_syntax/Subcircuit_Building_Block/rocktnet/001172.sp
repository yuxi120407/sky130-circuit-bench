* Single NMOS Characterization Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

.param W_xm1=5.0 L_xm1=0.5
XM1 N6 LABEL_NET_5 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

VGS LABEL_NET_5 GND DC 0.9 AC 1
VDS N6 GND DC 0.9

.control
  * 1. DC Sweep for Vth and gm
  dc VGS 0 1.8 0.01
  let id_drain = -i(VDS)
  meas dc vth_meas when id_drain=10u
  let gm_deriv = deriv(id_drain)
  meas dc gm_meas find gm_deriv at=0.9
  
  * 2. DC Sweep for ro
  dc VDS 0 1.8 0.01
  let id_drain2 = -i(VDS)
  let gds_deriv = deriv(id_drain2)
  meas dc gds_meas find gds_deriv at=0.9
  let ro_meas = 1 / gds_meas
  let intrinsic_gain = gm_meas * ro_meas
  print ro_meas intrinsic_gain
  
  * 3. AC Analysis for fT
  ac dec 10 1Meg 100G
  let current_gain = mag(i(VDS)/i(VGS))
  meas ac fT_meas when current_gain=1 fall=1
  
  quit
.endc
.end