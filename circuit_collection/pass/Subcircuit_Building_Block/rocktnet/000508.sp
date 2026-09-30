* FGMOS Transconductor NMOS Array Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_xm1=0.5
.param L_xm2=0.5
.param L_xm3=0.5

.param W_xm1=5.0 L_xm1=0.5
.param W_xm2=5.0 L_xm2=0.5
.param W_xm3=5.0 L_xm3=0.5

XM1 IP N3 GND GND sky130_fd_pr__nfet_01v8 l={L_xm1} w={W_xm1}
XM2 IN N0 GND GND sky130_fd_pr__nfet_01v8 l={L_xm2} w={W_xm2}
XM3 IC N2 GND GND sky130_fd_pr__nfet_01v8 l={L_xm3} w={W_xm3}

* Supply and Drain Bias
V_IP IP 0 DC 1.8
V_IN IN 0 DC 1.8
V_IC IC 0 DC 1.8

* Gate Bias (Weak Inversion Region)
V_N3 N3 0 DC 0.3
V_N0 N0 0 DC 0.3
V_N2 N2 0 DC 0.3

.control
  * 1. Operating Point for Power Consumption
  op
  let id1_op = -i(V_IP)
  let id2_op = -i(V_IN)
  let id3_op = -i(V_IC)
  let total_power = (id1_op + id2_op + id3_op) * 1.8
  print id1_op id2_op id3_op total_power

  * 2. DC Sweep for Weak Inversion Metrics (gm/Id)
  * Sweeping gate voltage from deep subthreshold to near threshold
  dc V_N3 0.1 0.6 0.01
  
  let id1_dc = -i(V_IP)
  * Calculate transconductance (derivative of Id w.r.t sweep variable V_N3)
  let gm1_dc = deriv(id1_dc)
  * Calculate gm/Id efficiency
  let gm_id1 = gm1_dc / id1_dc
  
  * Extract metrics
  meas dc gm_id_max max gm_id1
  meas dc id_at_03V find id1_dc at=0.3
  meas dc gm_at_03V find gm1_dc at=0.3
  meas dc gm_id_at_03V find gm_id1 at=0.3
  
  print gm_id_max id_at_03V gm_id_at_03V
.endc
.end
