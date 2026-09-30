* Testbench for Bias Circuit
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5

XM1 V_B V_CM GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 V_B V_B VDD VDD sky130_fd_pr__pfet_01v8 l={L_xm2} w={W_xm2}

VVDD VDD 0 1.8
VCM V_CM 0 dc 0.6 ac 1

.control
  op
  let DC_Current = -i(VVDD)
  print DC_Current

  dc VCM 0 1.8 0.01
  meas dc DC_Output_Voltage find v(V_B) at=0.6

  ac dec 10 1 1G
  let gain_db = db(v(V_B))
  meas ac Small_Signal_Gain find gain_db at=10
.endc
.end