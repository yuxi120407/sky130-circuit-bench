* PMOS Current Source Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5

.param W_xm1=5.0 L_xm1=0.5
XM1 N1 I_IN VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm1} w={W_xm1}

VVDD VDD 0 1.8
V_I_IN I_IN 0 DC 0.9 PULSE(1.8 0.9 1n 0.1n 0.1n 10n 20n)
V_N1 N1 0 DC 0.9

.control
  * Transient Analysis for Switching Delay
  tran 10p 20n
  let id_tran = i(V_N1)
  meas tran Settling_Time trig v(I_IN) val=1.35 fall=1 targ id_tran val=0.3u rise=1
  print Settling_Time

  * Sweep V_I_IN to find Vth and gm
  dc V_I_IN 1.8 0 -0.01
  let id_sweep = abs(i(V_N1))
  meas dc vth_v_in find v(I_IN) when id_sweep=1u
  let Vth = 1.8 - vth_v_in
  
  meas dc I_out find id_sweep at=0.90
  meas dc id_890 find id_sweep at=0.89
  let gm = (id_890 - I_out)/0.01
  
  print Vth gm I_out

  * Sweep V_N1 to find Rout
  dc V_N1 0 1.8 0.01
  let id_rout = abs(i(V_N1))
  meas dc id_n1_900 find id_rout at=0.9
  meas dc id_n1_800 find id_rout at=0.8
  let Rout = 0.1 / (id_n1_800 - id_n1_900)
  
  print Rout
  
  quit
.endc
.end