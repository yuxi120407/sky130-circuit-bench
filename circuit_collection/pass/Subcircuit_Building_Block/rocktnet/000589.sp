* Single NMOS Characterization Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param W_xm1=5.0 L_xm1=0.5

* DUT
XM1 NET3 NET2 NET4 GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}

* Voltage Sources and Load
VVDD VDD 0 DC 1.8
VVCONTROL NET2 0 DC 0.9 AC 1
RLOAD VDD NET3 1k
VN4 NET4 0 DC 0

.control
  * DC Sweep for Id, Vth, gm
  dc VVCONTROL 0 1.8 0.01
  let id_sweep = -i(VVDD)
  
  meas dc Id find id_sweep at=0.9
  print Id
  
  meas dc Vth find v(NET2) when id_sweep=1u
  print Vth
  
  let gm_vec = deriv(id_sweep)
  meas dc gm find gm_vec at=0.9
  print gm

  * AC Analysis for Voltage Gain
  ac dec 10 1 1Meg
  let gain_db = db(v(NET3))
  meas ac Voltage_Gain find gain_db at=1k
  print Voltage_Gain

  quit
.endc
.end