* CML Buffer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.param L_n=0.5

* Power Supplies
V1 VCC 0 DC 1.8
V2 VEE 0 DC -1.8

* Input Signals
VCM n_cm 0 DC 1.7
VAC n_ac 0 DC 0 AC 1 SIN(0 0.1 1G)
E1 IN n_cm n_ac 0 0.5
E2 I n_cm n_ac 0 -0.5

* Differential Output
Eout out 0 Q QN 1.0

* DUT Resistors (Sized for 1.8V CMOS operation)
R1 N4 VCC 1.3k
R2 N4 N17 1
R3 VCC N9 200
R4 VCC QN 200
R5 Q VCC 200
R6 N0 VEE 1.2k
R7 VCC N12 200
R8 N13 VEE 1
R9 VEE N18 1
R10 VEE N20 1
R11 VCC N10 1.3k
R12 N5 VEE 1.2k
R13 N11 VEE 700
R14 N15 VEE 1
R15 N1 VEE 1.2k
R16 N8 VEE 700
R17 N2 VEE 1.2k
R18 N4 Iout 1G

* DUT Transistors (Mapped from NPN to SKY130 NMOS)
.param W_n=50.0 L_n=0.15
XQ1 N19 N10 N20 VEE sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
XQ2 N14 N17 N13 VEE sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
XQ3 N17 N17 N18 VEE sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
XQ4 VCC IN N5 VEE sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
XQ5 N10 N10 N15 VEE sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
XQ6 VCC I N0 VEE sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
XQ7 VCC N1 N11 VEE sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
XQ8 Q N8 N14 VEE sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
XQ9 VCC N9 N1 VEE sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
XQ10 VCC N2 N8 VEE sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
XQ11 VCC N12 N2 VEE sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
XQ12 QN N11 N14 VEE sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
XQ13 N12 N0 N19 VEE sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}
XQ14 N9 N5 N19 VEE sky130_fd_pr__nfet_01v8 W={W_n} L={L_n}

.control
  * DC Operating Point
  op
  let power_consumption = (-i(V1) * 1.8) + (i(V2) * 1.8)
  print power_consumption

  * AC Analysis
  ac dec 20 1Meg 100G
  let gain_db = db(v(out))
  meas ac voltage_gain find gain_db at=1Meg
  meas ac bandwidth when gain_db='voltage_gain-3' fall=1

  * Transient Analysis
  tran 5p 5n
  meas tran v_max max v(out) from=2.5n to=5n
  meas tran v_min min v(out) from=2.5n to=5n
  let output_swing = v_max - v_min
  print output_swing
  meas tran delay trig v(n_ac) val=0 rise=1 td=2.5n targ v(out) val=0 fall=1 td=2.5n

  quit
.endc
.end