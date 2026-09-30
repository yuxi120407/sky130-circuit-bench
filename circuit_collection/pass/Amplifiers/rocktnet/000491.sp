* CML Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_diff=0.5
.param L_tail=0.5

.param W_diff=20.0 L_diff=0.15
.param W_tail=40.0 L_tail=0.15
.param R_load=300 R_tail=300

* Power Supply
VVDD VDD 0 1.8

* AC Coupled Inputs (Differential 1V AC, 0.2V peak transient)
VIN_AC IN_AC 0 DC 0 AC 0.5 180 SIN(0 0.1 100MEG 0 0 180)
VIP_AC IP_AC 0 DC 0 AC 0.5 0 SIN(0 0.1 100MEG 0 0 0)
CIN IN_AC IN 1u
CIP IP_AC IP 1u

* Circuit Netlist (NPNs mapped to NMOS)
R1 N2 VDD 1
R2 IN N2 50
R3 N4 VDD {R_load}
R4 IP N2 50
R5 VDD N6 10k
R6 N6 0 5k
R7 VDD N9 {R_load}
XM1 N4 IP N8 0 sky130_fd_pr__nfet_01v8 W={W_diff} L={L_diff}
R8 N3 0 {R_tail}
XM3 N8 N10 N3 0 sky130_fd_pr__nfet_01v8 W={W_tail} L={L_tail}
XM2 N9 IN N8 0 sky130_fd_pr__nfet_01v8 W={W_diff} L={L_diff}
E1 N10 0 N6 N3 1000

* Load Capacitors
CL1 N4 0 10f
CL2 N9 0 10f

* Differential Output and Input for Measurement
E_out_diff OUT_DIFF 0 N4 N9 1
E_in_diff IN_DIFF 0 IP IN 1

.control
  * DC Operating Point
  op
  let power_consumption = -i(VVDD) * 1.8
  print power_consumption

  * AC Analysis
  ac dec 50 1MEG 100G
  let gain_db = vdb(OUT_DIFF)
  meas ac voltage_gain find gain_db at=10MEG
  let gain_3db = voltage_gain - 3
  meas ac bandwidth_3db when gain_db=gain_3db fall=1

  * Transient Analysis
  tran 10p 30n
  meas tran vout_max max v(OUT_DIFF)
  meas tran vout_min min v(OUT_DIFF)
  let output_swing = vout_max - vout_min
  print output_swing

  quit
.endc
.end