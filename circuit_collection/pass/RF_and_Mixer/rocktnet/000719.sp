* Double-Balanced Mixer Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

.param VCC_val=1.8
.param f_rf=1G
.param f_lo=0.9G
.param f_if=0.1G

V1 VCC GND dc 'VCC_val'
Vbias1 BIAS1 GND dc 0.8
Vbias2 BIAS2 GND dc 1.4
Vbias3 BIAS3 GND dc 0.8
Vbias4 BIAS4 GND dc 0.8

Vlo_cm LO_CM GND dc 1.5
Vlo_p LO_IN+ LO_CM dc 0 sin(0 0.3 'f_lo' 0 0 0)
Vlo_n LO_IN- LO_CM dc 0 sin(0 0.3 'f_lo' 0 0 180)

Vrf_cm RF_CM GND dc 0
Vrf_p RF_IN+ RF_CM dc 0 sin(0 0.01 'f_rf' 0 0 0)
Vrf_n RF_IN- RF_CM dc 0 sin(0 0.01 'f_rf' 0 0 180)

.model npn npn is=1e-16 bf=100 tf=10p cje=10f cjc=10f vaf=50

Q1 VCC LO_IN+ N1 npn
Q2 VCC LO_IN- N2 npn
Q3 VCC N1 N3 npn
Q4 VCC N2 N4 npn
Q5 N5 N9 N11 npn
Q6 N6 N10 N12 npn
Q7 OUT- N7 N5 npn
Q8 OUT+ N8 N5 npn
Q9 OUT- N8 N6 npn
Q10 OUT+ N7 N6 npn
Q11 N13 BIAS3 N14 npn
Q12 N1 BIAS1 N15 npn
Q13 N2 BIAS1 N16 npn
Q14 N3 BIAS1 N17 npn
Q15 N4 BIAS1 N18 npn
R1 N1 N2 1k
R2 N7 N8 1k
R3 VCC OUT- 500
R4 VCC OUT+ 500
R5 N11 N13 20
R6 N12 N13 20
R7 N9 BIAS4 10k
R8 N10 BIAS4 10k
R9 N7 BIAS2 10k
R10 N8 BIAS2 10k
R11 N14 GND 50
R12 N15 GND 50
R13 N16 GND 50
R14 N17 GND 50
R15 N18 GND 50
C1 N3 N7 1p
C2 N4 N8 1p
C3 RF_IN+ N9 1p
C4 RF_IN- N10 1p
C5 VCC OUT- 2p
C6 VCC OUT+ 2p
Cbyp1 BIAS1 GND 10p
Cbyp2 BIAS2 GND 10p
Cbyp3 BIAS3 GND 10p
Cbyp4 BIAS4 GND 10p

B1 OUT_DIFF 0 V=V(OUT+)-V(OUT-)

.control
tran 0.1n 50n
meas tran out_max max v(OUT_DIFF) from=30n to=50n
meas tran out_min min v(OUT_DIFF) from=30n to=50n
let out_pp = out_max - out_min
* RF input is 10mV peak each, so 20mV peak diff, 40mV pp diff.
let cg = out_pp / 0.04
let cg_db = 20 * log10(cg)
print cg_db

op
let power = -i(V1) * 1.8
print power
quit
.endc
.end