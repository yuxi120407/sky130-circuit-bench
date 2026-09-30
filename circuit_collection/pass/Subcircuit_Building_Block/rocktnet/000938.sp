* PMOS Shunt Characterization
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

.param W_xm1=5.0 L_xm1=0.5

XM1 GND VSUM VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}

VVDD VDD 0 1.8
VVSUM VSUM 0 1.8

.control
  dc VVSUM 0 1.8 0.01
  let id = -i(VVDD)
  let gm = -deriv(id)
  
  meas dc I_on find id at=0
  meas dc Vth_vsum when id=1u
  meas dc gm_max max gm
  
  print I_on Vth_vsum gm_max
  quit
.endc
.end