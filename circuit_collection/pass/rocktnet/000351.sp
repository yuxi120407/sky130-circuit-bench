* CML D-Latch Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.model npn npn (bf=100 is=1e-16 vaf=50 cje=10f cjc=10f tf=10p)

* DUT
Q1 N_Q1_C LO_P N_M1_D npn
Q2 N_Q2_C LO_N N_M1_D npn
Q9 N_Q9_C LO_N N_M2_D npn
Q3 N_Q3_C LO_P N_M2_D npn
Q11 I_P D_P N_Q1_C npn
Q6 I_N D_N N_Q1_C npn
Q7 I_P Q_P N_Q2_C npn
Q4 I_N Q_N N_Q2_C npn
Q12 Q_P I_P N_Q9_C npn
Q5 Q_N I_N N_Q9_C npn
Q8 Q_P D_P N_Q3_C npn
Q10 Q_N D_N N_Q3_C npn
R3 I_P N_TOP 35k
R4 I_N N_TOP 35k
R1 Q_P N_TOP 35k
R2 Q_N N_TOP 35k
R5 N_TOP VDD 24.6k

* Tail currents
I1 N_M1_D 0 5u
I2 N_M2_D 0 5u

* Supplies and Inputs
VVDD VDD 0 1.8
* Clock (LO) at 200MHz, biased at 0.76V
VLO_P LO_P 0 dc 0.76 pulse(0.66 0.86 0 100p 100p 2.4n 5n)
VLO_N LO_N 0 dc 0.76 pulse(0.86 0.66 0 100p 100p 2.4n 5n)
* Data (D) at 66.6MHz, biased at 1.46V, shifted by 1ns to transition during transparent phase
VD_P D_P 0 dc 1.46 pulse(1.36 1.56 1n 100p 100p 7.4n 15n)
VD_N D_N 0 dc 1.46 pulse(1.56 1.36 1n 100p 100p 7.4n 15n)

.control
tran 10p 30n

* Power Measurement
let power = -i(VVDD)*1.8
meas tran power_consumption avg power from=10n to=30n
print power_consumption

* Voltage Swing Measurement
meas tran v_I_P_max max v(I_P) from=10n to=30n
meas tran v_I_P_min min v(I_P) from=10n to=30n
let output_voltage_swing = v_I_P_max - v_I_P_min
print output_voltage_swing

* Propagation Delay Measurement (Data to Output)
meas tran propagation_delay trig v(D_P) val=1.46 rise=1 td=15.5n targ v(I_P) val=1.46 fall=1 td=15.5n
print propagation_delay

quit
.endc
.end