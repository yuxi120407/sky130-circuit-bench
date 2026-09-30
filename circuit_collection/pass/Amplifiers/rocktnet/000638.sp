* Cascode Differential Amplifier Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Generic NPN model for high-speed simulation
.model npn npn (is=1e-16 bf=100 cjc=10f cje=10f tf=10p)

* Power supplies and bias (3.3V required for headroom of the cascode stack)
VVDD VDD 0 3.3
VIBUF IBUF 0 0.8

* Input signals (Common mode = 1.8V, AC = 1V diff, Tran = 200mVpp diff at 1GHz)
VDINP DINP 0 dc 1.8 ac 0.5 sin(1.8 0.05 1G)
VDINN DINN 0 dc 1.8 ac -0.5 sin(1.8 -0.05 1G)

* Dependent source for differential output measurement
E1 OUT_DIFF 0 OUTP OUTN 1

* DUT
Q1 N_E_LEFT IBUF N_Q1_E npn
Q2 N_BIAS N_BIAS N_Q2_E npn
Q3 N_Q7_E DINN N_E_RIGHT npn
Q4 N_R2 N_Q7_B N_Q7_E npn
Q5 VDD VDD N_BIAS npn
Q6 IBUF IBUF N_Q6_E npn
Q7 N_R2 N_Q7_B N_Q7_E npn
Q8 N_E_RIGHT IBUF N_Q8_E npn
Q9 N_E_LEFT IBUF N_Q9_E npn
Q10 N_R4 N_Q15_B N_Q15_E npn
Q11 N_Q15_E DINP N_E_LEFT npn
Q12 N_Q7_E DINN N_E_RIGHT npn
Q13 N_E_RIGHT IBUF N_Q13_E npn
Q14 N_Q15_E DINP N_E_LEFT npn
Q15 N_R4 N_Q15_B N_Q15_E npn
Q16 N_Q16_C IBUF N_Q16_E npn
R1 N_Q8_E GND 30
R2 VDD N_R2 55
R3 N_Q6_E GND 30
R4 VDD N_R4 55
R5 N_Q13_E GND 30
R6 N_Q9_E GND 30
R7 N_Q1_E GND 30
R8 N_BIAS N_Q7_B 5
R9 N_Q16_E GND 30
R10 N_Q2_E N_Q16_C 90
R11 N_BIAS N_Q15_B 5
R12 N_R4 OUTN 5
R13 N_R2 OUTP 5
R14 N_E_LEFT N_MID 10
R15 N_MID N_E_RIGHT 10
C1 N_BIAS GND 1.1p

.control
  * DC Operating Point
  op
  let power = -i(VVDD) * 3.3
  print power
  print v(OUTP) v(OUTN) v(N_BIAS) v(N_E_LEFT) v(N_E_RIGHT)

  * AC Analysis
  ac dec 100 1M 100G
  let gain_db = vdb(OUT_DIFF)
  meas ac dc_gain find gain_db at=1M
  let gain_3db = dc_gain - 3
  meas ac bw_3db when gain_db=$&gain_3db fall=1

  * Transient Analysis
  tran 1p 5n
  meas tran vout_max max v(OUT_DIFF)
  meas tran vout_min min v(OUT_DIFF)
  let vout_pp = vout_max - vout_min
  print vout_pp

  quit
.endc
.end