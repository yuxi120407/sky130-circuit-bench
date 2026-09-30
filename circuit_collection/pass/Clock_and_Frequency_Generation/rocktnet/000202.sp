* VCO Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt
.model npn npn (is=1e-16 bf=100)

VCC VCC 0 1.8
VEE VEE 0 0
Vctrl1 Free_Running_Frequency_Control 0 0.9
Vctrl2 from_LPF 0 0.9

* Populated passive components
C1 N2 N13 1p
R1 N31 VEE 200
R2 N3 VCC 500
R3 N18 VCC 500
R4 N0 VCC 500
R5 N26 VEE 200
R6 N22 VEE 200
R7 N23 VEE 200
R8 N3 N7 100
R9 N9 VCC 500
R10 N31 VEE 200
R11 N33 VEE 200
R12 N9 N16 100
R13 N27 VEE 200
R14 N41 VEE 200
R15 N41 VEE 200

* DUT Transistors
Q1 VCC N0 OUT_minus npn
Q2 N13 N25 N11 npn
Q3 N10 N7 N12 npn
Q4 N0 N0 N10 npn
Q5 N7 N2 N8 npn
Q6 VCC N18 N2 npn
Q7 N11 Free_Running_Frequency_Control N22 npn
Q8 N2 N6 N11 npn
Q9 N8 Free_Running_Frequency_Control N23 npn
Q10 N4 Free_Running_Frequency_Control N41 npn
Q11 OUT_minus OUT_minus N28 npn
Q12 N12 Free_Running_Frequency_Control N41 npn
Q13 N35 Free_Running_Frequency_Control N33 npn
Q14 N11 Free_Running_Frequency_Control N26 npn
Q15 N16 N13 N8 npn
Q16 VCC N18 OUT_plus npn
Q17 N2 N2 N15 npn
Q18 N25 from_LPF N11 npn
Q19 N28 Free_Running_Frequency_Control N27 npn
Q20 N14 Free_Running_Frequency_Control N31 npn
Q21 N18 N18 N1 npn
Q22 N3 N16 N4 npn
Q23 N1 N16 N12 npn
Q24 OUT_plus OUT_plus N35 npn
Q25 VCC VCC N25 npn
Q26 VCC N0 N13 npn
Q27 N6 from_LPF N11 npn
Q28 VCC VCC N6 npn
Q29 N13 N13 N14 npn
Q30 N9 N7 N4 npn
Q31 N15 Free_Running_Frequency_Control N31 npn

.control
  * DC Operating Point for Power
  op
  let power = -i(VCC) * 1.8
  print power

  * Transient Analysis for Oscillation
  tran 1p 5n
  meas tran v_max max v(OUT_plus)
  meas tran v_min min v(OUT_plus)
  let v_swing = v_max - v_min
  print v_swing

  * Measure Frequency (assuming DC level is around 1.0V)
  meas tran t1 trig v(OUT_plus) val=1.0 rise=1 targ v(OUT_plus) val=1.0 rise=2
  let freq = 1 / t1
  print freq
  quit
.endc
.end
