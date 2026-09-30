* ECL 2:1 MUX Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param Rload=400 Rtail=400 Rout=2k Rdeg=100

* DUT Netlist
Q1 N1 A_P N3 npn
Q2 N3 N5 N7 npn
Q3 N2 B_N N4 npn
Q4 N2 A_N N3 npn
Q5 GND VC_N N6 npn
Q6 N4 N6 N8 npn
Q7 N8 BIAS N12 npn
Q8 N7 BIAS N11 npn
Q9 N5 BIAS N9 npn
Q10 N6 BIAS N10 npn
Q11 GND N1 OUT_P npn
Q12 N1 B_P N4 npn
Q13 GND N2 OUT_N npn
Q14 GND VC_P N5 npn
R1 GND N1 Rload
R2 GND N2 Rload
R3 N9 VEE Rtail
R4 N10 VEE Rtail
R5 N11 VEE Rtail
R6 N12 VEE Rtail
R7 OUT_N VEE Rout
R8 OUT_P VEE Rout
R9 N7 N8 Rdeg

* Generic high-speed NPN model for simulation
.model npn npn(is=1e-16 bf=100 vaf=50 cjc=10f cje=10f tf=10p)

* Power Supplies
V_GND GND 0 0
V_VEE VEE 0 -3.3
V_BIAS BIAS 0 -2.1

* Inputs
* VC selects Data A (VC_P > VC_N)
V_VCP VC_P 0 -1.0
V_VCN VC_N 0 -1.4

* Data B (Unselected, held constant)
V_BP B_P 0 -1.4
V_BN B_N 0 -1.0

* Data A (Selected, pulsed to measure delay)
V_AP A_P 0 PULSE(-1.4 -1.0 100p 20p 20p 400p 1n)
V_AN A_N 0 PULSE(-1.0 -1.4 100p 20p 20p 400p 1n)

.control
  * DC Operating Point for Power
  op
  let power = -i(V_VEE) * 3.3
  print power

  * Transient Analysis for Delay and Swing
  tran 1p 2n
  
  meas tran v_out_max max v(OUT_N)
  meas tran v_out_min min v(OUT_N)
  let vswing = v_out_max - v_out_min
  print vswing

  * Delay from A_P to OUT_P (Inverting path)
  meas tran delay_data trig v(A_P) val=-1.2 rise=1 targ v(OUT_P) val=-1.2 fall=1
  
  * Rise and fall times of OUT_N (approx 20% to 80% of 800mV swing)
  meas tran t_rise trig v(OUT_N) val=-1.4 rise=1 targ v(OUT_N) val=-1.0 rise=1
  meas tran t_fall trig v(OUT_N) val=-1.0 fall=1 targ v(OUT_N) val=-1.4 fall=1
  
  quit
.endc
.end
