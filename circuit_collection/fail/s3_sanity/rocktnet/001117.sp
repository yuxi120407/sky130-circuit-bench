* W-CDMA Baseband Filter Testbench
.lib "/home/idies/workspace/Temporary/xyu1/scratch/skywater-pdk-libs-sky130_fd_pr/combined_models/sky130.lib.spice" tt

* Generic BJT model to support the extracted 'npn' instances
.model npn npn (is=1e-16 bf=100 vaf=50)

* Supplies and Biases
Vcc Vcc 0 3.3
VVBIAS Vbias 0 1.2
Vbias2 N10 0 2.4
Vbias3 N21 0 0.8
Vbias4 N23 0 0.8
Vbias5 N18 0 0.8

* AC and Transient Inputs (AC coupled)
Vinp in_p 0 dc 0 ac 0.5 sin(0 0.01 1Meg)
Vinn in_n 0 dc 0 ac -0.5 sin(0 -0.01 1Meg)
Cin1 in_p N1 1u
Cin2 in_n N3 1u

* Differential Output VCVS for easy measurement
Ediff out_diff 0 out outx 1

* DUT (with added typical values for R and C to enable simulation)
Q1 N20 Vbias N22 npn
Q2 Vcc N9 out npn
R6 N19 GND 1k
Q3 N9 N5 N16 npn
Q5 N12 N23 N19 npn
R2 N22 GND 1k
Q4 Vcc N18 N11 npn
Q6 Vcc N8 outx npn
Q7 outx N15 N0 npn
Q8 N2 N21 N13 npn
R3 Vcc N20 1k
R4 N14 GND 1k
R5 Vcc N9 1k
R10 N11 GND 1k
R7 N13 GND 1k
Q9 N16 N10 N14 npn
R9 N15 GND 1k
R8 N0 GND 1k
Q10 N8 N4 N16 npn
Q11 out N14 N15 npn
R1 N5 Vcc 10k
Q12 Vcc N1 N12 npn
R11 Vcc N8 1k
Q13 Vcc N3 N2 npn
R12 N3 N20 10k
C1 N1 N3 5p
R13 N4 Vcc 10k
R14 N1 N20 10k
C2 N3 N1 5p
C3 N2 N5 10p
C4 N1 GND 5p
C5 N3 GND 5p
C6 N4 N12 10p

.control
* DC Operating Point
op
let DC_Power = -i(Vcc) * 3.3
print DC_Power

* AC Analysis
ac dec 20 10k 100Meg
let gain_db = db(v(out_diff))
meas ac Low_Freq_Gain find gain_db at=100k
print Low_Freq_Gain
meas ac Gain_1_92MHz find gain_db at=1.92Meg
print Gain_1_92MHz

* Transient Analysis
tran 10n 5u
meas tran vout_max max v(out_diff)
meas tran vout_min min v(out_diff)
let Transient_Swing = vout_max - vout_min
print Transient_Swing

quit
.endc
.end