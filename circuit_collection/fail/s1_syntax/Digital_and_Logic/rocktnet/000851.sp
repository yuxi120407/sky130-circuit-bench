* High-Bit-Rate Low-Power Decision Circuit Testbench
.param VDD=1.8
.param VREF=0.9

* SKY130 Models
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* BJT to MOSFET wrappers for SKY130 compatibility
.subckt npn c b e
XM1 c b e VEE sky130_fd_pr__nfet_01v8 w=5.0 l=0.15
.ends
.subckt pnp c b e
XM1 c b e GND sky130_fd_pr__pfet_01v8 w=10.0 l=0.15
.ends

* Power Supplies (GND is VDD in this topology, VEE is VSS)
V_GND GND 0 {VDD}
V_VEE VEE 0 0

* Biases (DC acts as the reference voltage for single-ended inputs)
V_DC DC 0 VREF
V_VCS VCS 0 VREF

* Inputs (DT = Data, CC = Clock)
V_DT DT 0 PULSE(0.6 1.2 0 20p 20p 480p 1n)
V_CC CC 0 PULSE(0.6 1.2 0 20p 20p 230p 500p)

* DUT (Original Netlist with Resistor Values Appended)
R1 N2 GND 1k
R2 N2 N4 1k
Q1 GND N1 QT npn
R3 N8 N15 1k
R4 N3 N13 1k
R5 N0 N1 1k
R6 QT QC 10k
R7 VEE N17 1k
R8 N13 N2 1k
R9 N6 VEE 1k
R10 GND N15 1k
R11 QC QT 10k
R12 N0 N15 1k
R13 VEE N5 500
Q2 N2 N17 N21 npn
Q3 GND N3 N17 npn
Q4 N8 N17 N20 npn
Q5 N1 N6 N20 npn
Q6 N13 N6 N21 npn
Q7 GND N8 QC npn
Q8 N10 N5 N11 npn
R14 N11 VEE 500
Q9 N3 DC N22 npn
Q10 N15 QT N23 npn
Q11 N9 VCS N5 npn
Q12 N4 DT N22 npn
Q13 N22 DC N9 npn
Q14 N6 CC N9 npn
Q15 N0 QC N23 npn
Q16 N6 N4 GND pnp
Q17 N10 CC N6 pnp
Q18 N10 CC QC pnp

* Control Block
.control
  * DC Operating Point for Power
  op
  let power = -i(V_GND) * 1.8
  print power

  * Transient Analysis for Delay and Swing
  tran 10p 5n
  
  meas tran v_max_qt max v(QT)
  meas tran v_min_qt min v(QT)
  let v_swing = v_max_qt - v_min_qt
  print v_swing

  * Clock to Q Delay (measured from Clock crossing VREF to Output crossing VREF)
  meas tran t_delay trig v(CC) val=0.9 rise=2 targ v(QT) val=0.9 rise=1
  
  quit
.endc
.end