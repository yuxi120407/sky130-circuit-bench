* VCO Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param C_val=1p
.param L_m=0.5

.param W_m=50.0 L_m=0.15
.param L_val=0.001 C_val=7.8p

* Power supplies
VCC VCC 0 1.8
VEE VEE 0 0
Vtune Vtune 0 0.9
VVBB VBB 0 0.75

* DUT with missing values filled and NPN mapped to NMOS
L1 VCC OUT- {L_val}
L2 VCC OUT+ {L_val}
CR1 OUT- Vtune {C_val}
CR2 OUT+ Vtune {C_val}
M1 OUT- VBB N_Q1 VEE sky130_fd_pr__nfet_01v8 W={W_m} L={L_m}
M2 OUT+ VBB N_Q2 VEE sky130_fd_pr__nfet_01v8 W={W_m} L={L_m}
M3 N_Q1 N_BIAS VEE VEE sky130_fd_pr__nfet_01v8 W={W_m} L={L_m}
M4 N_Q2 N_BIAS VEE VEE sky130_fd_pr__nfet_01v8 W={W_m} L={L_m}
I1 VCC N_I1 1m
M5 VCC N_I1 N_BIAS VEE sky130_fd_pr__nfet_01v8 W=10.0 L={L_m}
M6 N_I1 N_BIAS VEE VEE sky130_fd_pr__nfet_01v8 W=10.0 L={L_m}
C1 N_Q1 VCC 2.793p
C2 N_Q2 VCC 2.793p
C3a N_Q1 N_Q2 2.497p
C3b N_Q1 N_Q2 2.497p

* Damping resistor to prevent infinite Q in AC analysis
R_tank OUT+ OUT- 1k

* AC stimulus for resonance measurement
Iac OUT- OUT+ AC 1

.control
  op
  let power = -i(VCC) * 1.8
  print power
  
  ac dec 100 100Meg 10Gig
  meas ac res_freq max_at v(OUT+)
  
  tran 10p 10n
  meas tran v_max max v(OUT+)
  
  quit
.endc
.end